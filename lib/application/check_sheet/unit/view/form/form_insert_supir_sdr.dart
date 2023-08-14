import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
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
    final sdr = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.supirSDR));

    final sdrStr = sdr.getOrLeave('');

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
            child: TextFormField(
              initialValue: sdrStr,
              decoration: Themes.formStyle(sdrStr != ''
                  ? sdrStr + ' (ketik untuk ubah teks)'
                  : 'Masukkan Supir SDR'),
              keyboardType: TextInputType.name,
              onChanged: (value) => ref
                  .read(updateCSUFrameNotifierProvider.notifier)
                  .changeSupirSDR(value),
              validator: (_) => ref
                  .read(updateCSUFrameNotifierProvider)
                  .updateFrameList
                  .supirSDR
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
