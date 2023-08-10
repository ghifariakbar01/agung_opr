import 'dart:developer';

import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/application/update_frame/view/form/form_update_warna.dart';
import 'package:agung_opr/application/widgets/v_button.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/providers.dart';
import 'form/form_update_engine.dart';
import 'form/form_update_frame.dart';
import 'form/form_update_model.dart';
import 'form/form_update_reff.dart';
import 'form/form_update_sppdc.dart';

class UpdateFrameItem extends ConsumerWidget {
  const UpdateFrameItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modeApp = ref.watch(modeNotifierProvider);

    final showErrorMessage = ref.watch(updateFrameNotifierProvider
        .select((value) => value.updateFrameList[index].isShowError));

    final frame = ref.watch(updateFrameNotifierProvider
        .select((value) => value.updateFrameList[index].frame));

    final frameStr = frame.getOrLeave('');

    final idUnit = ref.watch(updateFrameNotifierProvider
        .select((value) => value.updateFrameList[index].idUnit));

    final idUnitStr = idUnit.getOrLeave('');

    return Form(
      autovalidateMode: showErrorMessage
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Palette.primaryColor)),
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              // Header
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Palette.yellow,
                ),
                child: Center(
                  child: Text(
                    'UNIT ${index + 1}',
                    style:
                        Themes.customColor(FontWeight.bold, 16, Colors.black),
                  ),
                ),
              ),

              SizedBox(
                height: 16,
              ),

              // Form Item
              FormUpdateFrame(index: index),

              SizedBox(
                height: 8,
              ),

              FormUpdateEngine(
                index: index,
              ),

              SizedBox(
                height: 8,
              ),

              FormUpdateWarna(
                index: index,
              ),

              SizedBox(
                height: 8,
              ),

              FormUpdateModel(
                index: index,
              ),

              SizedBox(
                height: 8,
              ),

              FormUpdateReffEXP(
                index: index,
              ),

              SizedBox(
                height: 8,
              ),

              FormUpdateSPPDC(
                index: index,
              ),

              SizedBox(
                height: 8,
              ),

              // Button Simpan
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      height: 65,
                      width: 230,
                      child: modeApp.maybeWhen(
                        updateFrameDummy: () => VButton(
                            label: 'SIMPAN',
                            onPressed: () async {
                              await ref
                                  .read(updateFrameNotifierProvider.notifier)
                                  .updateFrame(index: index);

                              await ref
                                  .read(updateFrameOfflineNotifierProvider
                                      .notifier)
                                  .CUUpdateFrameOFFLINEStatus();
                            }),
                        checkSheetUnit: () => VButton(
                            label: 'CSU',
                            onPressed: () {
                              context.pushNamed(RouteNames.CSUListNameRoute,
                                  extra: {'nama': frameStr, 'id': idUnitStr});
                            }),
                        orElse: () => null,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
