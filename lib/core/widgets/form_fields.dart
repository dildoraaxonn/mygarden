import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../utils/format.dart';

/// A tappable date row that opens a date picker.
class DateField extends StatelessWidget {
  const DateField({super.key, required this.value, required this.onChanged});

  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.event_outlined),
      title: Text(l10n.fieldDate),
      subtitle: Text(formatDate(context, value)),
      trailing: const Icon(Icons.edit_outlined),
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: value,
          firstDate: DateTime(now.year - 10),
          lastDate: now,
        );
        if (picked != null) onChanged(picked);
      },
    );
  }
}

/// Bottom bar with a big Save button, used by the record forms.
class FormSaveBar extends StatelessWidget {
  const FormSaveBar({super.key, required this.onSave});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton(
            onPressed: onSave,
            child: Text(AppLocalizations.of(context).save),
          ),
        ),
      ),
    );
  }
}
