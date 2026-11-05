import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_exception.dart';
import '../data/diagnosis_repository.dart';
import '../data/models/diagnosis.dart';

enum DiagnosisStatus {
  /// No photo yet.
  pickingPhoto,

  /// Photo chosen, waiting for "Check".
  ready,
  sending,
  done,
  failed,
}

class DiagnosisState extends Equatable {
  const DiagnosisState({
    this.status = DiagnosisStatus.pickingPhoto,
    this.imagePath,
    this.question = '',
    this.record,
    this.diagnosis,
    this.error,
  });

  final DiagnosisStatus status;
  final String? imagePath;
  final String question;

  /// Saved result, once [status] is done.
  final DiagnosisRecord? record;
  final Diagnosis? diagnosis;
  final ApiException? error;

  DiagnosisState copyWith({
    DiagnosisStatus? status,
    String? imagePath,
    String? question,
    DiagnosisRecord? record,
    Diagnosis? diagnosis,
    ApiException? Function()? error,
  }) {
    return DiagnosisState(
      status: status ?? this.status,
      imagePath: imagePath ?? this.imagePath,
      question: question ?? this.question,
      record: record ?? this.record,
      diagnosis: diagnosis ?? this.diagnosis,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    imagePath,
    question,
    record,
    diagnosis,
    error,
  ];
}

/// One "check this photo" session for one tree.
class DiagnosisCubit extends Cubit<DiagnosisState> {
  DiagnosisCubit({
    required this.treeId,
    required DiagnosisRepository repository,
  }) : _repository = repository,
       super(const DiagnosisState());

  final int treeId;
  final DiagnosisRepository _repository;
  CancelToken? _cancel;

  bool get isDemo => _repository.isDemo;

  void setPhoto(String path) => emit(
    state.copyWith(
      status: DiagnosisStatus.ready,
      imagePath: path,
      error: () => null,
    ),
  );

  void setQuestion(String text) => emit(state.copyWith(question: text));

  /// Sends the photo. [language], [location] and [outsideMinTempC] come from
  /// app settings and the weather forecast.
  Future<void> submit({
    required String language,
    String? location,
    double? outsideMinTempC,
  }) async {
    final path = state.imagePath;
    if (path == null || state.status == DiagnosisStatus.sending) return;

    _cancel = CancelToken();
    emit(state.copyWith(status: DiagnosisStatus.sending, error: () => null));
    try {
      final question = state.question.trim();
      final record = await _repository.diagnose(
        treeId: treeId,
        imagePath: path,
        language: language,
        question: question.isEmpty ? null : question,
        location: location,
        outsideMinTempC: outsideMinTempC,
        cancel: _cancel,
      );
      emit(
        state.copyWith(
          status: DiagnosisStatus.done,
          record: record,
          diagnosis: DiagnosisRepository.decode(record),
        ),
      );
    } on RequestCancelledException {
      if (!isClosed) emit(state.copyWith(status: DiagnosisStatus.ready));
    } on ApiException catch (e) {
      if (!isClosed) {
        emit(state.copyWith(status: DiagnosisStatus.failed, error: () => e));
      }
    }
  }

  void cancel() => _cancel?.cancel();

  @override
  Future<void> close() {
    _cancel?.cancel();
    return super.close();
  }
}
