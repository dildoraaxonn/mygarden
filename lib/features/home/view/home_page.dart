import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/utils/format.dart';
import '../../../core/widgets/section_header.dart';
import '../../fruit_types/cubit/fruit_types_cubit.dart';
import '../../fruit_types/data/fruit_type_repository.dart';
import '../../fruit_types/fruit_type_name.dart';
import '../../journal/data/journal_repository.dart';
import '../../journal/view/journal_labels.dart';
import '../../plots/data/plot_repository.dart';
import '../../plots/view/plot_map_page.dart';
import '../../records/data/records_repository.dart';
import '../../trees/data/tree_repository.dart';
import '../../trees/view/tree_labels.dart';
import '../../trees/view/tree_page.dart';
import '../../weather/cubit/weather_cubit.dart';
import '../../weather/view/weather_card.dart';
import '../cubit/home_cubit.dart';

/// "Today": weather, greenhouses, last care, money and what's coming.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        plots: context.read<PlotRepository>(),
        trees: context.read<TreeRepository>(),
        fruitTypes: context.read<FruitTypeRepository>(),
        journal: context.read<JournalRepository>(),
        records: context.read<RecordsRepository>(),
      ),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (!state.loaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () => context.read<WeatherCubit>().refresh(force: true),
            child: ListView(
              padding: const EdgeInsets.only(top: 4, bottom: 24),
              children: [
                const WeatherCard(),
                SectionHeader(l10n.dashboardGreenhouses),
                for (final summary in state.plots) _PlotCard(summary: summary),
                if (state.totalTrees == 0) const _EmptyHint(),
                if (state.totalTrees > 0) _TypeCounts(state: state),
                _CareCard(state: state),
                _MoneyCard(state: state),
                if (state.upcoming.isNotEmpty) ...[
                  SectionHeader(
                    l10n.dashboardUpcoming,
                    subtitle: l10n.dashboardUpcomingHint,
                  ),
                  for (final item in state.upcoming) _UpcomingTile(item: item),
                ],
                if (state.recentJournal.isNotEmpty)
                  _RecentJournal(state: state),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PlotCard extends StatelessWidget {
  const _PlotCard({required this.summary});

  final PlotSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final plot = summary.plot;
    return Card(
      child: ListTile(
        leading: const Icon(Icons.map_outlined, size: 32),
        title: Text(plot.name),
        subtitle: Text(
          '${l10n.plotSize(formatMeters(plot.widthM), formatMeters(plot.lengthM))}'
          ' · ${l10n.treeCount(summary.treeCount)}',
        ),
        trailing: const Icon(Icons.screen_rotation_outlined),
        onTap: () => PlotMapPage.open(context, plot.id),
      ),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.dashboardEmptyTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(l10n.dashboardEmptyBody),
          ],
        ),
      ),
    );
  }
}

class _TypeCounts extends StatelessWidget {
  const _TypeCounts({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final types = context.watch<FruitTypesCubit>().state.types;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final type in types)
            if (state.countsByType[type.id] case final count?)
              Chip(
                avatar: Text(type.emoji),
                label: Text('${type.localizedName(context)} · $count'),
              ),
          if (state.fruitingCount > 0)
            Chip(
              avatar: const Text('🧺'),
              label: Text(l10n.homeFruitingNow(state.fruitingCount)),
            ),
        ],
      ),
    );
  }
}

class _CareCard extends StatelessWidget {
  const _CareCard({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l10n.homeLastCare),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                for (final kind in HomeState.careKinds)
                  ListTile(
                    dense: true,
                    leading: Text(
                      kind.emoji,
                      style: const TextStyle(fontSize: 22),
                    ),
                    title: Text(kind.label(l10n)),
                    trailing: Text(
                      state.lastCare[kind] == null
                          ? l10n.homeNever
                          : formatDaysAgo(context, state.lastCare[kind]!),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MoneyCard extends StatelessWidget {
  const _MoneyCard({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final profit = state.yearIncome - state.yearSpent;
    Widget cell(String label, int amount, Color color) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.labelMedium),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              formatMoney(context, amount),
              style: theme.textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l10n.homeThisYear),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                cell(
                  l10n.recordsIncome,
                  state.yearIncome,
                  Colors.green.shade700,
                ),
                const SizedBox(width: 8),
                cell(
                  l10n.recordsSpent,
                  state.yearSpent,
                  theme.colorScheme.error,
                ),
                const SizedBox(width: 8),
                cell(
                  l10n.recordsProfit,
                  profit,
                  profit >= 0
                      ? theme.colorScheme.primary
                      : theme.colorScheme.error,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _UpcomingTile extends StatelessWidget {
  const _UpcomingTile({required this.item});

  final UpcomingFruit item;

  @override
  Widget build(BuildContext context) {
    final variety = item.tree.variety;
    return Card(
      child: ListTile(
        leading: Text(
          item.fruitType.emoji,
          style: const TextStyle(fontSize: 28),
        ),
        title: Text(
          [
            item.fruitType.localizedName(context),
            ?variety,
            item.plot.name,
          ].join(' · '),
        ),
        subtitle: Text(forecastLabel(context, item.forecast)),
        onTap: () => TreePage.open(context, item.tree.id),
      ),
    );
  }
}

class _RecentJournal extends StatelessWidget {
  const _RecentJournal({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final types = context.watch<FruitTypesCubit>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l10n.homeRecent),
        for (final entry in state.recentJournal)
          Builder(
            builder: (context) {
              final tree = entry.treeId == null
                  ? null
                  : state.treesById[entry.treeId];
              final plot = state.plotById(entry.plotId);
              final what = tree == null
                  ? plot?.name ?? ''
                  : '${types.byId(tree.fruitTypeId)?.label(context) ?? ''}'
                        ' · ${plot?.name ?? ''}';
              return ListTile(
                leading: Text(
                  entry.kind.emoji,
                  style: const TextStyle(fontSize: 22),
                ),
                title: Text('${entry.kind.label(l10n)} · $what'),
                subtitle: Text(
                  [formatDaysAgo(context, entry.date), ?entry.note].join(' · '),
                ),
                onTap: tree == null
                    ? null
                    : () => TreePage.open(context, tree.id),
              );
            },
          ),
      ],
    );
  }
}
