import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/app_database.dart';
import '../../cubit/fruit_types_cubit.dart';
import 'fruit_button.dart';

/// Bottom sheet with a grid of fruit types. Returns the chosen type.
Future<FruitType?> showFruitPicker(BuildContext context, {String? title}) {
  return showModalBottomSheet<FruitType>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) {
      final types = context.read<FruitTypesCubit>().state.types;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    title,
                    style: Theme.of(sheetContext).textTheme.titleMedium,
                  ),
                ),
              Flexible(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: [
                    for (final type in types)
                      FruitButton(
                        fruitType: type,
                        onTap: () => Navigator.pop(sheetContext, type),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
