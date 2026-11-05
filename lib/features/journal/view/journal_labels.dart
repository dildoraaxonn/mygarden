import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/widgets/dialogs.dart';

extension JournalKindLabel on JournalKind {
  String get emoji => switch (this) {
    JournalKind.watered => '💧',
    JournalKind.fertilized => '🌿',
    JournalKind.sprayed => '🧴',
    JournalKind.pruned => '✂️',
    JournalKind.flowering => '🌸',
    JournalKind.problem => '⚠️',
    JournalKind.note => '📝',
  };

  String label(AppLocalizations l10n) => switch (this) {
    JournalKind.watered => l10n.journalWatered,
    JournalKind.fertilized => l10n.journalFertilized,
    JournalKind.sprayed => l10n.journalSprayed,
    JournalKind.pruned => l10n.journalPruned,
    JournalKind.flowering => l10n.journalFlowering,
    JournalKind.problem => l10n.journalProblem,
    JournalKind.note => l10n.journalNote,
  };
}

/// Diary actions that make sense for a whole greenhouse.
const plotJournalKinds = [
  JournalKind.watered,
  JournalKind.fertilized,
  JournalKind.sprayed,
  JournalKind.pruned,
  JournalKind.note,
];

/// Asks for a note where it helps (e.g. "which fertilizer?").
/// Returns null if the user cancelled.
Future<({String? note})?> askJournalNote(
  BuildContext context,
  JournalKind kind,
) async {
  final l10n = AppLocalizations.of(context);
  final hint = switch (kind) {
    JournalKind.fertilized || JournalKind.sprayed => l10n.journalProductHint,
    JournalKind.problem => l10n.journalProblemHint,
    JournalKind.note => l10n.journalNoteHint,
    _ => null,
  };
  if (hint == null) return (note: null);

  final text = await showTextInputDialog(
    context,
    title: '${kind.emoji} ${kind.label(l10n)}',
    hint: hint,
    multiline: kind == JournalKind.note || kind == JournalKind.problem,
  );
  if (text == null) return null;
  if (kind == JournalKind.note && text.isEmpty) return null;
  return (note: text.isEmpty ? null : text);
}

/// Big chips for logging diary events.
class JournalActionChips extends StatelessWidget {
  const JournalActionChips({
    super.key,
    required this.kinds,
    required this.onSelected,
    this.extra = const [],
  });

  final List<JournalKind> kinds;
  final void Function(JournalKind kind) onSelected;

  /// Extra chips shown after the diary ones (e.g. harvest, photo).
  final List<Widget> extra;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final kind in kinds)
          ActionChip(
            avatar: Text(kind.emoji),
            label: Text(kind.label(l10n)),
            onPressed: () => onSelected(kind),
          ),
        ...extra,
      ],
    );
  }
}
