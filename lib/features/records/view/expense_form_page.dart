import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/dialogs.dart';
import '../../../core/widgets/form_fields.dart';
import '../data/records_repository.dart';
import 'expense_labels.dart';

class ExpenseFormPage extends StatefulWidget {
  const ExpenseFormPage({super.key, this.existing});

  final Expense? existing;

  static Future<void> open(BuildContext context, {Expense? existing}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => ExpenseFormPage(existing: existing),
        ),
      );

  @override
  State<ExpenseFormPage> createState() => _ExpenseFormPageState();
}

class _ExpenseFormPageState extends State<ExpenseFormPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _date = widget.existing?.date ?? DateTime.now();
  late ExpenseCategory _category =
      widget.existing?.category ?? ExpenseCategory.fertilizer;
  late final _amount = TextEditingController(
    text: widget.existing == null ? '' : '${widget.existing!.amount}',
  );
  late final _note = TextEditingController(text: widget.existing?.note);

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final note = _note.text.trim();
    await context.read<RecordsRepository>().saveExpense(
      ExpensesCompanion(
        id: widget.existing == null
            ? const Value.absent()
            : Value(widget.existing!.id),
        date: Value(_date),
        category: Value(_category),
        amount: Value(parseAmount(_amount.text)!),
        note: Value(note.isEmpty ? null : note),
      ),
    );
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final repository = context.read<RecordsRepository>();
    if (!await showConfirmDialog(context, title: l10n.recordDeleteTitle)) {
      return;
    }
    await repository.deleteExpense(widget.existing!.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.expenseTitle),
        actions: [
          if (widget.existing != null)
            IconButton(
              tooltip: l10n.delete,
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            ),
        ],
      ),
      bottomNavigationBar: FormSaveBar(onSave: _save),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DateField(
              value: _date,
              onChanged: (d) => setState(() => _date = d),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.fieldCategory,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in ExpenseCategory.values)
                  ChoiceChip(
                    avatar: Text(c.emoji),
                    label: Text(c.label(l10n)),
                    selected: c == _category,
                    showCheckmark: false,
                    onSelected: (_) => setState(() => _category = c),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amount,
              autofocus: widget.existing == null,
              decoration: InputDecoration(
                labelText: l10n.fieldAmount,
                suffixText: l10n.currency,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) {
                final amount = parseAmount(v ?? '');
                return amount == null || amount <= 0
                    ? l10n.fieldRequired
                    : null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _note,
              decoration: InputDecoration(labelText: l10n.fieldNote),
              textCapitalization: TextCapitalization.sentences,
            ),
          ],
        ),
      ),
    );
  }
}
