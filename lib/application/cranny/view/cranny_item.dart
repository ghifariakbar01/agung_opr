import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CrannyItem extends ConsumerWidget {
  const CrannyItem({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Palette.primaryColor, width: 2)),
        child: Center(
          child: Text(
            label,
            style:
                Themes.customColor(FontWeight.bold, 15, Palette.primaryColor),
          ),
        ),
      ),
    );
  }
}
