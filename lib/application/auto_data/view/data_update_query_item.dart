import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../style/style.dart';

class DataUpdateQueryItem extends StatelessWidget {
  const DataUpdateQueryItem(
      {Key? key, required this.TIUnitMapQuery, required this.idSPK})
      : super(key: key);

  final Map<String, String>? TIUnitMapQuery;
  final String idSPK;

  @override
  Widget build(BuildContext context) {
    final len = TIUnitMapQuery?.keys.length;

    final TIUnitMapList = TIUnitMapQuery?.entries.toList();

    log('MAP IS $TIUnitMapQuery');

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
                'ID SPK: ${idSPK}',
                style: Themes.customColor(
                    FontWeight.bold, 14, Palette.primaryColor),
              ),
              if (TIUnitMapQuery != null) ...[
                if (TIUnitMapQuery!.isNotEmpty) ...[
                  SizedBox(
                    height: 4,
                  ),
                  if (len != null && TIUnitMapList != null) ...[
                    for (int i = 0; i < len; i++) ...[
                      SizedBox(
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ID UNIT KEYS
                            Text(
                              'ID UNIT: ${TIUnitMapList[i].key}',
                              style: Themes.customColor(
                                  FontWeight.bold, 14, Palette.primaryColor),
                              maxLines: 5,
                            ),
                            SizedBox(
                              height: 4,
                            ),

                            // QUERY LIST
                            if (TIUnitMapList[i].value.isNotEmpty) ...[
                              Text(
                                'DATA QUERY: "${TIUnitMapList[i].value}"',
                                style: Themes.customColor(
                                    FontWeight.bold, 12, Palette.primaryColor),
                                textAlign: TextAlign.justify,
                              ),
                            ] else ...[
                              Text(
                                'SUDAH DIUPDATE',
                                style: Themes.customColor(
                                    FontWeight.bold, 12, Palette.primaryDarker),
                                textAlign: TextAlign.justify,
                              ),
                            ],

                            SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      ),
                    ]
                  ],
                ] else ...[
                  Text(
                    'SUDAH DIUPDATE',
                    style: Themes.customColor(
                        FontWeight.bold, 12, Palette.primaryDarker),
                    textAlign: TextAlign.justify,
                  ),
                ]
              ]
            ],
          )),
    );
  }
}
