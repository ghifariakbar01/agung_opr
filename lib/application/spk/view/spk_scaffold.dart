import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
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
    final controller = useScrollController();
    final isLoading =
        ref.watch(spkNotifierProvider.select((value) => value.isProcessing));

    final page = useState(1);

    void onScrolled() {
      final spkSearch = ref.read(spkSearchNotifierProvider.notifier);
      final _isCurrentlySearching = spkSearch.hasSearchText();

      if (page.value < 10 &&
          !isLoading &&
          !_isCurrentlySearching &&
          controller.position.pixels >= controller.position.maxScrollExtent) {
        // debugger();

        ref.read(scrollPageProvider.notifier).state++;

        page.value++;
        loadSpkOnlineOrOffline(page: page.value);
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
                    Builder(builder: (context) {
                      final spkItem = spkList[i];

                      return IgnorePointer(
                        ignoring: isSearching,
                        child: TextButton(
                          onPressed: () async {
                            Map<String, dynamic> spkMap = spkItem.toJson();
                            await context.pushNamed(
                              extra: spkMap,
                              RouteNames.checkSheetLoadingNameRoute,
                            );
                          },
                          child: SPKItem(
                            isEdit: spkItem.isEdit ?? false,
                            nomorSpk: spkItem.spkNo,
                            uUser: spkItem.updatedUser ?? '',
                            uDate: spkItem.updatedDate ?? '',
                            nomorPolisi: '${spkItem.nopol}',
                            namaTrayek: spkItem.namaTrayek ?? '',
                            tglBerangkat:
                                'TGL BERANGKAT: ${spkItem.tglBerangkat}',
                            namaDriver:
                                '${spkItem.supir1Nm ?? ''} ${spkItem.supir2Nm != null ? '/ ${spkItem.supir2Nm}' : ''}',
                          ),
                          style: ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.zero)),
                        ),
                      );
                    })
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

    if (isOffline) {
      return ref
          .read(spkNotifierProvider.notifier)
          .getSPKListOFFLINE(page: page);
    } else {
      await ref.read(spkNotifierProvider.notifier).getSPKList(page: page);
      return ref
          .read(spkOfflineNotifierProvider.notifier)
          .checkAndUpdateSPKOFFLINEStatus();
    }
  }
}
