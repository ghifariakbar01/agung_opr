import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';

class SPKItem extends StatelessWidget {
  const SPKItem({
    Key? key,
    required this.nomorSpk,
    required this.namaTrayek,
    required this.namaDriver,
    required this.nomorPolisi,
    required this.tglBerangkat,
  }) : super(key: key);

  final String nomorSpk;
  final String namaTrayek;
  final String namaDriver;
  final String nomorPolisi;
  final String tglBerangkat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Palette.primaryColor, width: 2)),
        child: Center(
          child: Text(
            '$nomorSpk\n$namaDriver\n$nomorPolisi\n$namaTrayek\n$tglBerangkat',
            textAlign: TextAlign.center,
            style:
                Themes.customColor(FontWeight.bold, 15, Palette.primaryColor),
          ),
        ),
      ),
    );
  }
}
