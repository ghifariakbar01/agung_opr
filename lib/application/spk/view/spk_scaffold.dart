import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:agung_opr/application/spk/view/spk_search.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
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
          'SPK List (${modeApp.when(
            initial: () {},
            updateFrameDummy: () => 'Update Frame Dummy',
            checkSheetLoading: () => 'CS Loading',
            checkSheetUnloading: () => 'CS Unloading',
            checkSheetGateMerak: () => 'CS Gate Merak',
            assignUnitMerak: () => 'Assign Unit Merak',
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
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                IconButton(
                                    iconSize: 45,
                                    onPressed: () async {
                                      String? noSPK = await context.pushNamed(
                                          RouteNames.scanSPKNameRoute);

                                      if (noSPK != null) {
                                        final noSPKSearch = ref
                                            .read(spkSearchNotifierProvider
                                                .notifier)
                                            .extractNumbers(noSPK);

                                        ref
                                            .read(spkSearchNotifierProvider
                                                .notifier)
                                            .changeSearchText(noSPKSearch);

                                        await ref
                                            .read(spkNotifierProvider.notifier)
                                            .searchSPKListOFFLINE(
                                                search: noSPKSearch);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.qr_code_2,
                                      color: Colors.black,
                                    )),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'NO.SPK',
                                    style: Themes.customColor(
                                        FontWeight.bold, 10, Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
                for (int i = 0; i < spkList.length; i++) ...[
                  IgnorePointer(
                    ignoring: isSearching,
                    child: TextButton(
                      onPressed: () => modeApp.when(
                        initial: () => {},
                        updateFrameDummy: () => context.pushNamed(
                            RouteNames.updateFrameNameRoute,
                            extra: spkList[i].idSpk),
                        checkSheetLoading: () => context
                            .pushNamed(RouteNames.checkSheetLoadingNameRoute),
                        checkSheetUnloading: () => context
                            .pushNamed(RouteNames.checkSheetUnloadingNameRoute),
                        checkSheetGateMerak: () => context
                            .pushNamed(RouteNames.checkSheetUnloadingNameRoute),
                        assignUnitMerak: () => context
                            .pushNamed(RouteNames.assignUnitMerakNameRoute),
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
        drawer: Drawer(),
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
