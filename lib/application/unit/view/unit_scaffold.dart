// ignore_for_file: unused_result

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:agung_opr/application/widgets/v_appbar.dart';
import 'package:agung_opr/style/style.dart';

import '../../../domain/remote_failure.dart';
import '../../../shared/providers.dart';
import '../../mode/mode_state.dart';
import '../../routes/route_names.dart';
import '../../update_frame/frame.dart';
import '../../update_frame/shared/update_frame_providers.dart';
import '../widget/frame_search_barcode.dart';
import '../widget/frame_search_without.dart';
import 'unit_item.dart';

class UnitScaffold extends StatefulHookConsumerWidget {
  const UnitScaffold();

  @override
  ConsumerState<UnitScaffold> createState() => _UnitScaffoldState();
}

class _UnitScaffoldState extends ConsumerState<UnitScaffold> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final scrollController = useScrollController();
    final _page = useState(1);
    final _isAtBottom = useState(false);

    log('_page ${_page.value}');

    ref.listen<Option<Either<RemoteFailure, List<Frame>>>>(
        frameNotifierProvider.select(
          (state) => state.FOSOFrame,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold((_) {
                  _isAtBottom.value = true;
                }, (frameResponse) {
                  if (frameResponse != []) {
                    _isAtBottom.value = false;
                  }
                })));

    Future<void> onScrolled() async {
      if (_page.value < 10 &&
          _isAtBottom.value == false &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent) {
        _isAtBottom.value = true;

        await _getFrameByPage(_page.value);

        _page.value++;
      }
    }

    useEffect(
      () {
        scrollController.addListener(onScrolled);
        return () => scrollController.removeListener(onScrolled);
      },
    );

    final onRefresh = () async {
      _page.value = 0;
      _isAtBottom.value = false;
      return _getFrameByPage(_page.value);
    };

    final frameList = ref.watch(frameNotifierProvider).frameList;
    final isSearching = ref.watch(
        frameSearchNotifierProvider.select((value) => value.isSearching));
    final isLoading =
        ref.watch(frameNotifierProvider.select((value) => value.isProcessing));

    return KeyboardDismissOnTap(
      child: SafeArea(
        child: Scaffold(
            appBar: VAppBar(
              context,
              'Check Sheet Unit',
            ),
            bottomNavigationBar: Container(
              height: 63,
              width: MediaQuery.of(context).size.width,
              color: Palette.greySecondary,
              child: TextButton(
                style: ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero)),
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
                      style:
                          Themes.customColor(FontWeight.bold, 14, Colors.black),
                    )
                  ],
                ),
              ),
            ),
            // drawer: Drawer(),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: onRefresh,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(flex: 5, child: FrameSearchWithoutSPK()),
                            Flexible(flex: 1, child: FrameSearchBarcode())
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        if (!isSearching || !isLoading) ...[
                          for (int index = 0;
                              index < frameList.length;
                              index++) ...[
                            TextButton(
                              onPressed: () async {
                                ref
                                    .read(modeNotifierProvider.notifier)
                                    .changeModeAplikasi(
                                        ModeState.checkSheetUnit());

                                Map<String, dynamic> frameMap =
                                    frameList[index].toJson();

                                await context.pushNamed(
                                  extra: frameMap,
                                  RouteNames.CSUResultRoute,
                                );
                              },
                              child: UnitItem(
                                frame: frameList[index],
                              ),
                              style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.zero)),
                            ),
                          ]
                        ]
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }

  _getFrameByPage(int page) async {
    final isOffline = ref.read(isOfflineStateProvider);

    if (!isOffline) {
      await ref
          .read(frameNotifierProvider.notifier)
          .getFrameListByPage(page: page);
      await ref
          .read(frameOfflineNotifierProvider.notifier)
          .checkAndUpdateFrameOFFLINEStatusByPage(page: page);
      return;
    }

    await ref
        .read(frameOfflineNotifierProvider.notifier)
        .checkAndUpdateFrameOFFLINEStatusByPage(page: page);

    final frameOfflineOrOnline = ref.read(frameOfflineNotifierProvider);
    await frameOfflineOrOnline.maybeWhen(
      hasOfflineStorage: () => ref
          .read(frameNotifierProvider.notifier)
          .getFrameListOFFLINEByPage(page: page),
      orElse: () async {
        await ref
            .read(frameNotifierProvider.notifier)
            .getFrameListByPage(page: page);
        await ref
            .read(frameOfflineNotifierProvider.notifier)
            .checkAndUpdateFrameOFFLINEStatusByPage(page: page);
      },
    );
  }
}
