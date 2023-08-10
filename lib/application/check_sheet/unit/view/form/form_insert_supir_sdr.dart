import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';

/// [TextEditingController] For displaying value only
///
///
class FormInsertSupirSdr extends ConsumerWidget {
  const FormInsertSupirSdr({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frame = ref.watch(updateFrameNotifierProvider);

    final item = frame.updateFrameList[index];

    final modelStr = item.idKendType.getOrLeave('');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: SizedBox(
            height: 70,
            width: 65,
            child: Center(
              child: Text(
                'SUPIR SDR',
                style: Themes.customColor(
                    FontWeight.bold, 14, Palette.primaryColor),
                textAlign: TextAlign.center,
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
            height: 65,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: () async {
                final String? id =
                    await context.pushNamed(RouteNames.modelNameRoute);

                if (id != null) {
                  ref
                      .read(updateFrameNotifierProvider.notifier)
                      .changeIdKendType(idKendTypeStr: id, index: index);

                  frame.modelTextController[index].text = id;
                }
              },
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero)),
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
        )
      ],
    );
  }
}
