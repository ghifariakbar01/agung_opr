import 'package:agung_opr/application/mode/mode_state.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:agung_opr/constants/constants.dart';
import 'package:agung_opr/common/widgets/bottom_nav_widget.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../check_sheet/shared/providers/cs_providers.dart';
import '../../../common/widgets/v_appbar.dart';
import 'spk_header.dart';
import 'spk_item.dart';

final scrollPageProvider = StateProvider<int>((ref) {
  return 0;
});

final isBottomSPK = StateProvider<bool>((ref) {
  return false;
});

class SPKScaffold extends StatefulHookConsumerWidget {
  const SPKScaffold();

  @override
  ConsumerState<SPKScaffold> createState() => _SPKScaffoldState();
}

class _SPKScaffoldState extends ConsumerState<SPKScaffold> {
  void _isAtBottom() {
    ref.read(isBottomSPK.notifier).state = true;
  }

  void _incrementPage() {
    ref.read(scrollPageProvider.notifier).state++;
  }

  @override
  Widget build(BuildContext context) {
    final hideDone = useState(false);

    final spkProvider = ref.watch(spkNotifierProvider);

    final _isEditedSPK = spkProvider.spkList
        .where((element) => element.isEdit != null && element.isEdit == true)
        .toList();

    final _isNotEditedSPK = spkProvider.spkList
        .where((element) => element.isEdit != null && element.isEdit == false)
        .toList();

    final spkList = hideDone.value ? _isEditedSPK : _isNotEditedSPK;

    /* --- SCROLL CONTROLLER START ---*/
    final controller = useScrollController();
    final isLoading =
        ref.watch(spkNotifierProvider.select((value) => value.isProcessing));

    final page = ref.watch(scrollPageProvider);

    Future<void> onScrolled() async {
      final spkSearch = ref.read(spkSearchNotifierProvider.notifier);
      final _isCurrentlySearching = spkSearch.hasSearchText();

      final _isScrolledBottom =
          controller.position.pixels >= controller.position.maxScrollExtent;

      final _isBottom = ref.read(isBottomSPK);

      if (!isLoading &&
          !_isCurrentlySearching &&
          page < 10 &&
          _isBottom == false &&
          _isScrolledBottom) {
        if (Constants.isTesting) {
          return;
        }

        _isAtBottom();

        await loadSpkOnlineOrOffline(page: page + 1);

        _incrementPage();
      }
    }

    useEffect(
      () {
        controller.addListener(onScrolled);
        return () => controller.removeListener(onScrolled);
      },
    );
    /* --- SCROLL CONTROLLER END ---*/

    final isOffline = ref.watch(isOfflineStateProvider);

    final hideDoneListenable = useValueNotifier(hideDone);

    return KeyboardDismissOnTap(
      child: SafeArea(
        child: Scaffold(
          appBar: VAppBar(context, 'SPK List ${isOffline ? '(Offline)' : ''}'),
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

                        return TextButton(
                          onPressed: () async {
                            changeModeAndTipe();

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
                              padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                        );
                      })
                    ]
                  ],
                ),
              )),
          bottomNavigationBar: BottomNavWidget(),
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

  void changeModeAndTipe() {
    final mode = ModeState.checkSheetLoading();

    ref.read(modeNotifierProvider.notifier).changeModeAplikasi(mode);
    ref.read(updateCSNotifierProvider.notifier).changeTipe(mode);
  }
}
