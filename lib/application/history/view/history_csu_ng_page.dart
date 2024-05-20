import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/providers.dart';
import '../../../style/style.dart';
import '../../mode/mode_state.dart';
import '../../routes/route_names.dart';
import '../../update_frame/shared/update_frame_providers.dart';
import '../shared/history_providers.dart';

class HistoryCSUNgPage extends ConsumerWidget {
  const HistoryCSUNgPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(
        historyNotifierProvider.select((value) => value.history.historyCSUNg));
    final _historyMap = history.groupListsBy(
      (element) => element.idCs,
    );
    final _entries = _historyMap.entries.toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: _entries.length,
        itemBuilder: (context, index) {
          final _item = _entries[index];
          final _first = _item.value.first;
          log('_first.frame ${_first.frame}');

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Ink(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Palette.red,
              ),
              child: InkWell(
                onTap: () async {
                  final name = _first.frame;
                  if (name != null) {
                    ref
                        .read(modeNotifierProvider.notifier)
                        .changeModeAplikasi(ModeState.checkSheetUnit());

                    final _frame = await ref
                        .read(frameNotifierProvider.notifier)
                        .getFrameByName(frame: _first.frame!);

                    Map<String, dynamic> frameMap = _frame.toJson();

                    await context.pushNamed(
                      extra: frameMap,
                      RouteNames.CSUResultRoute,
                    );
                  }
                },
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final item in _item.value) ...[
                          SizedBox(
                            width: 100,
                            child: Divider(
                              color: Colors.white,
                              height: 5,
                              thickness: 2,
                            ),
                          ),
                          Text(
                            'ID Item : ${item.idItem}',
                            style: Themes.customColor(
                                FontWeight.w500, 12, Colors.white),
                          ),
                          Text(
                            'ID Jenis : ${item.idJnsDefect}',
                            style: Themes.customColor(
                                FontWeight.w500, 12, Colors.white),
                          ),
                          Text(
                            'ID Penyebab : ${item.idPDefect}',
                            style: Themes.customColor(
                                FontWeight.w500, 12, Colors.white),
                          ),
                          SizedBox(
                            width: 100,
                            child: Divider(
                              color: Colors.white,
                              height: 5,
                              thickness: 2,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ]
                      ],
                    ),
                    Positioned(
                        top: 5,
                        right: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Frame : ${_first.frame}',
                              style: Themes.customColor(
                                  FontWeight.bold, 12, Colors.white),
                            ),
                            Text(
                              'Defect : ${_item.value.length}',
                              style: Themes.customColor(
                                  FontWeight.bold, 12, Colors.white),
                            ),
                            Text(
                              'ID CS : ${_item.key}',
                              style: Themes.customColor(
                                  FontWeight.bold, 12, Colors.white),
                            ),
                          ],
                        ))
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
