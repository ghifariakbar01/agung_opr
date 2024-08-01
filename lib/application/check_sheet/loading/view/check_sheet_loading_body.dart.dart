import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';
import '../../../../style/style.dart';
import '../../../mode/mode_state.dart';
import '../../../spk/spk.dart';
import '../../../spk/view/spk_item.dart';
import '../../../update_frame/frame_state.dart';
import '../../../update_frame/shared/update_frame_providers.dart';
import '../../../update_frame/view/form/form_update_sppdc.dart';
import '../../../update_frame/view/update_frame_item.dart';
import 'check_sheet_button.dart';
import 'check_sheet_kelengkapan.dart';
import 'check_sheet_loading_scaffold.dart';
import 'check_sheet_update_frame_button.dart';
import 'check_sheet_update_keterangan_button.dart';
import 'form/form_gate.dart';
import 'form/form_jam.dart';
import 'form/form_keterangan.dart';
import 'widgets/check_sheet_mode.dart';

class CheckSheetLoadingBody extends HookConsumerWidget {
  const CheckSheetLoadingBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SPK selectedSPK = ref.watch(selectedSPKStateProvider);
    final ModeState modeApp = ref.watch(modeNotifierProvider);
    final FrameState frameList = ref.watch(frameNotifierProvider);

    final bool isLoading =
        ref.watch(frameNotifierProvider.select((value) => value.isProcessing));

    final bool hideKelengkapanAndButton =
        ref.watch(hideKelengkapanAndButtonProvider);

    final scrollController = useScrollController();

    _fab() {
      final nearOK = scrollController.position.pixels >
          0.99 * scrollController.position.maxScrollExtent;

      if (nearOK) {
        ref.read(hideFABProvider.notifier).state = false;
      } else {
        ref.read(hideFABProvider.notifier).state = true;
      }
    }

    useEffect(() {
      scrollController.addListener(_fab);
      return () => scrollController.removeListener(_fab);
    });

    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // IF EDITED
            if (selectedSPK.isEdit == true) ...[
              // Header
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Palette.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'SPK Sudah Diupdate Oleh : ${selectedSPK.updatedUser}\n Pada : ${selectedSPK.updatedDate}',
                        style: Themes.customColor(
                            FontWeight.bold, 14, Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(
              height: 8,
            ),

            // Header
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Palette.yellow,
              ),
              child: Center(
                  child: SPKItem(
                      uUser: '',
                      uDate: '',
                      isEdit: false,
                      color: Colors.black,
                      nomorPolisi: selectedSPK.nopol,
                      brdrColor: Colors.transparent,
                      nomorSpk: selectedSPK.idSpk.toString(),
                      namaDriver: selectedSPK.supir1Nm ?? '',
                      namaTrayek: selectedSPK.namaTrayek ?? '',
                      tglBerangkat:
                          'TGL BERANGKAT: ${selectedSPK.tglBerangkat ?? ''}')),
            ),

            SizedBox(
              height: 16,
            ),

            CSMode(),

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
                                    color: Palette.primaryColor, width: 2)),
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
                            UpdateFrameItem(
                              index: index,
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
                      border:
                          Border.all(color: Palette.primaryColor, width: 2)),
                  padding: EdgeInsets.all(16),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(children: [
                      SizedBox(
                        height: 4,
                      ),
                      FormGate(),
                      FormJam(),
                      SizedBox(
                        height: 8,
                      ),
                      FormKeterangan(),
                      SizedBox(
                        height: 4,
                      ),
                    ]),
                  )),
              SizedBox(
                height: 8,
              ),
              CheckSheetKelengkapan(),
              CheckSheetUpdateFrameButton(),
              CheckSheetUpdateKeterangan(),
              CheckSheetButton(),
              SizedBox(
                height: 110,
              )
            ]
          ],
        ),
      ),
    );
  }
}
