import 'package:flutter/material.dart';

import '../core/l10n/generated/app_localizations.dart';
import '../features/home/view/home_page.dart';
import '../features/records/view/records_page.dart';
import '../features/settings/view/settings_page.dart';
import '../features/trees/view/trees_page.dart';

/// Bottom navigation: Garden · Trees · Records · Settings.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Not a Scaffold on purpose: each tab has its own Scaffold (and its own
    // ScaffoldMessenger), so snack bars appear only inside that tab and push
    // its "add" button up instead of covering it.
    return Material(
      child: Column(
        children: [
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: IndexedStack(
                index: _index,
                children: const [
                  ScaffoldMessenger(child: HomePage()),
                  ScaffoldMessenger(child: TreesPage()),
                  ScaffoldMessenger(child: RecordsPage()),
                  ScaffoldMessenger(child: SettingsPage()),
                ],
              ),
            ),
          ),
          // Outside a Scaffold the bar would also pad for the status bar.
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: (i) => setState(() => _index = i),
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.yard_outlined),
                  selectedIcon: const Icon(Icons.yard),
                  label: l10n.navGarden,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.park_outlined),
                  selectedIcon: const Icon(Icons.park),
                  label: l10n.navTrees,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.account_balance_wallet_outlined),
                  selectedIcon: const Icon(Icons.account_balance_wallet),
                  label: l10n.navRecords,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings),
                  label: l10n.navSettings,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
