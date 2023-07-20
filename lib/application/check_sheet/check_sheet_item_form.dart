import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isNGProvider = StateProvider((ref) => false);

class CheckSheetItemForm extends ConsumerWidget {
  const CheckSheetItemForm(this.instruction);

  final String instruction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNG = ref.watch(isNGProvider);

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
              width: 4,
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
                      onTap: () =>
                          ref.read(isNGProvider.notifier).state = false,
                      child: Ink(
                        width: 40,
                        decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            border: Border.all(
                                color: Palette.primaryColor, width: 1)),
                        child: Center(
                          child: Text(
                            'OK',
                            style: Themes.customColor(
                                FontWeight.bold, 14, Colors.white),
                          ),
                        ),
                      ),
                    ),

                    // NG Box
                    InkWell(
                      onTap: () => ref.read(isNGProvider.notifier).state = true,
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
              decoration: Themes.formStyleSquared('Input Keterangan NG'),
            ),
          ),
        )
      ],
    );
  }
}
