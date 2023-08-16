import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/check_sheet/unit/state/csu_result.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CSUResultItem extends ConsumerWidget {
  const CSUResultItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CSU = ref.watch(csuFrameNotifierProvider.select((value) =>
        value.csuResultList.isEmpty || value.csuResultList.length < index
            ? CSUResult.initial()
            : value.csuResultList[index]));

    final isDefect = CSU.defectAmount != 0;

    log('inOut ${CSU.inout}');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 2,
              color: isDefect ? Palette.red : Palette.primaryColor,
            ),
            color:
                isDefect ? Palette.red.withOpacity(0.9) : Colors.transparent),
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    '${CSU.frame}',
                    style: Themes.customColor(FontWeight.bold, 12,
                        isDefect ? Colors.white : Colors.black),
                  ),

                  Row(
                    children: [
                      Text(
                        'GATE : ',
                        style: Themes.customColor(FontWeight.bold, 12,
                            isDefect ? Colors.white : Colors.black),
                      ),
                      Text(
                        '${CSU.gate}',
                        style: Themes.customColor(FontWeight.normal, 12,
                            isDefect ? Colors.white : Colors.black),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        'IN/OUT : ',
                        style: Themes.customColor(FontWeight.bold, 12,
                            isDefect ? Colors.white : Colors.black),
                      ),
                      Text(
                        '${CSU.inout == false ? 'Masuk' : 'Keluar'}',
                        style: Themes.customColor(FontWeight.normal, 12,
                            isDefect ? Colors.white : Colors.black),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        'UPDATED AT : ',
                        style: Themes.customColor(FontWeight.bold, 12,
                            isDefect ? Colors.white : Colors.black),
                      ),
                      Text(
                        '${CSU.updatedAt} BY ${CSU.updatedBy}',
                        style: Themes.customColor(FontWeight.normal, 12,
                            isDefect ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -3,
              right: 0,
              child: SizedBox(
                height: 40,
                width: 115,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'STATUS : ',
                          style: Themes.customColor(FontWeight.bold, 12,
                              isDefect ? Colors.white : Colors.black),
                        ),
                        Text(
                          '${isDefect ? 'Defect' : 'No Defect'}',
                          style: Themes.customColor(FontWeight.normal, 12,
                              isDefect ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                    if (isDefect || CSU.defectAmount != 0) ...[
                      Row(
                        children: [
                          Text(
                            'JUMLAH DEFECT : ',
                            style: Themes.customColor(FontWeight.bold, 12,
                                isDefect ? Colors.white : Colors.black),
                          ),
                          Text(
                            '${CSU.defectAmount}',
                            style: Themes.customColor(FontWeight.normal, 12,
                                isDefect ? Colors.white : Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
