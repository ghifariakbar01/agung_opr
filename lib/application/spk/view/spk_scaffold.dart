import 'dart:developer';

import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:agung_opr/application/spk/view/spk_search.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../../update_frame/shared/update_frame_providers.dart';
import '../../widgets/v_appbar.dart';
import 'spk_item.dart';

final ScrollController _scrollController = ScrollController();

class SPKScaffold extends ConsumerWidget {
  const SPKScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modeApp = ref.watch(modeNotifierProvider);
    final spkProvider = ref.watch(spkNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _scrollController.position.notifyListeners();
      },
    );

    _scrollController.addListener(() async {
      final nextPageTrigger = 0.9 * _scrollController.position.maxScrollExtent;

      final isMore = spkProvider.hasMore;

      final isGetting = spkProvider.isProcessing;

      final page = spkProvider.page;

      if (_scrollController.hasClients &&
          _scrollController.position.pixels > nextPageTrigger &&
          isMore &&
          !isGetting) {
        ref.read(spkNotifierProvider.notifier).changePage(page + 1);

        await ref
            .read(spkNotifierProvider.notifier)
            .getSPKListOFFLINE(page: page + 1);
      }
    });

    final spkList = spkProvider.spkList;

    final isSearching = ref
        .watch(spkSearchNotifierProvider.select((value) => value.isSearching));

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: VAppBar(
          'SPK List (${modeApp.maybeWhen(
            initial: () {},
            updateFrameDummy: () => 'Update Frame Dummy',
            checkSheetUnit: () => 'Check Sheet Unit',
            checkSheetLoading: () => 'CS Loading',
            checkSheetUnloading: () => 'CS Unloading',
            checkSheetGateMerak: () => 'CS Gate Merak',
            assignUnitMerak: () => 'Assign Unit Merak',
            orElse: () {},
          )})',
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              controller: _scrollController,
              children: [
                Row(
                  children: [
                    Flexible(flex: 5, child: SPKSearch()),
                    Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Column(
                            children: [
                              Flexible(
                                flex: 0,
                                child: Text(
                                  'NO.SPK',
                                  textAlign: TextAlign.center,
                                  style: Themes.customColor(
                                      FontWeight.bold, 9, Colors.black),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: InkWell(
                                  onTap: () async {
                                    log('NOSPK SCAN INIT');
                                    String? noSPK =
                                        await FlutterBarcodeScanner.scanBarcode(
                                            "#65B689",
                                            "Cancel",
                                            false,
                                            ScanMode.DEFAULT);

                                    log('NOSPK SCAN $noSPK');

                                    if (noSPK.isNotEmpty) {
                                      ref
                                          .read(spkSearchNotifierProvider
                                              .notifier)
                                          .changeSearchText(noSPK);

                                      await ref
                                          .read(spkNotifierProvider.notifier)
                                          .searchSPKListOFFLINE(search: noSPK);

                                      log('NOSPK SCAN 2 $noSPK');
                                    }
                                  },
                                  child: Ink(
                                    child: Icon(
                                      Icons.qr_code_2,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
                for (int i = 0; i < spkList.length; i++) ...[
                  IgnorePointer(
                    ignoring: isSearching,
                    child: TextButton(
                      onPressed: () => modeApp.when(
                        initial: () => {},
                        updateFrameDummy: () async {
                          // INIT BACK 0
                          ref
                              .read(frameNotifierProvider.notifier)
                              .changeFrameList([]);

                          final responseLEN = 0;

                          ref
                              .read(frameNotifierProvider.notifier)
                              .changeFillEmptyFOSOSaveFrameList(
                                  length: responseLEN);

                          /// RUN [changeAllFrame] TO UPDATE PLACEHOLDERS
                          ref
                              .read(updateFrameNotifierProvider.notifier)
                              .changeFillEmptyList(
                                  length: responseLEN, frame: []);

                          //

                          await context.pushNamed(
                              RouteNames.updateFrameNameRoute,
                              extra: spkList[i].idSpk);
                        },
                        checkSheetUnit: () => context.pushNamed(
                            RouteNames.updateFrameNameRoute,
                            extra: spkList[i].idSpk),
                        // checkSheetLoading: () => context
                        //     .pushNamed(RouteNames.checkSheetLoadingNameRoute),
                        // checkSheetUnloading: () => context
                        //     .pushNamed(RouteNames.checkSheetUnloadingNameRoute),
                        // checkSheetGateMerak: () => context
                        //     .pushNamed(RouteNames.checkSheetUnloadingNameRoute),
                        // assignUnitMerak: () => context
                        //     .pushNamed(RouteNames.assignUnitMerakNameRoute),
                        // dataUpdateQuery: () => context
                        //     .pushNamed(RouteNames.dataUpdateQueryNameRoute),
                        checkSheetLoading: () => {},
                        checkSheetUnloading: () => {},
                        checkSheetGateMerak: () => {},
                        assignUnitMerak: () => {},
                        dataUpdateQuery: () => {},
                      ),
                      style: ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                      child: SPKItem(
                        nomorSpk: spkList[i].spkNo,
                        namaDriver:
                            '${spkList[i].supir1Nm ?? ''} ${spkList[i].supir2Nm != null ? '/ ${spkList[i].supir2Nm}' : ''}',
                        nomorPolisi: '${spkList[i].nopol}',
                      ),
                    ),
                  )
                ]
              ],
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
