import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckSheetUnitItemForm extends ConsumerWidget {
  const CheckSheetUnitItemForm({
    required this.index,
    required this.instruction,
  });

  final int index;
  final String instruction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNG = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.isNG[index]));

    return Column(
      children: [
        // First Height Part
        Row(
          children: [
            Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    instruction,
                    style:
                        Themes.customColor(FontWeight.normal, 14, Colors.black),
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 0,
              child: Container(
                width: 80,
                height: 35,
                child: Row(
                  children: [
                    // OK Box
                    InkWell(
                      onTap: () => ref
                          .read(updateCSUFrameNotifierProvider.notifier)
                          .changeIsNG(isNG: false, index: index),
                      child: Ink(
                        width: 40,
                        decoration: BoxDecoration(
                            color: isNG ? Colors.white : Palette.primaryColor,
                            border: Border.all(
                                color: Palette.primaryColor, width: 1)),
                        child: Center(
                          child: Text(
                            'OK',
                            style: Themes.customColor(FontWeight.bold, 14,
                                isNG ? Palette.primaryColor : Colors.white),
                          ),
                        ),
                      ),
                    ),

                    // NG Box
                    InkWell(
                      onTap: () => ref
                          .read(updateCSUFrameNotifierProvider.notifier)
                          .changeIsNG(isNG: true, index: index),
                      child: Ink(
                        width: 40,
                        decoration: BoxDecoration(
                            color: isNG ? Palette.red : Colors.white,
                            border: Border.all(color: Palette.red, width: 1)),
                        child: Center(
                          child: Text(
                            'NG',
                            style: Themes.customColor(FontWeight.bold, 14,
                                isNG ? Colors.white : Palette.red),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),

        // Second Height Part
        Visibility(
          visible: isNG,
          child: SizedBox(
            height: 35,
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              decoration: Themes.formStyleSquared('Jenis Defect'),
            ),
          ),
        ),

        SizedBox(
          height: 4,
        ),

        Visibility(
          visible: isNG,
          child: SizedBox(
            height: 35,
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              decoration: Themes.formStyleSquared('Penyebab Defect'),
            ),
          ),
        )
      ],
    );
  }
}
