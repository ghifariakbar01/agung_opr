import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../shared/providers.dart';
import '../../../style/style.dart';
import '../../mode/mode_state.dart';
import '../../routes/route_names.dart';
import '../../update_frame/shared/update_frame_providers.dart';
import '../shared/history_providers.dart';

class HistoryCSUOkPage extends ConsumerWidget {
  const HistoryCSUOkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(
        historyNotifierProvider.select((value) => value.history.historyCSUOk));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Ink(
              padding: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: Palette.primaryColor, width: 2)),
              child: InkWell(
                onTap: () async {
                  final name = item.frame;
                  if (name != null) {
                    ref
                        .read(modeNotifierProvider.notifier)
                        .changeModeAplikasi(ModeState.checkSheetUnit());

                    final _frame = await ref
                        .read(frameNotifierProvider.notifier)
                        .getFrameByName(frame: name);

                    Map<String, dynamic> frameMap = _frame.toJson();

                    await context.pushNamed(
                      extra: frameMap,
                      RouteNames.CSUResultRoute,
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CSU OK',
                      style:
                          Themes.customColor(FontWeight.bold, 12, Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Oleh : ${item.cUser}',
                          style: Themes.customColor(
                              FontWeight.bold, 12, Colors.black),
                        ),
                        Text(
                          item.cDate == null
                              ? ''
                              : 'Date :  ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(item.cDate!))}',
                          style: Themes.customColor(
                              FontWeight.bold, 12, Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Frame : ${item.frame}',
                      style:
                          Themes.customColor(FontWeight.w500, 12, Colors.black),
                    ),
                    Text(
                      'ID CS : ${item.idCs}',
                      style:
                          Themes.customColor(FontWeight.w500, 12, Colors.black),
                    ),
                    Text(
                      'Defect : ${item.noDefect == 0 ? 'Tidak' : 'Ya'}',
                      style:
                          Themes.customColor(FontWeight.w500, 12, Colors.black),
                    ),
                    Text(
                      'Supir : ${item.supirSdr}',
                      style:
                          Themes.customColor(FontWeight.w500, 12, Colors.black),
                    ),
                    Text(
                      'Tgl Kirim : ${item.tglKirimUnit}',
                      style:
                          Themes.customColor(FontWeight.w500, 12, Colors.black),
                    ),
                    Text(
                      'Tgl Terima : ${item.tglTerimaUnit}',
                      style:
                          Themes.customColor(FontWeight.w500, 12, Colors.black),
                    ),
                    Text(
                      'Keterangan : ${item.ket}',
                      style:
                          Themes.customColor(FontWeight.w500, 12, Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
