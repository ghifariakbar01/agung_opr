import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';
import '../../../update_cs/view/widget/cs_item_form.dart';
import '../../shared/providers/cs_providers.dart';

class CheckSheetKelengkapan extends ConsumerStatefulWidget {
  const CheckSheetKelengkapan();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CheckSheetKelengkapanState();
}

class _CheckSheetKelengkapanState extends ConsumerState<CheckSheetKelengkapan> {
  @override
  Widget build(BuildContext context) {
    final csItem = ref.watch(csItemNotifierProvider);
    final csIdMap = csItem.csItemListByID;

    final updateCS = ref.watch(updateCSNotifierProvider);
    final isNGEmpty = updateCS.updateCSForm.isNG.isEmpty;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Palette.primaryColor,
            width: 2,
          )),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'KELENGKAPAN',
            style:
                Themes.customColor(FontWeight.bold, 16, Palette.primaryColor),
          ),
          SizedBox(
            height: 8,
          ),
          if (!isNGEmpty) ...[
            for (int indexOuter = 0;
                indexOuter < csIdMap.keys.length;
                indexOuter++) ...[
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    '${csIdMap.keys.elementAt(indexOuter)}. ' +
                        '${ref.watch(csJenisNotifierProvider.select((value) => value.csJenisList.firstWhere((element) => element.id == csIdMap.keys.elementAt(indexOuter)))).nama}',
                    style:
                        Themes.customColor(FontWeight.bold, 14, Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              for (int index = 0;
                  index < csIdMap.entries.elementAt(indexOuter).value.length;
                  index++) ...[
                Builder(
                  builder: (context) {
                    final val = csIdMap.entries.elementAt(indexOuter).value;

                    // Body
                    return CSItemForm(
                      id: val[index].id,
                      index: ref
                          .watch(csItemNotifierProvider.notifier)
                          .getIndex(item: val[index]),
                      instruction: csIdMap.entries
                          .elementAt(indexOuter)
                          .value[index]
                          .description,
                    );
                  },
                )
              ]
            ]
          ]
        ],
      ),
    );
  }
}
