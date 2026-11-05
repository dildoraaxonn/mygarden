import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/dialogs.dart';
import '../../../core/widgets/form_fields.dart';
import '../../fruit_types/cubit/fruit_types_cubit.dart';
import '../../fruit_types/fruit_type_name.dart';
import '../data/records_repository.dart';

/// Add or edit a harvest. When [tree] is given, the fruit is fixed to it.
class HarvestFormPage extends StatefulWidget {
  const HarvestFormPage({super.key, this.existing, this.tree});

  final Harvest? existing;
  final Tree? tree;

  static Future<void> open(
    BuildContext context, {
    Harvest? existing,
    Tree? tree,
  }) => Navigator.push(
    context,
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => HarvestFormPage(existing: existing, tree: tree),
    ),
  );

  @override
  State<HarvestFormPage> createState() => _HarvestFormPageState();
}

class _HarvestFormPageState extends State<HarvestFormPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _date = widget.existing?.date ?? DateTime.now();
  late int? _fruitTypeId =
      widget.existing?.fruitTypeId ?? widget.tree?.fruitTypeId;
  late final _kg = TextEditingController(
    text: widget.existing == null ? '' : formatMeters(widget.existing!.kg),
  );
  late final _note = TextEditingController(text: widget.existing?.note);

  @override
  void dispose() {
    _kg.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final note = _note.text.trim();
    await context.read<RecordsRepository>().saveHarvest(
      HarvestsCompanion(
        id: widget.existing == null
            ? const Value.absent()
            : Value(widget.existing!.id),
        date: Value(_date),
        fruitTypeId: Value(_fruitTypeId!),
        treeId: Value(widget.tree?.id ?? widget.existing?.treeId),
        kg: Value(parseDecimal(_kg.text)!),
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
    await repository.deleteHarvest(widget.existing!.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final types = context.watch<FruitTypesCubit>().state.types;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.harvestTitle),
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
            DropdownButtonFormField<int>(
              initialValue: _fruitTypeId,
              decoration: InputDecoration(labelText: l10n.fieldFruit),
              items: [
                for (final t in types)
                  DropdownMenuItem(value: t.id, child: Text(t.label(context))),
              ],
              onChanged: widget.tree == null
                  ? (v) => setState(() => _fruitTypeId = v)
                  : null,
              validator: (v) => v == null ? l10n.fieldRequired : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _kg,
              autofocus: widget.existing == null,
              decoration: InputDecoration(labelText: l10n.fieldKg),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (v) {
                final kg = parseDecimal(v ?? '');
                return kg == null || kg <= 0 ? l10n.fieldRequired : null;
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
