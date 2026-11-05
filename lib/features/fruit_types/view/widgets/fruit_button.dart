import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../fruit_type_name.dart';

/// A big square button with the fruit's emoji and name.
class FruitButton extends StatelessWidget {
  const FruitButton({super.key, required this.fruitType, required this.onTap});

  final FruitType fruitType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.secondaryContainer,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // The emoji takes whatever space the name leaves, so long
              // names and large system font sizes never overflow.
              Expanded(
                child: FittedBox(
                  child: Text(
                    fruitType.emoji,
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                fruitType.localizedName(context),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: scheme.onSecondaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
