import 'dart:developer';

import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/csu_providers.dart';
import '../../state/csu_jenis_penyebab/csu_jenis_penyebab_item.dart';
import 'csu_item_ok_or_ng.dart';

class CheckSheetUnitItemForm extends ConsumerWidget {
  const CheckSheetUnitItemForm({
    required this.id,
    required this.index,
    required this.instruction,
  });

  // ADD id, in case id != index
  final int id;
  final int index;
  final String instruction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ngState = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.ngStates[index]));

    final isNG = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.isNG[index]));

    final jenis = ref.watch(jenisPenyebabFrameNotifierProvider
        .select((value) => value.csuJenisItems));

    final penyebab = ref.watch(jenisPenyebabFrameNotifierProvider
        .select((value) => value.csuPenyebabItems));

    return Column(
      children: [
        // First Height Part
        CSUItemOKOrNG(
          id,
          index,
          instruction,
        ),

        if (isNG) ...[
          SizedBox(
            height: 12,
          ),

          // JENIS NG
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: SizedBox(
                height: 35,
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<CSUJenisPenyebabItem>(
                  value: jenis.firstWhere(
                    (element) => element.id == ngState.idJenis,
                    orElse: () => CSUJenisPenyebabItem.initial(),
                  ),
                  elevation: 1,
                  underline: Container(),
                  onChanged: (CSUJenisPenyebabItem? value) {
                    // This is called when the user selects an item.
                    if (value != null)
                      ref
                          .read(updateCSUFrameNotifierProvider.notifier)
                          .changeNGJenis(id: value.id, index: index);

                    log('NG Jenis ID : ${value?.id} INDEX: ${index}');
                  },
                  items: jenis.map<DropdownMenuItem<CSUJenisPenyebabItem>>(
                      (CSUJenisPenyebabItem value) {
                    return DropdownMenuItem<CSUJenisPenyebabItem>(
                      value: value,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Palette.primaryColorDarker,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.all(4),
                        child: Text(
                          '${value.id}. ${value.ind} (${value.eng})',
                          style: Themes.customColor(
                            FontWeight.bold,
                            15,
                            Palette.red,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )),
          ),

          // PENYEBAB NG
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<CSUJenisPenyebabItem>(
                  value: penyebab.firstWhere(
                    (element) => element.id == ngState.idPenyebab,
                    orElse: () => CSUJenisPenyebabItem.initialPenyebab(),
                  ),
                  elevation: 1,
                  underline: Container(),
                  onChanged: (CSUJenisPenyebabItem? value) {
                    if (value != null)
                      ref
                          .read(updateCSUFrameNotifierProvider.notifier)
                          .changeNGPenyebab(id: value.id, index: index);
                  },
                  items: penyebab.map<DropdownMenuItem<CSUJenisPenyebabItem>>(
                      (CSUJenisPenyebabItem value) {
                    return DropdownMenuItem<CSUJenisPenyebabItem>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 70,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Palette.primaryColorDarker,
                              ),
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  '${value.id}. ${value.ind} (${value.eng})',
                                  maxLines: 10,
                                  style: Themes.customColor(
                                    FontWeight.bold,
                                    15,
                                    Palette.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )),
          ),

          SizedBox(
            height: 12,
          ),
        ],

        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
