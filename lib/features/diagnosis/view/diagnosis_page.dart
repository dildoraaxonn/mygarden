import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../weather/cubit/weather_cubit.dart';
import '../cubit/diagnosis_cubit.dart';
import '../data/diagnosis_repository.dart';
import 'widgets/diagnosis_result_view.dart';

/// Plant doctor: take a photo of a sick leaf or fruit, get advice.
class DiagnosisPage extends StatelessWidget {
  const DiagnosisPage({super.key, required this.treeId});

  final int treeId;

  static Future<void> open(BuildContext context, int treeId) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => DiagnosisPage(treeId: treeId)),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiagnosisCubit(
        treeId: treeId,
        repository: context.read<DiagnosisRepository>(),
      ),
      child: const DiagnosisView(),
    );
  }
}

class DiagnosisView extends StatelessWidget {
  const DiagnosisView({super.key});

  Future<void> _pick(BuildContext context, ImageSource source) async {
    final cubit = context.read<DiagnosisCubit>();
    final picked = await ImagePicker().pickImage(
      source: source,
      // Big enough to see spots and pests, small enough to upload quickly.
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (picked != null) cubit.setPhoto(picked.path);
  }

  void _submit(BuildContext context) {
    final weather = context.read<WeatherCubit>().state;
    context.read<DiagnosisCubit>().submit(
      language: Localizations.localeOf(context).languageCode,
      location: '${weather.city.nameEn}, Uzbekistan',
      outsideMinTempC: weather.forecast?.coldest?.minC,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<DiagnosisCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.diagnosisTitle)),
      body: BlocBuilder<DiagnosisCubit, DiagnosisState>(
        builder: (context, state) {
          final sending = state.status == DiagnosisStatus.sending;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              if (cubit.isDemo) ...[_DemoBanner(), const SizedBox(height: 12)],
              if (state.imagePath == null) ...[
                Text(l10n.diagnosisPhotoTip),
                const SizedBox(height: 16),
                _PhotoButtons(onPick: (s) => _pick(context, s)),
              ] else ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(state.imagePath!),
                    height: 260,
                    fit: BoxFit.cover,
                    cacheWidth: 1000,
                  ),
                ),
                if (state.status != DiagnosisStatus.done) ...[
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: sending
                          ? null
                          : () => _pick(context, ImageSource.camera),
                      icon: const Icon(Icons.photo_camera_outlined),
                      label: Text(l10n.diagnosisChangePhoto),
                    ),
                  ),
                  TextField(
                    enabled: !sending,
                    minLines: 2,
                    maxLines: 4,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: l10n.diagnosisQuestion,
                      hintText: l10n.diagnosisQuestionHint,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: cubit.setQuestion,
                  ),
                  const SizedBox(height: 16),
                ],
              ],
              ..._statusSection(context, state),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _statusSection(BuildContext context, DiagnosisState state) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<DiagnosisCubit>();
    final checkButton = SizedBox(
      height: 52,
      child: FilledButton.icon(
        onPressed: () => _submit(context),
        icon: const Text('🩺', style: TextStyle(fontSize: 20)),
        label: Text(l10n.diagnosisCheck),
      ),
    );

    switch (state.status) {
      case DiagnosisStatus.pickingPhoto:
        return const [];
      case DiagnosisStatus.ready:
        return [checkButton];
      case DiagnosisStatus.sending:
        return [
          const SizedBox(height: 8),
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 12),
          Text(
            l10n.diagnosisSending,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(l10n.diagnosisSendingHint, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: cubit.cancel,
              child: Text(l10n.cancel),
            ),
          ),
        ];
      case DiagnosisStatus.failed:
        return [
          Card(
            color: Theme.of(context).colorScheme.errorContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(diagnosisErrorMessage(l10n, state.error!)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 52,
            child: FilledButton.icon(
              onPressed: () => _submit(context),
              icon: const Icon(Icons.refresh),
              label: Text(l10n.diagnosisRetry),
            ),
          ),
        ];
      case DiagnosisStatus.done:
        return [
          const SizedBox(height: 16),
          DiagnosisResultView(diagnosis: state.diagnosis!),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.check_circle_outline, size: 18),
              const SizedBox(width: 6),
              Expanded(child: Text(l10n.diagnosisSaved)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.diagnosisDone),
            ),
          ),
        ];
    }
  }
}

class _DemoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      color: scheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(Icons.science_outlined, color: scheme.onTertiaryContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                AppLocalizations.of(context).diagnosisDemoBanner,
                style: TextStyle(color: scheme.onTertiaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoButtons extends StatelessWidget {
  const _PhotoButtons({required this.onPick});

  final void Function(ImageSource source) onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 96,
            child: FilledButton.tonalIcon(
              onPressed: () => onPick(ImageSource.camera),
              icon: const Icon(Icons.photo_camera_outlined, size: 28),
              label: Text(l10n.photoCamera),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 96,
            child: FilledButton.tonalIcon(
              onPressed: () => onPick(ImageSource.gallery),
              icon: const Icon(Icons.photo_library_outlined, size: 28),
              label: Text(l10n.photoGallery),
            ),
          ),
        ),
      ],
    );
  }
}
