import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/dialogs.dart';
import '../../../core/widgets/form_fields.dart';
import '../../fruit_types/cubit/fruit_types_cubit.dart';
import '../../fruit_types/fruit_type_name.dart';
import '../data/records_repository.dart';

/// Add or edit a sale. Enter kg × price, or just the total.
class SaleFormPage extends StatefulWidget {
  const SaleFormPage({super.key, this.existing});

  final Sale? existing;

  static Future<void> open(BuildContext context, {Sale? existing}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => SaleFormPage(existing: existing),
        ),
      );

  @override
  State<SaleFormPage> createState() => _SaleFormPageState();
}

class _SaleFormPageState extends State<SaleFormPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _date = widget.existing?.date ?? DateTime.now();
  late int? _fruitTypeId = widget.existing?.fruitTypeId;
  late final _kg = TextEditingController(
    text: widget.existing?.kg == null ? '' : formatMeters(widget.existing!.kg!),
  );
  late final _price = TextEditingController(text: _initialPrice());
  late final _total = TextEditingController(
    text: widget.existing == null ? '' : '${widget.existing!.amount}',
  );
  late final _buyer = TextEditingController(text: widget.existing?.buyer);
  late final _note = TextEditingController(text: widget.existing?.note);

  String _initialPrice() {
    final sale = widget.existing;
    final kg = sale?.kg;
    if (sale == null || kg == null || kg <= 0) return '';
    return '${(sale.amount / kg).round()}';
  }

  @override
  void initState() {
    super.initState();
    _kg.addListener(_recalculate);
    _price.addListener(_recalculate);
  }

  @override
  void dispose() {
    for (final c in [_kg, _price, _total, _buyer, _note]) {
      c.dispose();
    }
    super.dispose();
  }

  /// Fills in the total when both kg and price per kg are known.
  void _recalculate() {
    final kg = parseDecimal(_kg.text);
    final price = parseAmount(_price.text);
    if (kg != null && price != null) {
      _total.text = '${(kg * price).round()}';
    }
  }

  String? _optional(String text) {
    final t = text.trim();
    return t.isEmpty ? null : t;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    await context.read<RecordsRepository>().saveSale(
      SalesCompanion(
        id: widget.existing == null
            ? const Value.absent()
            : Value(widget.existing!.id),
        date: Value(_date),
        fruitTypeId: Value(_fruitTypeId),
        kg: Value(parseDecimal(_kg.text)),
        amount: Value(parseAmount(_total.text)!),
        buyer: Value(_optional(_buyer.text)),
        note: Value(_optional(_note.text)),
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
    await repository.deleteSale(widget.existing!.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final types = context.watch<FruitTypesCubit>().state.types;
    const decimal = TextInputType.numberWithOptions(decimal: true);
    final digits = [FilteringTextInputFormatter.digitsOnly];
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.saleTitle),
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
            DropdownButtonFormField<int?>(
              initialValue: _fruitTypeId,
              decoration: InputDecoration(labelText: l10n.fieldFruit),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n.notSet)),
                for (final t in types)
                  DropdownMenuItem(value: t.id, child: Text(t.label(context))),
              ],
              onChanged: (v) => setState(() => _fruitTypeId = v),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _kg,
                    decoration: InputDecoration(labelText: l10n.fieldKg),
                    keyboardType: decimal,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _price,
                    decoration: InputDecoration(
                      labelText: l10n.fieldPricePerKg,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: digits,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _total,
              decoration: InputDecoration(
                labelText: l10n.fieldTotal,
                suffixText: l10n.currency,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: digits,
              validator: (v) {
                final amount = parseAmount(v ?? '');
                return amount == null || amount <= 0
                    ? l10n.fieldRequired
                    : null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _buyer,
              decoration: InputDecoration(labelText: l10n.fieldBuyer),
              textCapitalization: TextCapitalization.words,
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
