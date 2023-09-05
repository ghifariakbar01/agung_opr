import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final index = StateProvider((ref) => 0);

class VBottomNav extends ConsumerWidget {
  const VBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(index);

    return SizedBox(
      height: 63,
      child: BottomNavigationBar(
        onTap: (value) => ref.read(index.notifier).state = value,
        currentIndex: current,
        items: bottomNavItems,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Palette.greySecondary,
        selectedItemColor: Palette.primaryColor,
        iconSize: 40,
        selectedFontSize: 10,
        unselectedFontSize: 10,
      ),
    );
  }
}

final List<BottomNavigationBarItem> bottomNavItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline),
    label: 'CRANNY',
  ),
  BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'ADMIN')
];
