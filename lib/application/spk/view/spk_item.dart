import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';

class SPKItem extends StatelessWidget {
  const SPKItem({
    Key? key,
    this.color,
    this.brdrColor,
    required this.nomorSpk,
    required this.namaTrayek,
    required this.namaDriver,
    required this.nomorPolisi,
    required this.tglBerangkat,
  }) : super(key: key);

  final Color? color;
  final Color? brdrColor;
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
            border:
                Border.all(color: brdrColor ?? Palette.primaryColor, width: 2)),
        child: Center(
          child: Column(
            children: [
              Text(
                '$nomorPolisi\n$tglBerangkat',
                textAlign: TextAlign.center,
                style: Themes.customColor(
                    FontWeight.bold, 15, Palette.primaryColorDarker),
              ),
              Text(
                '$namaTrayek\n\n$nomorSpk\n$namaDriver',
                textAlign: TextAlign.center,
                style: Themes.customColor(
                    FontWeight.bold, 15, color ?? Palette.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
