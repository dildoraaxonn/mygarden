import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/utils/format.dart';

class PlotFormResult {
  const PlotFormResult({
    required this.name,
    required this.widthM,
    required this.lengthM,
  });

  final String name;
  final double widthM;
  final double lengthM;
}

Future<PlotFormResult?> showPlotFormDialog(BuildContext context, Plot plot) {
  return showDialog<PlotFormResult>(
    context: context,
    builder: (_) => _PlotFormDialog(plot: plot),
  );
}

class _PlotFormDialog extends StatefulWidget {
  const _PlotFormDialog({required this.plot});

  final Plot plot;

  @override
  State<_PlotFormDialog> createState() => _PlotFormDialogState();
}

class _PlotFormDialogState extends State<_PlotFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.plot.name);
  late final _width = TextEditingController(
    text: formatMeters(widget.plot.widthM),
  );
  late final _length = TextEditingController(
    text: formatMeters(widget.plot.lengthM),
  );

  @override
  void dispose() {
    _name.dispose();
    _width.dispose();
    _length.dispose();
    super.dispose();
  }

  double? _parseDouble(String text) => parseDecimal(text);

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      PlotFormResult(
        name: _name.text.trim(),
        widthM: _parseDouble(_width.text)!,
        lengthM: _parseDouble(_length.text)!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    String? positiveNumber(String? v) {
      final n = _parseDouble(v ?? '');
      return n == null || n <= 0 ? l10n.notSet : null;
    }

    const decimal = TextInputType.numberWithOptions(decimal: true);
    return AlertDialog(
      title: Text(l10n.plotEdit),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _name,
                decoration: InputDecoration(labelText: l10n.plotName),
                validator: (v) => (v ?? '').trim().isEmpty ? l10n.notSet : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _width,
                      decoration: InputDecoration(labelText: l10n.plotWidth),
                      keyboardType: decimal,
                      validator: positiveNumber,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _length,
                      decoration: InputDecoration(labelText: l10n.plotLength),
                      keyboardType: decimal,
                      validator: positiveNumber,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(onPressed: _submit, child: Text(l10n.save)),
      ],
    );
  }
}
