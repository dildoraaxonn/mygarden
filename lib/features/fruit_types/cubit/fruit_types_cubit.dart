import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../data/fruit_type_repository.dart';

class FruitTypesState extends Equatable {
  const FruitTypesState({this.loaded = false, this.types = const []});

  final bool loaded;
  final List<FruitType> types;

  FruitType? byId(int id) {
    for (final type in types) {
      if (type.id == id) return type;
    }
    return null;
  }

  @override
  List<Object?> get props => [loaded, types];
}

/// App-wide list of fruit types, used by almost every screen.
class FruitTypesCubit extends Cubit<FruitTypesState> {
  FruitTypesCubit(this._repository) : super(const FruitTypesState()) {
    _subscription = _repository.watchAll().listen(
      (types) => emit(FruitTypesState(loaded: true, types: types)),
    );
  }

  final FruitTypeRepository _repository;
  late final StreamSubscription<List<FruitType>> _subscription;

  Future<void> add({
    required String nameEn,
    required String nameRu,
    required String emoji,
    required int monthsToFruit,
  }) => _repository.add(
    nameEn: nameEn,
    nameRu: nameRu,
    emoji: emoji,
    monthsToFruit: monthsToFruit,
  );

  Future<void> save(FruitType type) => _repository.update(type);

  /// Returns false when the type is still used by trees.
  Future<bool> delete(int id) => _repository.delete(id);

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
