import 'package:agung_opr/application/update_frame/update_frame_single_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';
import '../../../../style/style.dart';
import '../../../update_cs/view/widget/cs_item_form.dart';
import '../../../update_frame/shared/update_frame_providers.dart';
import '../../../update_frame/view/frame_search.dart';
import '../../../update_frame/view/update_frame_item_scaffold.dart';
import '../../../widgets/v_appbar.dart';
import '../../../widgets/v_button.dart';
import '../../shared/providers/cs_providers.dart';
import 'form/form_gate.dart';
import 'form/form_jam.dart';
import 'form/form_keterangan.dart';

class CheckSheetLoadingScaffold extends ConsumerWidget {
  const CheckSheetLoadingScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final csItem = ref.watch(csItemNotifierProvider);
    final csIdMap = csItem.csItemListByID;

    final updateCS = ref.watch(updateCSNotifierProvider);
    final isNGEmpty = updateCS.updateCSForm.isNG.isEmpty;

    final isDefect = ref.watch(updateCSNotifierProvider.select((value) => value
        .updateCSForm.isNG
        .firstWhere((checkSheet) => checkSheet == true, orElse: () => false)));

    final selectedSPK = ref.watch(selectedSPKStateProvider);

    final showErrorMessage = ref.watch(
        updateCSNotifierProvider.select((value) => value.showErrorMessages));

    final modeApp = ref.watch(modeNotifierProvider);

    final frameList = ref.watch(frameNotifierProvider);
    final isSearching = ref.watch(
        frameSearchNotifierProvider.select((value) => value.isSearching));

    final isLoading =
        ref.watch(frameNotifierProvider.select((value) => value.isProcessing));

    return KeyboardDismissOnTap(
      child: Scaffold(
          appBar: VAppBar(
            '${modeApp.maybeWhen(
              checkSheetLoading: () => 'CCR Loading',
              checkSheetUnloading: () => 'CCR Unloading',
              checkSheetLoadingUnloading: () => 'CCR Loading & Unloading',
              orElse: () {},
            )}',
          ),

          // drawer: Drawer(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Header
                  Container(
                    height: 77,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Palette.yellow,
                    ),
                    child: Center(
                      child: Text(
                        "${selectedSPK.spkNo}\n${selectedSPK.supir1Nm} ${selectedSPK.supir2Nm != null ? " /  ${selectedSPK.supir2Nm} " : ''}\n${selectedSPK.nopol}",
                        style: Themes.customColor(
                            FontWeight.bold, 16, Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  // FRAME
                  modeApp.maybeWhen(
                      checkSheetLoading: () => Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(flex: 5, child: FrameSearch()),
                                  Flexible(
                                      flex: 1,
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Column(
                                          children: [
                                            Flexible(
                                              flex: 0,
                                              child: Text(
                                                'FRAME',
                                                textAlign: TextAlign.center,
                                                style: Themes.customColor(
                                                    FontWeight.bold,
                                                    9,
                                                    Colors.black),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: InkWell(
                                                onTap: () async {
                                                  String? frame =
                                                      await FlutterBarcodeScanner
                                                          .scanBarcode(
                                                              "#65B689",
                                                              "Cancel",
                                                              false,
                                                              ScanMode.DEFAULT);

                                                  if (frame.isNotEmpty &&
                                                      frame != '-1') {
                                                    ref
                                                        .read(
                                                            frameSearchNotifierProvider
                                                                .notifier)
                                                        .changeSearchText(
                                                            frame);

                                                    final idSPK = ref.read(
                                                        updateFrameNotifierProvider
                                                            .select((value) =>
                                                                value.idSPK));

                                                    await ref
                                                        .read(
                                                            frameNotifierProvider
                                                                .notifier)
                                                        .searchFrameListOFFLINE(
                                                            idSPK: '$idSPK',
                                                            frame: frame);
                                                  }
                                                },
                                                child: Ink(
                                                  child: Icon(
                                                    Icons.qr_code_2,
                                                    size: 40,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              if (!isSearching || !isLoading) ...[
                                for (int index = 0;
                                    index < frameList.frameList.length;
                                    index++) ...[
                                  UpdateFrameItemScaffold(
                                    index,
                                  ),
                                ]
                              ]
                            ],
                          ),
                      orElse: () => Container()),

                  //
                  SizedBox(
                    height: 8,
                  ),

                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Palette.primaryColor, width: 2)),
                      padding: EdgeInsets.all(4),
                      child: Form(
                        autovalidateMode: showErrorMessage
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        child: Column(children: [
                          SizedBox(
                            height: 4,
                          ),
                          FormGate(),
                          FormJam(),
                          FormKeterangan(),
                          SizedBox(
                            height: 4,
                          ),
                        ]),
                      )),

                  SizedBox(
                    height: 8,
                  ),

                  //
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Palette.primaryColor, width: 2)),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          'KELENGKAPAN',
                          style: Themes.customColor(
                              FontWeight.bold, 16, Palette.primaryColor),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        if (!isNGEmpty) ...[
                          for (int index2 = 0;
                              index2 < csIdMap.keys.length;
                              index2++) ...[
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${csIdMap.keys.elementAt(index2)}. ' +
                                      '${ref.read(csJenisNotifierProvider.select((value) => value.csJenisList.firstWhere((element) => element.id == csIdMap.keys.elementAt(index2)))).nama}',
                                  style: Themes.customColor(
                                      FontWeight.bold, 14, Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            for (int index = 0;
                                index <
                                    csIdMap.entries
                                        .elementAt(index2)
                                        .value
                                        .length;
                                index++) ...[
                              // Body
                              CSItemForm(
                                index: ref
                                    .read(csItemNotifierProvider.notifier)
                                    .getIndex(index: index, indexPrev: index2),
                                id: csIdMap.entries
                                    .elementAt(index2)
                                    .value[index]
                                    .id,
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
                  ),
                  //

                  VButton(
                      label: 'NG',
                      color: Palette.red,
                      isEnabled: isDefect,
                      onPressed: () async {
                        await ref
                            .read(updateCSNotifierProvider.notifier)
                            .saveQueryNG();

                        await ref
                            .read(updateCSNotifierProvider.notifier)
                            .saveQueryOK();

                        // context.pushReplacementNamed(
                        //     RouteNames.dataUpdateQueryName);
                      }),
                  VButton(
                      label: 'OK',
                      isEnabled: !isDefect,
                      onPressed: () async {
                        await ref
                            .read(updateCSNotifierProvider.notifier)
                            .saveQueryNG();

                        await ref
                            .read(updateCSNotifierProvider.notifier)
                            .saveQueryOK();
                      }),

                  SizedBox(
                    height: 65,
                    child: VButton(
                        label: 'SIMPAN FRAME',
                        onPressed: () async {
                          List<UpdateFrameStateSingle> updateFrameList =
                              ref.read(updateFrameNotifierProvider
                                  .select((value) => value.updateFrameList));

                          await ref
                              .read(updateFrameNotifierProvider.notifier)
                              .updateAllFrame(updateFrameList: updateFrameList);

                          await ref
                              .read(updateFrameOfflineNotifierProvider.notifier)
                              .CUUpdateFrameOFFLINEStatus();
                        }),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
