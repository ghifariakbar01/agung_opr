import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../style/style.dart';

class DataUpdateQueryCSUItem extends StatelessWidget {
  const DataUpdateQueryCSUItem({
    Key? key,
    required this.query,
    required this.idUnit,
  }) : super(key: key);

  final String query;
  final String idUnit;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Palette.primaryColor, width: 2)),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID UNIT: ${idUnit}',
                style: Themes.customColor(
                    FontWeight.bold, 14, Palette.primaryColor),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'DATA QUERY: "${query}"',
                style: Themes.customColor(
                    FontWeight.bold, 12, Palette.primaryColor),
                textAlign: TextAlign.justify,
              ),
            ],
          )),
    );
  }
}
