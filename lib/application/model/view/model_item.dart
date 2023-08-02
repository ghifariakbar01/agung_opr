import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';

import '../model.dart';

class ModelItem extends StatelessWidget {
  const ModelItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  final Model model;

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
                        'ID: ${model.id}',
                        style: Themes.customColor(
                            FontWeight.bold, 14, Palette.primaryColor),
                      ),
                      Text(
                        'MERK: ${model.merk ?? '-'}',
                        style: Themes.customColor(
                            FontWeight.bold, 12, Palette.primaryColor),
                      ),
                      Text(
                        'NAMA: ${model.nama ?? '-'}',
                        style: Themes.customColor(
                            FontWeight.bold, 12, Palette.primaryColor),
                        maxLines: 5,
                      ),
                      Text(
                        'CATEGORY: ${model.category ?? '-'}',
                        style: Themes.customColor(
                            FontWeight.bold, 12, Palette.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GROSSWEIGHT: ${model.grossweight ?? '-'}',
                        style: Themes.customColor(
                            FontWeight.bold, 12, Palette.primaryColor),
                      ),
                      Text(
                        'MEASUREMENT: ${model.measurement ?? '-'}',
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
