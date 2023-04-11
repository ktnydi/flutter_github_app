import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home/home_screen.dart';
import '../search/search_screen.dart';

enum BarItem {
  search(
    child: SearchRepositoriesScreen(),
    icon: Icons.search_outlined,
    selectedIcon: Icons.search,
    label: '検索',
  ),
  profile(
    child: HomeScreen(),
    icon: Icons.person_outline,
    selectedIcon: Icons.person,
    label: 'プロフィール',
  ),
  ;

  const BarItem({
    required this.child,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final Widget child;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

final _indexProvider = StateProvider((_) => 0);

class BottomNavigatorScreen extends ConsumerWidget {
  const BottomNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexState = ref.watch(_indexProvider);
    final indexNotifier = ref.watch(_indexProvider.notifier);

    return Scaffold(
      body: IndexedStack(
        index: indexState,
        children: BarItem.values.map((e) => e.child).toList(),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          indexNotifier.state = value;
        },
        selectedIndex: indexState,
        destinations: BarItem.values.map((e) {
          return NavigationDestination(
            icon: Icon(e.icon),
            selectedIcon: Icon(e.selectedIcon),
            label: e.label,
          );
        }).toList(),
      ),
    );
  }
}
