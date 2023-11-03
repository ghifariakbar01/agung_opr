import 'dart:developer';

import 'package:agung_opr/application/model/model.dart';
import 'package:agung_opr/application/model/shared/model_providers.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';
import '../../../../style/style.dart';

/// [TextEditingController] For displaying value only
///
///
class FormUpdateModel extends ConsumerWidget {
  const FormUpdateModel({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frame = ref.watch(updateFrameNotifierProvider);

    final item = frame.updateFrameList.length < index
        ? IDKendType('')
        : frame.updateFrameList[index].idKendType;

    final modelStr = item.getOrLeave('');

    final modeApp = ref.watch(modeNotifierProvider);

    final modelListSaved = ref
        .watch(modelNotifierProvider.select((value) => value.modelListSaved));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: Center(
            child: Text(
              'Model',
              style:
                  Themes.customColor(FontWeight.bold, 14, Palette.primaryColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 1,
          child: TextButton(
            onPressed: () async {
              await modeApp.maybeWhen(
                  checkSheetUnit: () {},
                  orElse: () async {
                    final String? id =
                        await context.pushNamed(RouteNames.modelNameRoute);

                    if (id != null) {
                      ref
                          .read(updateFrameNotifierProvider.notifier)
                          .changeIdKendType(idKendTypeStr: id, index: index);

                      frame.modelTextController[index].text = id;
                    }
                  });
            },
            style:
                ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
            child: IgnorePointer(
              ignoring: true,
              child: TextFormField(
                controller: frame.modelTextController[index],
                decoration: Themes.formStyle(modelStr != ''
                    ? modelStr + ' (ketik untuk ubah teks)'
                    : 'Pilih model'),
                keyboardType: TextInputType.name,
                onChanged: (value) => {},
                validator: (_) => ref
                    .read(updateFrameNotifierProvider)
                    .updateFrameList[index]
                    .idKendType
                    .value
                    .fold(
                      (f) => f.maybeMap(
                        empty: (_) => 'kosong',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 1,
          child: Text(
            modelListSaved
                    .firstWhere(
                      (element) => element.id.toString() == modelStr,
                      orElse: () => Model.initial(),
                    )
                    .nama ??
                '',
            style:
                Themes.customColor(FontWeight.normal, 12, Palette.primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
