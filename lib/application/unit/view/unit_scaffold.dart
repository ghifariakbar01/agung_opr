// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/providers.dart';
import '../../mode/mode_state.dart';
import '../../routes/route_names.dart';
import '../../update_frame/shared/update_frame_providers.dart';
import '../../widgets/v_appbar.dart';
import '../widget/frame_search_barcode.dart';
import '../widget/frame_search_without.dart';
import 'unit_item.dart';
import "package:agung_opr/shared/bottom_nav_widget.dart";

final scrollUnitPage = StateProvider<int>((ref) {
  return 1;
});

final isAtBottomUnitPage = StateProvider<bool>((ref) {
  return false;
});

class UnitScaffold extends StatefulHookConsumerWidget {
  const UnitScaffold({Key? key}) : super(key: key);

  @override
  ConsumerState<UnitScaffold> createState() => _UnitScaffoldState();
}

class _UnitScaffoldState extends ConsumerState<UnitScaffold> {
  @override
  void initState() {
    super.initState();
  }

  void _isAtBottom() {
    ref.read(isAtBottomUnitPage.notifier).state = true;
  }

  void _incrementPage() {
    ref.read(scrollUnitPage.notifier).state++;
  }

  void _reset() {
    ref.read(isAtBottomUnitPage.notifier).state = false;
    ref.read(scrollUnitPage.notifier).state = 0;
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    Future<void> onScrolled() async {
      final nearOK = scrollController.position.pixels >
          0.90 * scrollController.position.maxScrollExtent;

      final isLoading = ref.read(frameNotifierProvider).isProcessing;
      final _page = ref.read(scrollUnitPage);

      final bottom = ref.read(isAtBottomUnitPage);

      if (!isLoading && _page < 10 && nearOK && bottom == false) {
        _isAtBottom();

        await _getFrameByPage(_page);

        _incrementPage();
      }
    }

    useEffect(
      () {
        scrollController.addListener(onScrolled);
        return () => scrollController.removeListener(onScrolled);
      },
    );

    final onRefresh = () async {
      _reset();
      return _getFrameByPage(0);
    };

    final frameList = ref.watch(
      frameNotifierProvider.select((value) => value.frameList),
    );

    return KeyboardDismissOnTap(
      child: SafeArea(
        child: Scaffold(
            appBar: VAppBar(context, 'Check Sheet Unit'),
            bottomNavigationBar: BottomNavWidget(),
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
                            child: UnitItem(frame: frameList[index]),
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(EdgeInsets.zero),
                            ),
                          ),
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
      await _getFrameByPageOnline(page);

      return;
    } else {
      await ref
          .read(frameOfflineNotifierProvider.notifier)
          .checkAndUpdateFrameOFFLINEStatusByPage(page: page);

      final frameOfflineOrOnline = ref.read(frameOfflineNotifierProvider);
      await frameOfflineOrOnline.maybeWhen(
        hasOfflineStorage: () => ref
            .read(frameNotifierProvider.notifier)
            .getFrameListOFFLINEByPage(page: page),
        orElse: () => _getFrameByPageOnline(page),
      );

      return;
    }
  }

  _getFrameByPageOnline(int page) async {
    await ref
        .read(frameNotifierProvider.notifier)
        .getFrameListByPage(page: page);

    await ref
        .read(frameOfflineNotifierProvider.notifier)
        .checkAndUpdateFrameOFFLINEStatusByPage(page: page);
  }
}
