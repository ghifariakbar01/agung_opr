import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/application/update_frame/view/form/form_update_warna.dart';
import 'package:agung_opr/application/widgets/v_button.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';

class CSUResultItem extends ConsumerWidget {
  const CSUResultItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CSU = ref.watch(
        csuFrameNotifierProvider.select((value) => value.csuResultList[index]));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 2, color: Palette.primaryColor)),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              '${CSU.frame}',
              style: Themes.customColor(FontWeight.bold, 16, Colors.black),
            ),

            SizedBox(
              height: 4,
            ),

            Row(
              children: [
                Text(
                  'GATE : ',
                  style: Themes.customColor(FontWeight.bold, 16, Colors.black),
                ),
                Text(
                  '${CSU.gate}',
                  style:
                      Themes.customColor(FontWeight.normal, 16, Colors.black),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  'IN/OUT : ',
                  style: Themes.customColor(FontWeight.bold, 16, Colors.black),
                ),
                Text(
                  '${CSU.inOut == 0 ? 'Keluar' : 'Masuk'}',
                  style:
                      Themes.customColor(FontWeight.normal, 16, Colors.black),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  'DEFECT : ',
                  style: Themes.customColor(FontWeight.bold, 16, Colors.black),
                ),
                Text(
                  '${CSU.isDefect == 1 ? 'Defect' : 'No Defect'}',
                  style:
                      Themes.customColor(FontWeight.normal, 16, Colors.black),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  'UPDATED AT : ',
                  style: Themes.customColor(FontWeight.bold, 16, Colors.black),
                ),
                Text(
                  '${CSU.updatedAt} BY ${CSU.updatedBy}',
                  style:
                      Themes.customColor(FontWeight.normal, 16, Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
