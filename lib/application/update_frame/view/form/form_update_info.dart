import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/application/update_frame/update_frame_single_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../style/style.dart';

class FormUpdateInfo extends ConsumerWidget {
  const FormUpdateInfo({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frame = ref.watch(updateFrameNotifierProvider.select((value) =>
        value.updateFrameList.length < index
            ? UpdateFrameStateSingle.initial()
            : value.updateFrameList[index]));

    return Container(
      height: 55,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Update By : ${frame.uUser}',
                style: Themes.customColor(
                  FontWeight.w500,
                  12,
                  Colors.black,
                ),
              ),
              Text(
                'Update At : ${frame.uDate.isNotEmpty ? DateFormat('dd-MM-yyy HH:mm:ss').format(DateTime.parse(frame.uDate)).toString() : '-'}',
                style: Themes.customColor(
                  FontWeight.w500,
                  12,
                  Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
