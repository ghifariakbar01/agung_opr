import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';
import '../../shared/csu_providers.dart';

class CSUItemOKOrNG extends ConsumerWidget {
  const CSUItemOKOrNG(
    this.index,
    this.title,
    this.isNG,
  );

  final int index;
  final String title;
  final bool isNG;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                '${index + 1}.' + ' ' + title,
                style: Themes.customColor(
                  FontWeight.w500,
                  15,
                  Colors.black,
                ),
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
                  onTap: () {
                    ref
                        .read(updateCSUFrameNotifierProvider.notifier)
                        .changeIsNG(
                          isNG: false,
                          index: index,
                        );
                  },
                  child: Ink(
                    width: 40,
                    decoration: BoxDecoration(
                        color: isNG ? Colors.white : Palette.primaryColor,
                        border:
                            Border.all(color: Palette.primaryColor, width: 1)),
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
                  onTap: () {
                    ref
                        .read(updateCSUFrameNotifierProvider.notifier)
                        .changeIsNG(
                          isNG: true,
                          index: index,
                        );
                  },
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
    );
  }
}
