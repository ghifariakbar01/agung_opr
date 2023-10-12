import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';
import '../../../../style/style.dart';
import '../../../mode/mode_state.dart';
import '../../../routes/route_names.dart';
import '../../../update_cs/view/widget/cs_item_form.dart';
import '../../../update_frame/shared/update_frame_providers.dart';
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

    final modeList = updateCS.modeList;
    final modelListSelected = updateCS.modeSelected;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Palette.primaryColor, width: 2)),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            'KELENGKAPAN',
            style:
                Themes.customColor(FontWeight.bold, 16, Palette.primaryColor),
          ),

          Row(
            children: [
              Text(
                'Mode CCR',
                style: Themes.customColor(
                    FontWeight.bold, 14, Palette.primaryColor),
              ),
            ],
          ),

          // KELENGKAPAN DROPDOWN
          SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: DropdownButton<ModeState>(
                value: modeList.firstWhere(
                  (element) => element == modelListSelected,
                  orElse: () => ModeState.initial(),
                ),
                elevation: 16,
                underline: Container(),
                icon: Container(),
                onChanged: (ModeState? value) async {
                  // This is called when the user selects an item.
                  if (value != null)
                    ref
                        .read(updateCSNotifierProvider.notifier)
                        .changeModeState(value);

                  log('Mode State : ${value}');

                  if (value != null)
                    await value.maybeWhen(
                        checkSheetLoading: () async {
                          ModeState mode = ModeState.checkSheetLoading();

                          ref
                              .read(frameNotifierProvider.notifier)
                              .changeFillInitial();
                          ref
                              .read(updateCSNotifierProvider.notifier)
                              .changeFillInitial();
                          ref
                              .read(modeNotifierProvider.notifier)
                              .changeModeAplikasi(mode);
                          ref
                              .read(updateCSNotifierProvider.notifier)
                              .changeTipe(mode);

                          const int id = 1;
                          ref
                              .read(csItemNotifierProvider.notifier)
                              .changeId(id);

                          final spkSelected =
                              ref.read(updateCSNotifierProvider).selectedSPK;

                          context.pop();
                          Map<String, dynamic> spkMap = spkSelected.toJson();

                          await context.pushNamed(
                              RouteNames.checkSheetLoadingNameRoute,
                              extra: spkMap);
                        },
                        checkSheetLoadingUnloading: () async {
                          ModeState mode =
                              ModeState.checkSheetLoadingUnloading();

                          ref
                              .read(frameNotifierProvider.notifier)
                              .changeFillInitial();
                          ref
                              .read(updateCSNotifierProvider.notifier)
                              .changeFillInitial();
                          ref
                              .read(modeNotifierProvider.notifier)
                              .changeModeAplikasi(mode);
                          ref
                              .read(updateCSNotifierProvider.notifier)
                              .changeTipe(mode);

                          const int id = 2;
                          ref
                              .read(csItemNotifierProvider.notifier)
                              .changeId(id);

                          final spkSelected =
                              ref.read(updateCSNotifierProvider).selectedSPK;

                          context.pop();
                          Map<String, dynamic> spkMap = spkSelected.toJson();

                          debugger();

                          await context.pushNamed(
                              RouteNames.checkSheetLoadingNameRoute,
                              extra: spkMap);
                        },
                        checkSheetUnloading: () async {
                          ModeState mode = ModeState.checkSheetUnloading();

                          ref
                              .read(frameNotifierProvider.notifier)
                              .changeFillInitial();
                          ref
                              .read(updateCSNotifierProvider.notifier)
                              .changeFillInitial();
                          ref
                              .read(modeNotifierProvider.notifier)
                              .changeModeAplikasi(mode);
                          ref
                              .read(updateCSNotifierProvider.notifier)
                              .changeTipe(mode);

                          const int id = 3;
                          ref
                              .read(csItemNotifierProvider.notifier)
                              .changeId(id);

                          final spkSelected =
                              ref.read(updateCSNotifierProvider).selectedSPK;

                          context.pop();
                          Map<String, dynamic> spkMap = spkSelected.toJson();

                          await context.pushNamed(
                              RouteNames.checkSheetLoadingNameRoute,
                              extra: spkMap);
                        },
                        orElse: () {});
                },
                items: modeList
                    .map<DropdownMenuItem<ModeState>>((ModeState value) {
                  return DropdownMenuItem<ModeState>(
                    value: value,
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Palette.primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(4),
                      child: Text(
                        '${value.toString().replaceAll('ModeState.checkSheet', '').replaceAll('()', '').replaceAll('LoadingUnloading', 'Loading & Unloading')}',
                        style: Themes.customColor(
                            FontWeight.normal, 14, Colors.black),
                      ),
                    ),
                  );
                }).toList(),
              )),

          // END KELENGKAPAN DROPDOWN

          SizedBox(
            height: 8,
          ),
          if (!isNGEmpty) ...[
            for (int index2 = 0; index2 < csIdMap.keys.length; index2++) ...[
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    '${csIdMap.keys.elementAt(index2)}. ' +
                        '${ref.read(csJenisNotifierProvider.select((value) => value.csJenisList.firstWhere((element) => element.id == csIdMap.keys.elementAt(index2)))).nama}',
                    style:
                        Themes.customColor(FontWeight.bold, 14, Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              for (int index = 0;
                  index < csIdMap.entries.elementAt(index2).value.length;
                  index++) ...[
                // Body
                CSItemForm(
                  index: ref
                      .read(csItemNotifierProvider.notifier)
                      .getIndex(index: index, indexPrev: index2),
                  id: csIdMap.entries.elementAt(index2).value[index].id,
                  instruction: csIdMap.entries
                      .elementAt(index2)
                      .value[index]
                      .description,
                )
              ]
            ]
          ]
        ],
      ),
    );
  }
}
