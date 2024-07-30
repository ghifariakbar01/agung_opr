import 'dart:developer';

import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/csu_providers.dart';
import '../../state/csu_items/csu_items.dart';
import '../../state/csu_jenis_penyebab/csu_jenis_penyebab_item.dart';
import '../../state/csu_posisi/csu_posisi.dart';
import 'csu_item_ok_or_ng.dart';

class CheckSheetUnitItemForm extends HookConsumerWidget {
  const CheckSheetUnitItemForm({
    required this.index,
    required this.items,
    required this.title,
  });

  final int index;
  final String title;
  final List<CSUItems> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ngState = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.ngStates[index]));

    final isNG = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.isNG[index]));

    final jenis = ref.watch(jenisPenyebabFrameNotifierProvider
        .select((value) => value.csuJenisItems));

    final posisi = ref.watch(jenisPenyebabFrameNotifierProvider
        .select((value) => value.csuPosisiItems));

    final isDefectTap = useState(false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CSUItemOKOrNG(
            index,
            title,
            isNG,
          ),
          SizedBox(
            height: 12,
          ),
          if (isNG) ...[
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Catatan Defect',
                      style: Themes.customColor(
                        underline: true,
                        FontWeight.w500,
                        14,
                        Colors.black,
                      )),
                  Container(
                      height: 100,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        maxLines: 2,
                        initialValue: ngState.ket,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            final _trimmed = value.replaceAll('\n', '');
                            ref
                                .read(updateCSUFrameNotifierProvider.notifier)
                                .changeNGKet(
                                  ket: _trimmed,
                                  index: index,
                                );
                          }
                        },
                      )),
                  Text('Bagian Kendaraan',
                      style: Themes.customColor(
                        underline: true,
                        FontWeight.w500,
                        14,
                        Colors.black,
                      )),
                  SizedBox(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField<CSUItems>(
                        value: items.firstWhere(
                          (element) => element.id == ngState.idItem,
                          orElse: () => items.first,
                        ),
                        elevation: 1,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'kosong';
                          }
                          if (value.id == 0) {
                            return 'pilih item';
                          }

                          if (isDefectTap.value == false) {
                            return 'pilih item';
                          }

                          return null;
                        },
                        onChanged: (CSUItems? value) {
                          if (value != null) {
                            isDefectTap.value = true;
                            ref
                                .read(updateCSUFrameNotifierProvider.notifier)
                                .changeNGId(
                                  id: value.id,
                                  index: index,
                                );
                          }
                        },
                        items: items
                            .map<DropdownMenuItem<CSUItems>>((CSUItems value) {
                          return DropdownMenuItem<CSUItems>(
                            value: value,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              width: MediaQuery.of(context).size.width - 100,
                              height: 65,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${value.NoUrut}. ${value.ind} (${value.eng})',
                                      maxLines: 2,
                                      style: Themes.customColor(
                                        FontWeight.normal,
                                        14,
                                        Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Palette.primaryColor, width: 1),
                              ),
                            ),
                          );
                        }).toList(),
                      )),
                  Text('Lokasi',
                      style: Themes.customColor(
                        underline: true,
                        FontWeight.w500,
                        14,
                        Colors.black,
                      )),
                  SizedBox(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField<CSUPosisi>(
                        value: posisi.firstWhere(
                          (element) => element.idPosisi == ngState.idPosisi,
                          orElse: () => posisi.first,
                        ),
                        elevation: 1,
                        validator: (value) {
                          if (value == null) {
                            return 'kosong';
                          }
                          if (value.idPosisi == 0) {
                            return 'pilih item';
                          }

                          return null;
                        },
                        onChanged: (CSUPosisi? value) {
                          if (value != null)
                            ref
                                .read(updateCSUFrameNotifierProvider.notifier)
                                .changeNGPosisi(
                                  id: value.idPosisi,
                                  index: index,
                                );
                        },
                        items: posisi.map<DropdownMenuItem<CSUPosisi>>(
                            (CSUPosisi value) {
                          return DropdownMenuItem<CSUPosisi>(
                            value: value,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Palette.primaryColor, width: 1)),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${value.idPosisi}. ${value.namaPosisiInd} (${value.namaPosisiEng})',
                                      maxLines: 10,
                                      style: Themes.customColor(
                                        FontWeight.normal,
                                        14,
                                        Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )),
                  Text('Jenis Defect',
                      style: Themes.customColor(
                        underline: true,
                        FontWeight.w500,
                        14,
                        Colors.black,
                      )),
                  SizedBox(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField<CSUJenisPenyebabItem>(
                        value: jenis.firstWhere(
                          (element) => element.id == ngState.idJenis,
                          orElse: () => jenis.first,
                        ),
                        elevation: 1,
                        style: TextStyle(decoration: TextDecoration.none),
                        validator: (value) {
                          if (value == null) {
                            return 'kosong';
                          }
                          if (value.id == 0) {
                            return 'pilih item';
                          }

                          return null;
                        },
                        onChanged: (CSUJenisPenyebabItem? value) {
                          // This is called when the user selects an item.
                          if (value != null)
                            ref
                                .read(updateCSUFrameNotifierProvider.notifier)
                                .changeNGJenis(
                                  id: value.id,
                                  index: index,
                                );

                          log('NG Jenis ID : ${value?.id} INDEX: ${index}');
                        },
                        items: jenis
                            .map<DropdownMenuItem<CSUJenisPenyebabItem>>(
                                (CSUJenisPenyebabItem value) {
                          return DropdownMenuItem<CSUJenisPenyebabItem>(
                            value: value,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Palette.primaryColor,
                                    width: 1,
                                  )),
                              child: Text(
                                '${value.id}. ${value.ind} (${value.eng})',
                                style: Themes.customColor(
                                  FontWeight.normal,
                                  14,
                                  Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            )
          ],
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
