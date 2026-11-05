import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/widgets/dialogs.dart';
import '../../../diagnosis/view/diagnosis_page.dart';
import '../../../fruit_types/cubit/fruit_types_cubit.dart';
import '../../../fruit_types/fruit_type_name.dart';
import '../../../journal/data/journal_repository.dart';
import '../../../journal/view/journal_labels.dart';
import '../../../records/view/harvest_form_page.dart';
import '../../../trees/data/tree_repository.dart';
import '../../../trees/view/tree_labels.dart';
import '../../../trees/view/tree_page.dart';

/// Opened by tapping a tree on the map: one tap to log care, harvest or a
/// photo, or open the full tree card.
///
/// [onMove] adds a "Move" button (used on the map).
Future<void> showTreeActionSheet(
  BuildContext context,
  Tree tree, {
  VoidCallback? onMove,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) =>
        _TreeActionSheet(tree: tree, hostContext: context, onMove: onMove),
  );
}

class _TreeActionSheet extends StatelessWidget {
  const _TreeActionSheet({
    required this.tree,
    required this.hostContext,
    this.onMove,
  });

  final Tree tree;
  final VoidCallback? onMove;

  /// The map page's context: still valid after the sheet closes.
  final BuildContext hostContext;

  Future<void> _log(BuildContext sheetContext, JournalKind kind) async {
    final l10n = AppLocalizations.of(hostContext);
    final journal = hostContext.read<JournalRepository>();
    Navigator.pop(sheetContext);
    final answer = await askJournalNote(hostContext, kind);
    if (answer == null) return;
    await journal.logForTree(tree, kind, note: answer.note);
    if (hostContext.mounted) {
      showSnack(
        hostContext,
        l10n.journalSaved('${kind.emoji} ${kind.label(l10n)}'),
      );
    }
  }

  Future<void> _photo(BuildContext sheetContext) async {
    final l10n = AppLocalizations.of(hostContext);
    final trees = hostContext.read<TreeRepository>();
    Navigator.pop(sheetContext);
    final picked = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1600,
      imageQuality: 80,
    );
    if (picked == null) return;
    await trees.addPhoto(tree.id, picked.path);
    if (hostContext.mounted) showSnack(hostContext, l10n.photoSaved);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final type = context.select(
      (FruitTypesCubit c) => c.state.byId(tree.fruitTypeId),
    );
    final theme = Theme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(type?.emoji ?? '🌳', style: const TextStyle(fontSize: 36)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        [
                          type?.localizedName(context) ?? '',
                          ?tree.variety,
                        ].join(' · '),
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(tree.stage.label(l10n)),
                    ],
                  ),
                ),
                FilledButton.tonalIcon(
                  onPressed: () {
                    Navigator.pop(context);
                    TreePage.open(hostContext, tree.id);
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: Text(l10n.treeOpenCard),
                ),
              ],
            ),
            const SizedBox(height: 16),
            JournalActionChips(
              kinds: JournalKind.values,
              onSelected: (kind) => _log(context, kind),
              extra: [
                ActionChip(
                  avatar: const Text('🧺'),
                  label: Text(l10n.harvestTitle),
                  onPressed: () {
                    Navigator.pop(context);
                    HarvestFormPage.open(hostContext, tree: tree);
                  },
                ),
                ActionChip(
                  avatar: const Text('🩺'),
                  label: Text(l10n.diagnosisAction),
                  onPressed: () {
                    Navigator.pop(context);
                    DiagnosisPage.open(hostContext, tree.id);
                  },
                ),
                ActionChip(
                  avatar: const Text('📷'),
                  label: Text(l10n.photoCamera),
                  onPressed: () => _photo(context),
                ),
                if (onMove != null)
                  ActionChip(
                    avatar: const Icon(Icons.open_with, size: 18),
                    label: Text(l10n.treeMove),
                    onPressed: () {
                      Navigator.pop(context);
                      onMove!();
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
