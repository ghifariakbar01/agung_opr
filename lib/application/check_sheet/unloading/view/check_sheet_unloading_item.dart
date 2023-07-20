import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';
import '../../check_sheet_item_form.dart';

class CheckSheetUnloadingItem extends ConsumerWidget {
  const CheckSheetUnloadingItem();

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
                  'A. Unloading',
                  style: Themes.customColor(FontWeight.bold, 14, Colors.black),
                ),
              ],
            ),

            SizedBox(
              height: 4,
            ),

            // Form Item
            CheckSheetItemForm(
                'A1. Driver Memasang Bantalan Karet Untuk Proses Unloading.'),

            SizedBox(
              height: 8,
            ),

            CheckSheetItemForm(
                'A2. Memastikan Driver Melakukan Loading, Asisten Memandu Loading di Sisi Car Carrier.'),

            SizedBox(
              height: 8,
            ),

            CheckSheetItemForm('A3. Muatan Lurus Sesuai Garis Pandu.'),

            SizedBox(
              height: 8,
            ),

            CheckSheetItemForm(
                'A4. Driver Tidak Melakukan Aktivitas Sampai Asisten Selesai Proses Unlashing (Melepaskan J-Hook).'),

            SizedBox(
              height: 8,
            ),

            CheckSheetItemForm(
                'A5. Asisten Driver Memandu Unit Sampai Batas Aman (Melewati Marking Kuning).'),

            SizedBox(
              height: 16,
            ),

            // Header
            Row(
              children: [
                Text(
                  'B. Langsir Self Drive',
                  style: Themes.customColor(FontWeight.bold, 14, Colors.black),
                ),
              ],
            ),

            SizedBox(
              height: 8,
            ),

            CheckSheetItemForm('B1. Self Tidak Memakai Accessories Tambahan'),

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
