import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/section_header.dart';
import '../../fruit_types/cubit/fruit_types_cubit.dart';
import '../../fruit_types/fruit_type_name.dart';
import '../cubit/records_cubit.dart';
import '../data/records_repository.dart';
import 'expense_form_page.dart';
import 'expense_labels.dart';
import 'harvest_form_page.dart';
import 'sale_form_page.dart';

/// "Учёт": harvest, sales, expenses and profit.
class RecordsPage extends StatelessWidget {
  const RecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecordsCubit(context.read<RecordsRepository>()),
      child: const RecordsView(),
    );
  }
}

enum _EntryTab { harvest, sales, expenses }

class RecordsView extends StatefulWidget {
  const RecordsView({super.key});

  @override
  State<RecordsView> createState() => _RecordsViewState();
}

class _RecordsViewState extends State<RecordsView> {
  _EntryTab _tab = _EntryTab.sales;

  Future<void> _add(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final choice = await showModalBottomSheet<_EntryTab>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AddOption('🧺', l10n.harvestTitle, _EntryTab.harvest),
            _AddOption('💰', l10n.saleTitle, _EntryTab.sales),
            _AddOption('🧾', l10n.expenseTitle, _EntryTab.expenses),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (choice == null || !context.mounted) return;
    setState(() => _tab = choice);
    switch (choice) {
      case _EntryTab.harvest:
        await HarvestFormPage.open(context);
      case _EntryTab.sales:
        await SaleFormPage.open(context);
      case _EntryTab.expenses:
        await ExpenseFormPage.open(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navRecords)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _add(context),
        icon: const Icon(Icons.add),
        label: Text(l10n.recordsAdd),
      ),
      body: BlocBuilder<RecordsCubit, RecordsState>(
        builder: (context, state) {
          if (!state.loaded) {
            return const Center(child: CircularProgressIndicator());
          }
          final summary = state.summary;
          return ListView(
            padding: const EdgeInsets.only(bottom: 96),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: SegmentedButton<RecordsPeriod>(
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(
                      value: RecordsPeriod.month,
                      label: Text(l10n.periodMonth),
                    ),
                    ButtonSegment(
                      value: RecordsPeriod.year,
                      label: Text(l10n.periodYear),
                    ),
                    ButtonSegment(
                      value: RecordsPeriod.all,
                      label: Text(l10n.periodAll),
                    ),
                  ],
                  selected: {state.period},
                  onSelectionChanged: (s) =>
                      context.read<RecordsCubit>().setPeriod(s.first),
                ),
              ),
              _MoneyTiles(summary: summary),
              if (summary.harvestKgByType.isNotEmpty ||
                  summary.incomeByType.isNotEmpty)
                _ByFruit(summary: summary),
              if (summary.spentByCategory.isNotEmpty)
                _ByCategory(summary: summary),
              SectionHeader(l10n.recordsEntries),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SegmentedButton<_EntryTab>(
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(
                      value: _EntryTab.harvest,
                      label: Text(l10n.recordsHarvest),
                    ),
                    ButtonSegment(
                      value: _EntryTab.sales,
                      label: Text(l10n.recordsSales),
                    ),
                    ButtonSegment(
                      value: _EntryTab.expenses,
                      label: Text(l10n.recordsExpenses),
                    ),
                  ],
                  selected: {_tab},
                  onSelectionChanged: (s) => setState(() => _tab = s.first),
                ),
              ),
              const SizedBox(height: 8),
              ...switch (_tab) {
                _EntryTab.harvest => _harvestTiles(context, state.harvests),
                _EntryTab.sales => _saleTiles(context, state.sales),
                _EntryTab.expenses => _expenseTiles(context, state.expenses),
              },
            ],
          );
        },
      ),
    );
  }

  List<Widget> _empty(BuildContext context) => [
    Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        AppLocalizations.of(context).recordsEmpty,
        textAlign: TextAlign.center,
      ),
    ),
  ];

  List<Widget> _harvestTiles(BuildContext context, List<Harvest> items) {
    if (items.isEmpty) return _empty(context);
    final types = context.read<FruitTypesCubit>().state;
    return [
      for (final h in items)
        ListTile(
          leading: Text(
            types.byId(h.fruitTypeId)?.emoji ?? '🧺',
            style: const TextStyle(fontSize: 28),
          ),
          title: Text(types.byId(h.fruitTypeId)?.localizedName(context) ?? ''),
          subtitle: Text([formatDate(context, h.date), ?h.note].join(' · ')),
          trailing: Text(
            formatKg(context, h.kg),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onTap: () => HarvestFormPage.open(context, existing: h),
        ),
    ];
  }

  List<Widget> _saleTiles(BuildContext context, List<Sale> items) {
    if (items.isEmpty) return _empty(context);
    final types = context.read<FruitTypesCubit>().state;
    final l10n = AppLocalizations.of(context);
    return [
      for (final s in items)
        ListTile(
          leading: Text(
            s.fruitTypeId == null
                ? '💰'
                : types.byId(s.fruitTypeId!)?.emoji ?? '💰',
            style: const TextStyle(fontSize: 28),
          ),
          title: Text(
            [
              if (s.fruitTypeId != null)
                types.byId(s.fruitTypeId!)?.localizedName(context) ?? '',
              if (s.kg != null) formatKg(context, s.kg!),
            ].join(' · ').ifEmpty(l10n.saleTitle),
          ),
          subtitle: Text([formatDate(context, s.date), ?s.buyer].join(' · ')),
          trailing: Text(
            formatMoney(context, s.amount),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.green.shade700),
          ),
          onTap: () => SaleFormPage.open(context, existing: s),
        ),
    ];
  }

  List<Widget> _expenseTiles(BuildContext context, List<Expense> items) {
    if (items.isEmpty) return _empty(context);
    final l10n = AppLocalizations.of(context);
    return [
      for (final e in items)
        ListTile(
          leading: Text(e.category.emoji, style: const TextStyle(fontSize: 28)),
          title: Text(e.category.label(l10n)),
          subtitle: Text([formatDate(context, e.date), ?e.note].join(' · ')),
          trailing: Text(
            formatMoney(context, e.amount),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          onTap: () => ExpenseFormPage.open(context, existing: e),
        ),
    ];
  }
}

