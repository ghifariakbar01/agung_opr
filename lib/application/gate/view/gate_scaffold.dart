import 'dart:developer';

import 'package:agung_opr/application/mode/mode_state.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../../model/shared/model_providers.dart';
import '../../spk/shared/spk_providers.dart';
import '../../widgets/v_appbar.dart';
import '../gate_item.dart';
import '../providers/gate_providers.dart';
import 'gate_search.dart';

final ScrollController _scrollController = ScrollController();

class GateScaffold extends ConsumerStatefulWidget {
  const GateScaffold();

  @override
  ConsumerState<GateScaffold> createState() => _GateScaffoldState();
}

class _GateScaffoldState extends ConsumerState<GateScaffold> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() async {
        final modelProvider = ref.read(modelNotifierProvider);

        final nextPageTrigger =
            0.9 * _scrollController.position.maxScrollExtent;

        final isMore = modelProvider.hasMore;

        final isGetting = modelProvider.isProcessing;

        final page = modelProvider.page;

        if (_scrollController.hasClients &&
            _scrollController.position.pixels > nextPageTrigger &&
            isMore &&
            !isGetting) {
          ref.read(modelNotifierProvider.notifier).changePage(page + 1);

          await ref
              .read(modelNotifierProvider.notifier)
              .getModelListOFFLINE(page: page + 1);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final gateProvider = ref.watch(gateNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _scrollController.position.notifyListeners();
      },
    );

    final gateList = gateProvider.gates;

    final isSearching = ref
        .watch(spkSearchNotifierProvider.select((value) => value.isSearching));

    ModeState modeState = ref.watch(modeNotifierProvider);

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: VAppBar(
          'Gate List',
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  GateSearch(),
                  for (int i = 0; i < gateList.length; i++) ...[
                    IgnorePointer(
                      ignoring: isSearching,
                      child: TextButton(
                        onPressed: () {
                          String gateParam = modeState.maybeWhen(
                              checkSheetUnit: () => gateList[i].id.toString(),
                              checkSheetUnitWithoutSPK: () =>
                                  gateList[i].id.toString(),
                              orElse: () => gateList[i].nama.toString());

                          context.pop(gateParam);
                        },
                        style: ButtonStyle(
                            padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                        child: GateItem(
                          gate: gateList[i],
                        ),
                      ),
                    )
                  ]
                ],
              ),
            )),
        // drawer: Drawer(),
        bottomNavigationBar: Container(
          height: 63,
          width: MediaQuery.of(context).size.width,
          color: Palette.greySecondary,
          child: TextButton(
            style:
                ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
            onPressed: () => context.pop(),
            child: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'BACK',
                  style: Themes.customColor(FontWeight.bold, 14, Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
