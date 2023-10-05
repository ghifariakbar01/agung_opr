import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';
import '../../../../style/style.dart';
import '../../../clear_data_essential/clear_data_essential_providers.dart';
import '../../../mode/mode_state.dart';
import '../../../spk/spk.dart';
import '../../../spk/view/spk_item.dart';
import '../../../update_frame/frame_state.dart';
import '../../../update_frame/shared/update_frame_providers.dart';
import '../../../update_frame/view/form/form_update_sppdc.dart';
import '../../../update_frame/view/update_frame_item_scaffold.dart';
import '../../../widgets/v_appbar.dart';
import 'check_sheet_button.dart';
import 'check_sheet_kelengkapan.dart';
import 'form/form_gate.dart';
import 'form/form_jam.dart';
import 'form/form_keterangan.dart';

final hideKelengkapanAndButtonProvider = StateProvider<bool>((ref) {
  return false;
});

final hideFABProvider = StateProvider<bool>((ref) {
  return true;
});

class CheckSheetLoadingScaffold extends ConsumerStatefulWidget {
  const CheckSheetLoadingScaffold();

  @override
  ConsumerState<CheckSheetLoadingScaffold> createState() =>
      _CheckSheetLoadingScaffoldState();
}

class _CheckSheetLoadingScaffoldState
    extends ConsumerState<CheckSheetLoadingScaffold> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => scrollController.dispose());
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        final nearOK = scrollController.position.pixels >
            0.9 * scrollController.position.maxScrollExtent;

        if (nearOK) {
          ref.read(hideFABProvider.notifier).state = false;
        } else {
          ref.read(hideFABProvider.notifier).state = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final SPK selectedSPK = ref.watch(selectedSPKStateProvider);
    final ModeState modeApp = ref.watch(modeNotifierProvider);
    final FrameState frameList = ref.watch(frameNotifierProvider);

    final bool isLoading =
        ref.watch(frameNotifierProvider.select((value) => value.isProcessing));

    final bool hideKelengkapanAndButton =
        ref.watch(hideKelengkapanAndButtonProvider);
    final bool hideFAB = ref.watch(hideFABProvider);

    final updateFrameNotifier = ref.watch(updateFrameNotifierProvider);

    return KeyboardDismissOnTap(
      child: Scaffold(
          appBar: VAppBar(
              context,
              '${modeApp.maybeWhen(
                checkSheetLoading: () => 'CCR Loading',
                checkSheetUnloading: () => 'CCR Unloading',
                checkSheetLoadingUnloading: () => 'CCR Loading & Unloading',
                orElse: () {},
              )}',
              leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back))),
          floatingActionButton: hideFAB || hideKelengkapanAndButton
              ? Container()
              : FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  elevation: 5,
                  label: Text(
                    'Lakukan setelah Pencet OK / NG',
                    style:
                        Themes.customColor(FontWeight.normal, 11, Colors.black),
                  ),
                  icon: Icon(
                    Icons.download,
                    color: Palette.primaryColor,
                  ),
                  onPressed: () => ref
                      .read(clearDataEssentialNotifierProvider.notifier)
                      .clearAllStorage(idSPK: updateFrameNotifier.idSPK),
                ),
          body: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Header
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Palette.yellow,
                    ),
                    child: Center(
                        child: SPKItem(
                            color: Colors.white,
                            brdrColor: Colors.transparent,
                            nomorPolisi: selectedSPK.nopol,
                            nomorSpk: selectedSPK.idSpk.toString(),
                            namaDriver: selectedSPK.supir1Nm ?? '',
                            namaTrayek: selectedSPK.namaTrayek ?? '',
                            tglBerangkat: selectedSPK.tglBerangkat ?? '')),
                  ),

                  SizedBox(
                    height: 16,
                  ),

                  // UNIT LIST
                  modeApp.maybeWhen(
                      checkSheetLoading: () => Column(
                            children: [
                              Form(
                                autovalidateMode: AutovalidateMode.always,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Palette.primaryColor,
                                          width: 2)),
                                  child: FormUpdateSPPDC(
                                    index: 0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              if (!isLoading) ...[
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

                  if (modeApp == ModeState.checkSheetLoading())
                    Row(
                      children: [
                        Text(
                          'Sembunyikan Checker',
                          style: Themes.customColor(
                              FontWeight.bold, 15, Palette.primaryColorDarker),
                        ),
                        Switch(
                            activeColor: Palette.primaryColor,
                            value: hideKelengkapanAndButton,
                            onChanged: (value) => ref
                                .read(hideKelengkapanAndButtonProvider.notifier)
                                .state = value),
                      ],
                    ),

                  if (!hideKelengkapanAndButton ||
                      modeApp != ModeState.checkSheetLoading()) ...[
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Palette.primaryColor, width: 2)),
                        padding: EdgeInsets.all(4),
                        child: Form(
                          autovalidateMode: AutovalidateMode.always,
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
                    CheckSheetKelengkapan(),
                    //

                    CheckSheetButton(),

                    SizedBox(
                      height: 65,
                    )
                  ]
                ],
              ),
            ),
          )),
    );
  }
}


// final csItem = ref.watch(csItemNotifierProvider);
    // final csIdMap = csItem.csItemListByID;

    // final updateCS = ref.watch(updateCSNotifierProvider);
    // final isNGEmpty = updateCS.updateCSForm.isNG.isEmpty;

      // final showErrorMessage = ref.watch(
      //   updateCSNotifierProvider.select((value) => value.showErrorMessages));