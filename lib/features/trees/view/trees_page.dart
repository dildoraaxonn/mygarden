import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../fruit_types/cubit/fruit_types_cubit.dart';
import '../../fruit_types/fruit_type_name.dart';
import '../../plots/data/plot_repository.dart';
import '../cubit/trees_list_cubit.dart';
import '../data/tree_repository.dart';
import 'tree_labels.dart';
import 'tree_page.dart';

/// All trees, grouped by fruit type.
class TreesPage extends StatelessWidget {
  const TreesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TreesListCubit(
        trees: context.read<TreeRepository>(),
        plots: context.read<PlotRepository>(),
      ),
      child: const TreesView(),
    );
  }
}

class TreesView extends StatelessWidget {
  const TreesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final types = context.watch<FruitTypesCubit>().state.types;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navTrees)),
      body: BlocBuilder<TreesListCubit, TreesListState>(
        builder: (context, state) {
          if (!state.loaded) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.trees.isEmpty) {
            return Center(child: Text(l10n.treesEmpty));
          }
          final groups = state.byFruitType;
          final plots = state.plotsById;
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              for (final type in types)
                if (groups[type.id] case final trees?)
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: ExpansionTile(
                      leading: Text(
                        type.emoji,
                        style: const TextStyle(fontSize: 28),
                      ),
                      title: Text(type.localizedName(context)),
                      subtitle: Text(l10n.treeCount(trees.length)),
                      children: [
                        for (final tree in trees)
                          ListTile(
                            title: Text(
                              [
                                plots[tree.plotId]?.name ?? '…',
                                ?tree.variety,
                              ].join(' · '),
                            ),
                            subtitle: Text(tree.stage.label(l10n)),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => TreePage.open(context, tree.id),
                          ),
                      ],
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
