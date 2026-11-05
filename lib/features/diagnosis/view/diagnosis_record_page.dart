import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/storage/photo_storage.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/dialogs.dart';
import '../data/diagnosis_repository.dart';
import 'widgets/diagnosis_result_view.dart';

/// A saved diagnosis from the tree's history.
class DiagnosisRecordPage extends StatelessWidget {
  const DiagnosisRecordPage({super.key, required this.record});

  final DiagnosisRecord record;

  static Future<void> open(BuildContext context, DiagnosisRecord record) =>
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DiagnosisRecordPage(record: record)),
      );

  Future<void> _delete(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final repository = context.read<DiagnosisRepository>();
    if (!await showConfirmDialog(context, title: l10n.recordDeleteTitle)) {
      return;
    }
    await repository.delete(record.id);
    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final storage = context.read<PhotoStorage>();
    final diagnosis = DiagnosisRepository.decode(record);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${l10n.diagnosisTitle} · ${formatDate(context, record.date)}',
        ),
        actions: [
          IconButton(
            tooltip: l10n.delete,
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _delete(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          if (record.photoFileName != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                storage.fileFor(record.photoFileName!),
                height: 260,
                fit: BoxFit.cover,
                cacheWidth: 1000,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
            ),
          if (record.question != null) ...[
            const SizedBox(height: 12),
            Text(
              l10n.diagnosisQuestion,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(record.question!),
          ],
          const SizedBox(height: 16),
          DiagnosisResultView(diagnosis: diagnosis),
        ],
      ),
    );
  }
}