extension on String {
  String ifEmpty(String fallback) => isEmpty ? fallback : this;
}

class _AddOption extends StatelessWidget {
  const _AddOption(this.emoji, this.label, this.value);

  final String emoji;
  final String label;
  final _EntryTab value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(emoji, style: const TextStyle(fontSize: 28)),
      title: Text(label),
      onTap: () => Navigator.pop(context, value),
    );
  }
}

class _MoneyTiles extends StatelessWidget {
  const _MoneyTiles({required this.summary});

  final RecordsSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _MoneyTile(
                  label: l10n.recordsIncome,
                  amount: summary.income,
                  color: Colors.green.shade700,
                ),
              ),
              Expanded(
                child: _MoneyTile(
                  label: l10n.recordsSpent,
                  amount: summary.spent,
                  color: scheme.error,
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: _MoneyTile(
              label: l10n.recordsProfit,
              amount: summary.profit,
              color: summary.profit >= 0 ? scheme.primary : scheme.error,
              large: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoneyTile extends StatelessWidget {
  const _MoneyTile({
    required this.label,
    required this.amount,
    required this.color,
    this.large = false,
  });

  final String label;
  final int amount;
  final Color color;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: theme.textTheme.labelLarge),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                formatMoney(context, amount),
                style:
                    (large
                            ? theme.textTheme.headlineSmall
                            : theme.textTheme.titleLarge)
                        ?.copyWith(color: color, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ByFruit extends StatelessWidget {
  const _ByFruit({required this.summary});

  final RecordsSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final types = context.watch<FruitTypesCubit>().state.types;
    final rows = [
      for (final t in types)
        if (summary.harvestKgByType.containsKey(t.id) ||
            summary.incomeByType.containsKey(t.id))
          t,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l10n.recordsByFruit),
        for (final t in rows)
          ListTile(
            leading: Text(t.emoji, style: const TextStyle(fontSize: 28)),
            title: Text(t.localizedName(context)),
            subtitle: Text(
              [
                if (summary.harvestKgByType[t.id] case final kg?)
                  l10n.recordsHarvested(formatKg(context, kg)),
                if (summary.soldKgByType[t.id] case final kg?)
                  l10n.recordsSold(formatKg(context, kg)),
              ].join(' · '),
            ),
            trailing: summary.incomeByType[t.id] == null
                ? null
                : Text(formatMoney(context, summary.incomeByType[t.id]!)),
          ),
      ],
    );
  }
}

class _ByCategory extends StatelessWidget {
  const _ByCategory({required this.summary});

  final RecordsSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final entries = summary.spentByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l10n.recordsByCategory),
        for (final e in entries)
          ListTile(
            dense: true,
            leading: Text(e.key.emoji, style: const TextStyle(fontSize: 22)),
            title: Text(e.key.label(l10n)),
            trailing: Text(formatMoney(context, e.value)),
          ),
      ],
    );
  }
}
