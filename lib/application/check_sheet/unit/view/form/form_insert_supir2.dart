import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';

/// [TextEditingController] For displaying value only
///
///
class FormInsertSupir1 extends ConsumerWidget {
  const FormInsertSupir1({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supir1 = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.supir1));

    final supir1TextController = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.supir1TextController));

    final supir1Str = supir1.getOrLeave('');

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
                'SUPIR 1',
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
                      .changeSupir1(id);

                  supir1TextController.text = id;
                }
              },
              style:
                  ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
              child: IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: supir1TextController,
                  decoration: Themes.formStyle(supir1Str != ''
                      ? supir1Str + ' (ketik untuk ubah teks)'
                      : 'Pilih Supir 1'),
                  keyboardType: TextInputType.name,
                  onChanged: (value) => {},
                  validator: (_) => ref
                      .read(updateCSUFrameNotifierProvider)
                      .updateFrameList
                      .supir1
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
