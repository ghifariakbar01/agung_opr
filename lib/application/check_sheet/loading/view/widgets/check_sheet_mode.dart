import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/providers.dart';
import '../../../../../style/style.dart';
import '../../../../mode/mode_state.dart';
import '../../../../routes/route_names.dart';
import '../../../../update_frame/shared/update_frame_providers.dart';
import '../../../shared/providers/cs_providers.dart';

class CSMode extends ConsumerWidget {
  const CSMode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateCS = ref.watch(updateCSNotifierProvider);

    final modeList = updateCS.modeList;
    final modelListSelected = updateCS.modeSelected;

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(4),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '---- MODE CCR ----',
                style: Themes.customColor(
                    FontWeight.bold, 14, Palette.primaryColor),
              ),
            ],
          ),
          SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: DropdownButton<ModeState>(
                value: modeList.firstWhere(
                  (element) => element == modelListSelected,
                  orElse: () => ModeState.initial(),
                ),
                elevation: 16,
                underline: Container(),
                icon: Container(),
                onChanged: (ModeState? value) async {
                  // This is called when the user selects an item.
                  if (value != null)
                    ref
                        .read(updateCSNotifierProvider.notifier)
                        .changeModeState(value);

                  log('Mode State : ${value}');

                  if (value != null)
                    await value.maybeWhen(
                        checkSheetLoading: () async {
                          ModeState mode = ModeState.checkSheetLoading();

                          _changeInitialAndMode(ref, mode);
                          const int id = 1;
                          ref
                              .read(csItemNotifierProvider.notifier)
                              .changeId(id);

                          final spkSelected =
                              ref.read(updateCSNotifierProvider).selectedSPK;

                          context.pop();
                          Map<String, dynamic> spkMap = spkSelected.toJson();

                          await context.pushNamed(
                              RouteNames.checkSheetLoadingNameRoute,
                              extra: spkMap);
                        },
                        checkSheetLoadingUnloading: () async {
                          ModeState mode =
                              ModeState.checkSheetLoadingUnloading();

                          _changeInitialAndMode(ref, mode);
                          const int id = 2;
                          ref
                              .read(csItemNotifierProvider.notifier)
                              .changeId(id);

                          final spkSelected =
                              ref.read(updateCSNotifierProvider).selectedSPK;

                          context.pop();
                          Map<String, dynamic> spkMap = spkSelected.toJson();

                          await context.pushNamed(
                              RouteNames.checkSheetLoadingNameRoute,
                              extra: spkMap);
                        },
                        checkSheetUnloading: () async {
                          ModeState mode = ModeState.checkSheetUnloading();

                          _changeInitialAndMode(ref, mode);
                          const int id = 3;
                          ref
                              .read(csItemNotifierProvider.notifier)
                              .changeId(id);

                          final spkSelected =
                              ref.read(updateCSNotifierProvider).selectedSPK;

                          context.pop();
                          Map<String, dynamic> spkMap = spkSelected.toJson();

                          await context.pushNamed(
                              RouteNames.checkSheetLoadingNameRoute,
                              extra: spkMap);
                        },
                        orElse: () {});
                },
                items: modeList
                    .map<DropdownMenuItem<ModeState>>((ModeState value) {
                  return DropdownMenuItem<ModeState>(
                    value: value,
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Palette.primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '${value.toString().replaceAll('ModeState.checkSheet', '').replaceAll('()', '').replaceAll('LoadingUnloading', 'Loading & Unloading')}',
                        style: Themes.customColor(
                            FontWeight.normal, 14, Colors.black),
                      ),
                    ),
                  );
                }).toList(),
              ))
        ],
      ),
    );
  }

  void _changeInitialAndMode(WidgetRef ref, ModeState mode) {
    ref.read(frameNotifierProvider.notifier).changeFillInitial();
    ref.read(updateCSNotifierProvider.notifier).changeFillInitial();
    ref.read(modeNotifierProvider.notifier).changeModeAplikasi(mode);
    ref.read(updateCSNotifierProvider.notifier).changeTipe(mode);
  }
}
