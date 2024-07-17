import 'package:agung_opr/application/update_frame/view/form/form_update_warna.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/value_objects_copy.dart';
import '../shared/update_frame_providers.dart';
import 'form/form_update_frame.dart';
import 'form/form_update_info.dart';
import 'form/form_update_model.dart';

class UpdateFrameItem extends ConsumerWidget {
  const UpdateFrameItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<FrameUnit>(
      updateFrameNotifierProvider
          .select((value) => value.updateFrameList[index].frame),
      (_, __) => ref.read(updateFrameNotifierProvider.notifier).checkIfValid(),
    );

    ref.listen<SPPDC>(
      updateFrameNotifierProvider.select((value) => value.sppdc),
      (_, __) => ref.read(updateFrameNotifierProvider.notifier).checkIfValid(),
    );

    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Palette.primaryColor),
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
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

              FormUpdateInfo(index: index),
            ],
          ),
        ),
      ),
    );
  }
}
