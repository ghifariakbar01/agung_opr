import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';
import '../../shared/csu_providers.dart';

import 'csu_row_item.dart';

final hideTripProvider = StateProvider<bool>((ref) => true);

class CSUResultInfo extends ConsumerWidget {
  const CSUResultInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frame = ref.watch(
      csuFrameNotifierProvider.select((value) => value.frame),
    );

    return // Informasi Unit
        Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 2, color: Palette.primaryColor),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              '${frame.lastSpk}',
              style: Themes.customColor(
                FontWeight.bold,
                18,
                Palette.primaryDarker,
              ),
            ),
          ),
          frame.warna == null
              ? Container()
              : frame.warna!.isEmpty
                  ? Container()
                  : CSURowItem(
                      label: 'WARNA',
                      text: frame.warna ?? '-',
                    ),
        ],
      ),
    );
  }
}
