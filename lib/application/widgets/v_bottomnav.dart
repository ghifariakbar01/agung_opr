import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class VBottomNav extends StatelessWidget {
  const VBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 63,
      child: BottomNavigationBar(
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
