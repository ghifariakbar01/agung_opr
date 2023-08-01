import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';

class FormUpdateModel extends ConsumerWidget {
  const FormUpdateModel({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(updateFrameNotifierProvider
        .select((value) => value.updateFrameList[index].idKendType));

    final modelStr = model.getOrLeave('');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: SizedBox(
            height: 40,
            width: 50,
            child: Center(
              child: Text(
                'Model',
                style: Themes.customColor(
                    FontWeight.bold, 14, Palette.primaryColor),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            height: 35,
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              initialValue: modelStr,
              decoration: Themes.formStyle(modelStr != ''
                  ? modelStr + ' (ketik untuk ubah teks)'
                  : 'Pilih model'),
              keyboardType: TextInputType.name,
              onTap: () async {
                final String? id =
                    await context.pushNamed(RouteNames.modelNameRoute);

                if (id != null) {
                  ref
                      .read(updateFrameNotifierProvider.notifier)
                      .changeIdKendType(idKendTypeStr: id, index: index);
                }
              },
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
        )
      ],
    );
  }
}
