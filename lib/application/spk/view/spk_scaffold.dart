import 'dart:developer';

import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../../update_frame/shared/update_frame_providers.dart';
import '../../widgets/v_appbar.dart';
import 'spk_header.dart';
import 'spk_item.dart';

class SPKScaffold extends StatefulHookConsumerWidget {
  const SPKScaffold();

  @override
  ConsumerState<SPKScaffold> createState() => _SPKScaffoldState();
}

final scrollPageProvider = StateProvider<int>((ref) {
  return 0;
});

class _SPKScaffoldState extends ConsumerState<SPKScaffold> {
  @override
  Widget build(BuildContext context) {
    final hideDone = useState(false);

    final modeApp = ref.watch(modeNotifierProvider);
    final spkProvider = ref.watch(spkNotifierProvider);

    final spkList = hideDone.value
        ? spkProvider.spkList
            .where(
                (element) => element.isEdit != null && element.isEdit == true)
            .toList()
        : spkProvider.spkList
            .where(
                (element) => element.isEdit != null && element.isEdit == false)
            .toList();

    final isSearching = ref
        .watch(spkSearchNotifierProvider.select((value) => value.isSearching));

    /* --- SCROLL CONTROLLER START ---*/
    ref.watch(scrollPageProvider);
    final controller = useScrollController();
    final isLoading =
        ref.watch(spkNotifierProvider.select((value) => value.isProcessing));

    void onScrolled() {
      final page = ref.read(scrollPageProvider);

      final spkSearch = ref.read(spkSearchNotifierProvider.notifier);
      final _isCurrentlySearching = spkSearch.hasSearchText();

      if (page < 6 &&
          !isLoading &&
          !_isCurrentlySearching &&
          controller.position.pixels >= controller.position.maxScrollExtent) {
        // debugger();

        int pageState = ref.read(scrollPageProvider.notifier).state;
        pageState = pageState + 1;

        loadSpkOnlineOrOffline(page: page);
        // debugger();
      }
    }

    useEffect(() {
      controller.addListener(onScrolled);
      return () => controller.removeListener(onScrolled);
    }, [controller]);
    /* --- SCROLL CONTROLLER END ---*/

    final isOffline = ref.watch(isOfflineStateProvider);

    final hideDoneListenable = useValueNotifier(hideDone);

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: VAppBar(
          context,
          'SPK List ${isOffline ? '(Offline)' : ''}',
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  ValueListenableBuilder<ValueNotifier<bool>>(
                    valueListenable: hideDoneListenable,
                    builder: (_, value, __) => SpkHeader(value),
                  ),
                  for (int i = 0; i < spkList.length; i++) ...[
                    IgnorePointer(
                      ignoring: isSearching,
                      child: TextButton(
                        onPressed: () => modeApp.maybeWhen(
                          initial: () => {},
                          updateFrameDummy: () async {
                            // INIT BACK 0
                            ref
                                .read(frameNotifierProvider.notifier)
                                .changeFrameList([]);

                            ref
                                .read(frameNotifierProvider.notifier)
                                .changeFillEmptyFOSOSaveFrameList(length: 0);

                            /// RUN [changeAllFrame] TO UPDATE PLACEHOLDERS
                            ref
                                .read(updateFrameNotifierProvider.notifier)
                                .changeFillEmptyList(length: 0, frame: []);

                            //

                            await context.pushNamed(
                                RouteNames.updateFrameNameRoute,
                                extra: spkList[i].idSpk);

                            return unit;
                          },
                          checkSheetUnit: () async {
                            // INIT BACK 0
                            ref
                                .read(frameNotifierProvider.notifier)
                                .changeFrameList([]);

                            ref
                                .read(frameNotifierProvider.notifier)
                                .changeFillEmptyFOSOSaveFrameList(length: 0);

                            /// RUN [changeAllFrame] TO UPDATE PLACEHOLDERS
                            ref
                                .read(updateFrameNotifierProvider.notifier)
                                .changeFillEmptyList(length: 0, frame: []);

                            //

                            await context.pushNamed(
                                RouteNames.updateFrameNameRoute,
                                extra: spkList[i].idSpk);

                            return unit;
                          },
                          checkSheetGateMerak: () => {},
                          assignUnitMerak: () => {},
                          dataUpdateQuery: () => {},
                          // LOADING, UNLOADING, LOADING & UNLOADING
                          orElse: () async {
                            Map<String, dynamic> spkMap = spkList[i].toJson();

                            return context.pushNamed(
                                RouteNames.checkSheetLoadingNameRoute,
                                extra: spkMap);
                          },
                        ),
                        style: ButtonStyle(
                            padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                        child: SPKItem(
                          isEdit: spkList[i].isEdit ?? false,
                          uUser: spkList[i].updatedUser ?? '',
                          uDate: spkList[i].updatedDate ?? '',
                          nomorSpk: spkList[i].spkNo,
                          nomorPolisi: '${spkList[i].nopol}',
                          namaTrayek: spkList[i].namaTrayek ?? '',
                          tglBerangkat:
                              'TGL BERANGKAT: ${spkList[i].tglBerangkat}',
                          namaDriver:
                              '${spkList[i].supir1Nm ?? ''} ${spkList[i].supir2Nm != null ? '/ ${spkList[i].supir2Nm}' : ''}',
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

  //
  Future<void> loadSpkOnlineOrOffline({required int page}) async {
    final isOffline = ref.read(isOfflineStateProvider);

    log('page $page');

    if (isOffline) {
      return ref
          .read(spkNotifierProvider.notifier)
          .getSPKListOFFLINE(page: page);
    } else {
      await ref.read(spkNotifierProvider.notifier).getSPKList(page: page);

      await ref
          .read(spkOfflineNotifierProvider.notifier)
          .checkAndUpdateSPKOFFLINEStatus();
    }
  }
}
