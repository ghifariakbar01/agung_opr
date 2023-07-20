import 'package:agung_opr/application/update_frame/view/update_frame_item_form.dart';
import 'package:agung_opr/application/widgets/v_button.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdateFrameItem extends ConsumerWidget {
  const UpdateFrameItem();

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
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Palette.yellow,
              ),
              child: Center(
                child: Text(
                  'UNIT 1',
                  style: Themes.customColor(FontWeight.bold, 16, Colors.black),
                ),
              ),
            ),

            SizedBox(
              height: 16,
            ),

            // Form Item
            UpdateFrameItemForm('Frame'),

            SizedBox(
              height: 8,
            ),

            UpdateFrameItemForm('Engine'),

            SizedBox(
              height: 8,
            ),

            UpdateFrameItemForm('Model'),

            SizedBox(
              height: 8,
            ),

            UpdateFrameItemForm('Reff Exp.'),

            SizedBox(
              height: 8,
            ),

            UpdateFrameItemForm('SPPDC'),

            SizedBox(
              height: 8,
            ),

            // Button Simpan
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    height: 65,
                    width: 230,
                    child: VButton(label: 'SIMPAN', onPressed: () {}))
              ],
            )
          ],
        ),
      ),
    );
  }
}
