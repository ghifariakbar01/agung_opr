import 'package:agung_opr/application/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';
import '../../shared/csu_providers.dart';

/// [TextEditingController] For displaying value only
///
///
class FormInsertSupir2 extends ConsumerWidget {
  const FormInsertSupir2({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supir2 = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.supir2));

    final supir2TextController = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.supir2TextController));

    final supir2Str = supir2.getOrLeave('');

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
                'SUPIR 2',
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
                    await context.pushNamed(RouteNames.supirNameRoute);

                if (id != null) {
                  ref
                      .read(updateCSUFrameNotifierProvider.notifier)
                      .changeSupir2(id);

                  supir2TextController.text = id;
                }
              },
              style:
                  ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
              child: IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: supir2TextController,
                  decoration: Themes.formStyle(supir2Str != ''
                      ? supir2Str + ' (ketik untuk ubah teks)'
                      : 'Pilih Supir 2'),
                  keyboardType: TextInputType.name,
                  onChanged: (value) => {},
                  validator: (_) => ref
                      .read(updateCSUFrameNotifierProvider)
                      .updateFrameList
                      .supir2
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
