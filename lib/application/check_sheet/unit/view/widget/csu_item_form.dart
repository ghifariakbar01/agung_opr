import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/check_sheet/unit/state/csu_jenis_penyebab_item.dart';
import 'package:agung_opr/style/style.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'csu_item_ok_or_ng.dart';

class CheckSheetUnitItemForm extends ConsumerWidget {
  const CheckSheetUnitItemForm({
    required this.index,
    required this.instruction,
  });

  final int index;
  final String instruction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ngState = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.ngStates[index]));

    final isNG = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.isNG[index]));

    final jenis = ref.watch(
        updateCSUFrameNotifierProvider.select((value) => value.csuJenisItems));

    final penyebab = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.csuPenyebabItems));

    return Column(
      children: [
        // First Height Part
        CSUItemOKOrNG(instruction, index),

        SizedBox(
          height: 4,
        ),

        // JENIS NG
        Visibility(
          visible: isNG,
          child: SizedBox(
              height: 35,
              width: MediaQuery.of(context).size.width,
              child: DropdownButton<CSUJenisPenyebabItem>(
                value: jenis.firstWhere(
                  (element) => element.id == ngState.idJenis,
                  orElse: () => CSUJenisPenyebabItem.initial(),
                ),
                elevation: 16,
                underline: Container(),
                onChanged: (CSUJenisPenyebabItem? value) {
                  // This is called when the user selects an item.
                  if (value != null)
                    ref
                        .read(updateCSUFrameNotifierProvider.notifier)
                        .changeNGJenis(id: value.id, index: index);
                },
                items: jenis.map<DropdownMenuItem<CSUJenisPenyebabItem>>(
                    (CSUJenisPenyebabItem value) {
                  return DropdownMenuItem<CSUJenisPenyebabItem>(
                    value: value,
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Palette.primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(4),
                      child: Text(
                        '${value.id}. ${value.ind} (${value.eng})',
                        style: Themes.customColor(
                            FontWeight.normal, 14, Colors.black),
                      ),
                    ),
                  );
                }).toList(),
              )),
        ),

        SizedBox(
          height: 4,
        ),

        // PENYEBAB NG
        Visibility(
          visible: isNG,
          child: SizedBox(
              height: 35,
              width: MediaQuery.of(context).size.width,
              child: DropdownButton<CSUJenisPenyebabItem>(
                value: penyebab.firstWhere(
                  (element) => element.id == ngState.idPenyebab,
                  orElse: () => CSUJenisPenyebabItem.initialPenyebab(),
                ),
                elevation: 16,
                underline: Container(),
                onChanged: (CSUJenisPenyebabItem? value) {
                  // This is called when the user selects an item.
                  if (value != null)
                    ref
                        .read(updateCSUFrameNotifierProvider.notifier)
                        .changeNGPenyebab(id: value.id, index: index);
                },
                items: penyebab.map<DropdownMenuItem<CSUJenisPenyebabItem>>(
                    (CSUJenisPenyebabItem value) {
                  return DropdownMenuItem<CSUJenisPenyebabItem>(
                    value: value,
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Palette.primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(4),
                      child: Text(
                        '${value.id}. ${value.ind} (${value.eng})',
                        style: Themes.customColor(
                            FontWeight.normal, 14, Colors.black),
                      ),
                    ),
                  );
                }).toList(),
              )),
        ),
      ],
    );
  }
}
