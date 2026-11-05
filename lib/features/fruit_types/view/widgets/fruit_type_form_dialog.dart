import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/l10n/generated/app_localizations.dart';

class FruitTypeFormResult {
  const FruitTypeFormResult({
    required this.nameEn,
    required this.nameRu,
    required this.emoji,
    required this.monthsToFruit,
  }) : delete = false;

  const FruitTypeFormResult.delete()
    : nameEn = '',
      nameRu = '',
      emoji = '',
      monthsToFruit = 0,
      delete = true;

  final String nameEn;
  final String nameRu;
  final String emoji;
  final int monthsToFruit;

  /// True when the user pressed "Delete".
  final bool delete;
}

/// Add a new fruit type, or edit [existing] (which also offers Delete).
Future<FruitTypeFormResult?> showFruitTypeFormDialog(
  BuildContext context, {
  FruitType? existing,
}) {
  return showDialog<FruitTypeFormResult>(
    context: context,
    builder: (_) => _FruitTypeFormDialog(existing: existing),
  );
}

const _emojiChoices = [
  '🍌', '🍊', '🍋', '🥭', '🍈', '🍍', '🥝', '🍑', '🍐', '🍎', //
  '🍇', '🍒', '🍓', '🫐', '🥥', '🥑', '🍅', '🌴', '🌳', '🌱',
];

class _FruitTypeFormDialog extends StatefulWidget {
  const _FruitTypeFormDialog({this.existing});

  final FruitType? existing;

  @override
  State<_FruitTypeFormDialog> createState() => _FruitTypeFormDialogState();
}

class _FruitTypeFormDialogState extends State<_FruitTypeFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _nameRu = TextEditingController(text: widget.existing?.nameRu);
  late final _nameEn = TextEditingController(text: widget.existing?.nameEn);
  late final _months = TextEditingController(
    text: '${widget.existing?.monthsToFruit ?? 24}',
  );
  late String _emoji = widget.existing?.emoji ?? '🌳';

  @override
  void dispose() {
    _nameRu.dispose();
    _nameEn.dispose();
    _months.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final ru = _nameRu.text.trim();
    final en = _nameEn.text.trim();
    // If only one name is filled in, use it for both languages.
    Navigator.pop(
      context,
      FruitTypeFormResult(
        nameRu: ru.isEmpty ? en : ru,
        nameEn: en.isEmpty ? ru : en,
        emoji: _emoji,
        monthsToFruit: int.parse(_months.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    String? nameValidator(String? _) =>
        _nameRu.text.trim().isEmpty && _nameEn.text.trim().isEmpty
        ? l10n.fruitTypeNameMissing
        : null;

    return AlertDialog(
      title: Text(
        widget.existing == null ? l10n.fruitTypeAdd : l10n.fruitTypeEdit,
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameRu,
                decoration: InputDecoration(labelText: l10n.fruitTypeNameRu),
                textCapitalization: TextCapitalization.sentences,
                validator: nameValidator,
              ),
              TextFormField(
                controller: _nameEn,
                decoration: InputDecoration(labelText: l10n.fruitTypeNameEn),
                textCapitalization: TextCapitalization.sentences,
                validator: nameValidator,
              ),
              TextFormField(
                controller: _months,
                decoration: InputDecoration(labelText: l10n.fruitTypeMonths),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  return n == null || n < 1 ? l10n.notSet : null;
                },
              ),
              const SizedBox(height: 16),
              Text(l10n.fruitTypeEmoji),
              const SizedBox(height: 8),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  for (final e in _emojiChoices)
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => setState(() => _emoji = e),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: e == _emoji ? scheme.primaryContainer : null,
                        ),
                        child: Text(e, style: const TextStyle(fontSize: 24)),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        if (widget.existing != null)
          TextButton(
            style: TextButton.styleFrom(foregroundColor: scheme.error),
            onPressed: () =>
                Navigator.pop(context, const FruitTypeFormResult.delete()),
            child: Text(l10n.delete),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(onPressed: _submit, child: Text(l10n.save)),
      ],
    );
  }
}
