import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';

class SPKItem extends StatelessWidget {
  const SPKItem({
    Key? key,
    required this.nomorSpk,
    required this.namaDriver,
    required this.nomorPolisi,
  }) : super(key: key);

  final String nomorSpk;
  final String namaDriver;
  final String nomorPolisi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 91,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Palette.primaryColor, width: 2)),
        child: Center(
          child: Text(
            '$nomorSpk\n$namaDriver\n$nomorPolisi',
            textAlign: TextAlign.center,
            style:
                Themes.customColor(FontWeight.bold, 15, Palette.primaryColor),
          ),
        ),
      ),
    );
  }
}
