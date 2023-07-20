import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';
import '../../check_sheet_item_form.dart';

class CheckSheetLoadingItem extends ConsumerWidget {
  const CheckSheetLoadingItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Palette.primaryColor)),
        padding: EdgeInsets.all(4),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Text(
                  'A. Loading',
                  style: Themes.customColor(FontWeight.bold, 14, Colors.black),
                ),
              ],
            ),

            SizedBox(
              height: 4,
            ),

            // Form Item
            CheckSheetItemForm(
                'A1. Posisi Tangga Lurus Dengan Jalur Rak Car Carrier.'),

            SizedBox(
              height: 8,
            ),

            CheckSheetItemForm(
                'A2. J-Hook dan Sling Tidak Melintang di Jalur Loading.'),

            SizedBox(
              height: 8,
            ),

            CheckSheetItemForm(
                'A3. Memastikan Driver Melakukan Loading, Asisten Memandu Loading di Sisi Car Carrier.'),

            SizedBox(
              height: 8,
            ),

            CheckSheetItemForm('A4. Muatan Lurus Sesuai Garis Pandu.'),

            SizedBox(
              height: 8,
            ),

            CheckSheetItemForm('A5. Asisten Driver Tidak Melakukan Aktivitas'),

            SizedBox(
              height: 8,
            ),

            CheckSheetItemForm(
                'A6. Asisten Driver Setting Rak CCR Sesuai Dengan Unit (Posisi Pin Stop Sesuai).'),

            SizedBox(
              height: 8,
            ),

            // Button Simpan
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     SizedBox(
            //         height: 65,
            //         width: 230,
            //         child: VButton(label: 'SIMPAN', onPressed: () {}))
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
