import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/database/app_database.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/widgets/dialogs.dart';
import '../cubit/fruit_types_cubit.dart';
import '../fruit_type_name.dart';
import 'widgets/fruit_type_form_dialog.dart';

/// List of fruit types. Uses the app-wide [FruitTypesCubit].
class FruitTypesPage extends StatelessWidget {
  const FruitTypesPage({super.key});

  static Future<void> open(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const FruitTypesPage()),
  );

  Future<void> _add(BuildContext context) async {
    final cubit = context.read<FruitTypesCubit>();
    final result = await showFruitTypeFormDialog(context);
    if (result == null || result.delete) return;
    await cubit.add(
      nameEn: result.nameEn,
      nameRu: result.nameRu,
      emoji: result.emoji,
      monthsToFruit: result.monthsToFruit,
    );
  }

  Future<void> _edit(BuildContext context, FruitType type) async {
    final cubit = context.read<FruitTypesCubit>();
    final l10n = AppLocalizations.of(context);
    final result = await showFruitTypeFormDialog(context, existing: type);
    if (result == null) return;
    if (result.delete) {
      final deleted = await cubit.delete(type.id);
      if (!deleted && context.mounted) showSnack(context, l10n.fruitTypeInUse);
      return;
    }
    await cubit.save(
      type.copyWith(
        nameEn: result.nameEn,
        nameRu: result.nameRu,
        emoji: result.emoji,
        monthsToFruit: result.monthsToFruit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final types = context.watch<FruitTypesCubit>().state.types;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsFruitTypes)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _add(context),
        icon: const Icon(Icons.add),
        label: Text(l10n.fruitTypeAdd),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 96),
        children: [
          for (final type in types)
            ListTile(
              leading: Text(type.emoji, style: const TextStyle(fontSize: 32)),
              title: Text(type.localizedName(context)),
              subtitle: Text(l10n.fruitTypeMonthsShort(type.monthsToFruit)),
              trailing: const Icon(Icons.edit_outlined),
              onTap: () => _edit(context, type),
            ),
        ],
      ),
    );
  }
}
