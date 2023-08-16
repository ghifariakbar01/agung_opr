import 'package:agung_opr/application/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';
import '../../shared/csu_providers.dart';

/// [TextEditingController] For displaying value only
///
///
class FormInsertSupirSDR extends ConsumerWidget {
  const FormInsertSupirSDR({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supirSDR = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.supirSDR));

    final supirSDRTextController = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.supirSDRTextController));

    final supirSDRStr = supirSDR.getOrLeave('');

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
                    await context.pushNamed(RouteNames.supirNameRoute);

                if (id != null) {
                  ref
                      .read(updateCSUFrameNotifierProvider.notifier)
                      .changeSupirSDR(id);

                  supirSDRTextController.text = id;
                }
              },
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero)),
              child: IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: supirSDRTextController,
                  decoration: Themes.formStyle(supirSDRStr != ''
                      ? supirSDRStr + ' (ketik untuk ubah teks)'
                      : 'Pilih Supir SDR'),
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
