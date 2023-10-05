import 'dart:developer';

import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:agung_opr/application/spk/view/spk_search.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:dartz/dartz.dart';
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

class SPKScaffold extends ConsumerStatefulWidget {
  const SPKScaffold();

  @override
  ConsumerState<SPKScaffold> createState() => _SPKScaffoldState();
}

class _SPKScaffoldState extends ConsumerState<SPKScaffold> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _scrollController.addListener(() async {
    //     final nextPageTrigger =
    //         0.9 * _scrollController.position.maxScrollExtent;

    //     final isMore =
    //         ref.watch(spkNotifierProvider.select((value) => value.hasMore));
    //     ;

    //     final isGetting = ref
    //         .watch(spkNotifierProvider.select((value) => value.isProcessing));

    //     final page =
    //         ref.watch(spkNotifierProvider.select((value) => value.page));

    //     if (_scrollController.hasClients &&
    //         _scrollController.position.pixels > nextPageTrigger &&
    //         isMore &&
    //         !isGetting) {
    //       ref.read(spkNotifierProvider.notifier).changePage(page + 1);

    //       await ref
    //           .read(spkNotifierProvider.notifier)
    //           .getSPKListOFFLINE(page: page + 1);
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final modeApp = ref.watch(modeNotifierProvider);
    final spkProvider = ref.watch(spkNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (_scrollController.hasClients && _scrollController.hasClients) {
          _scrollController.position.notifyListeners();
        }
      },
    );

    final spkList = spkProvider.spkList;

    final isSearching = ref
        .watch(spkSearchNotifierProvider.select((value) => value.isSearching));

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: VAppBar(
          context,
          'SPK List',
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
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
                                          await FlutterBarcodeScanner
                                              .scanBarcode("#65B689", "Cancel",
                                                  false, ScanMode.DEFAULT);

                                      log('NOSPK SCAN $noSPK');

                                      if (noSPK.isNotEmpty && noSPK != '-1') {
                                        ref
                                            .read(spkSearchNotifierProvider
                                                .notifier)
                                            .changeSearchText(noSPK);

                                        await ref
                                            .read(spkNotifierProvider.notifier)
                                            .searchSPKListOFFLINE(
                                                search: noSPK);

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

                            await context.pushNamed(
                                RouteNames.checkSheetLoadingNameRoute,
                                extra: spkMap);
                          },
                        ),
                        style: ButtonStyle(
                            padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                        child: SPKItem(
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
}
