import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';

class UnitItem extends StatelessWidget {
  const UnitItem({
    Key? key,
    required this.nomorUnit,
    required this.namaFrame,
    required this.namaCust,
    required this.tglDibuat,
  }) : super(key: key);

  final String nomorUnit;
  final String namaFrame;
  final String namaCust;
  final String tglDibuat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Palette.primaryColor, width: 2)),
        child: Center(
          child: Column(
            children: [
              Text(
                '$tglDibuat\n$namaCust',
                textAlign: TextAlign.center,
                style: Themes.customColor(
                    FontWeight.bold, 15, Palette.primaryColorDarker),
              ),
              Text(
                '$namaFrame',
                textAlign: TextAlign.center,
                style: Themes.customColor(
                    FontWeight.bold, 15, Palette.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
