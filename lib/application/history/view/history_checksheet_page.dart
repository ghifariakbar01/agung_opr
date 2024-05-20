import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../shared/providers.dart';
import '../../../style/style.dart';
import '../../check_sheet/shared/providers/cs_providers.dart';
import '../../mode/mode_state.dart';
import '../../routes/route_names.dart';
import '../../update_frame/shared/update_frame_providers.dart';
import '../shared/history_providers.dart';

class HistoryCheckSheetPage extends ConsumerWidget {
  const HistoryCheckSheetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyNotifierProvider
        .select((value) => value.history.historyCheckSheet));

    void _changeInitialAndMode(Map<int, ModeState> modeMap) {
      final mode = modeMap.values.first;
      final id = modeMap.keys.first;

      ref.read(frameNotifierProvider.notifier).changeFillInitial();
      ref.read(updateCSNotifierProvider.notifier).changeFillInitial();

      ref.read(csItemNotifierProvider.notifier).changeId(id);
      ref.read(modeNotifierProvider.notifier).changeModeAplikasi(mode);
      ref.read(updateCSNotifierProvider.notifier).changeTipe(mode);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Ink(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: Palette.primaryColor, width: 2)),
              child: InkWell(
                onTap: () async {
                  final id = item.idSpk;
                  final tipe = item.tipe;
                  if (id != null && tipe != null) {
                    final Map<int, ModeState> _mode = _determineIdAndMode(tipe);
                    _changeInitialAndMode(_mode);

                    final _spk = await ref
                        .read(spkNotifierProvider.notifier)
                        .getSPKById(idSpk: id);

                    Map<String, dynamic> spkMap = _spk.toJson();
                    await context.pushNamed(
                      extra: spkMap,
                      RouteNames.checkSheetLoadingNameRoute,
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.tipe}',
                        style: Themes.customColor(
                            FontWeight.bold, 12, Colors.black),
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
                        'Gate : ${item.gate}',
                        style: Themes.customColor(
                            FontWeight.w500, 12, Colors.black),
                      ),
                      Text(
                        'Nopol : ${item.nopol}',
                        style: Themes.customColor(
                            FontWeight.w500, 12, Colors.black),
                      ),
                      Text(
                        'Tgl Berangkat : ${item.tglBerangkat}',
                        style: Themes.customColor(
                            FontWeight.w500, 12, Colors.black),
                      ),
                      Text(
                        'Status : ${item.status}',
                        style: Themes.customColor(
                            FontWeight.w500, 12, Colors.black),
                      ),
                      Text(
                        'Keterangan : ${item.ket}',
                        style: Themes.customColor(
                            FontWeight.w500, 12, Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Map<int, ModeState> _determineIdAndMode(String tipe) {
  if (tipe == 'unloading') {
    return {2: ModeState.checkSheetUnloading()};
  }

  if (tipe == 'loadunload') {
    return {3: ModeState.checkSheetLoadingUnloading()};
  }

  return {1: ModeState.checkSheetLoading()};
}
