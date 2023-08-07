import 'package:agung_opr/application/supir/supir.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';

class SupirItem extends StatelessWidget {
  const SupirItem({
    Key? key,
    required this.supir,
  }) : super(key: key);

  final Supir supir;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Palette.primaryColor, width: 2)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NAMA: ${supir.nama}',
                        style: Themes.customColor(
                            FontWeight.bold, 14, Palette.primaryColor),
                      ),
                      Text(
                        'NO. HP: ${supir.phone ?? '-'}',
                        style: Themes.customColor(
                            FontWeight.bold, 12, Palette.primaryColor),
                      ),
                      Text(
                        'ALAMAT: ${supir.alamat ?? '-'}',
                        style: Themes.customColor(
                            FontWeight.bold, 12, Palette.primaryColor),
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'KATEGORI: ${supir.kategori ?? '-'}',
                        style: Themes.customColor(
                            FontWeight.bold, 12, Palette.primaryColor),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
