import 'package:agung_opr/application/double/double_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';
import '../../../../style/style.dart';
import '../../../mode/mode_state.dart';
import '../../../routes/route_names.dart';

import '../../../../common/widgets/v_appbar.dart';
import '../../../../common/widgets/v_async_widget.dart';
import "package:agung_opr/application/check_sheet/loading/view/check_sheet_loading_body.dart.dart";

final hideKelengkapanAndButtonProvider = StateProvider<bool>((ref) {
  return false;
});

final hideFABProvider = StateProvider<bool>((ref) {
  return true;
});

class CheckSheetLoadingScaffold extends ConsumerStatefulWidget {
  const CheckSheetLoadingScaffold();

  @override
  ConsumerState<CheckSheetLoadingScaffold> createState() =>
      _CheckSheetLoadingScaffoldState();
}

class _CheckSheetLoadingScaffoldState
    extends ConsumerState<CheckSheetLoadingScaffold> {
  @override
  Widget build(BuildContext context) {
    final ModeState modeApp = ref.watch(modeNotifierProvider);

    final bool hideKelengkapanAndButton =
        ref.watch(hideKelengkapanAndButtonProvider);
    final bool hideFAB = ref.watch(hideFABProvider);
    final bool isOffline = ref.watch(isOfflineStateProvider);

    final _controller = ref.watch(doubleControllerProvider);

    ref.listen<AsyncValue>(doubleControllerProvider, (_, state) {
      if (!state.isLoading &&
          state.hasValue &&
          state.value != '' &&
          state.value != null &&
          state.hasError == false) {
        ref.invalidate(doubleNotifierProvider);
      }
    });

    return KeyboardDismissOnTap(
        child: VAsyncValueWidget<void>(
      value: _controller,
      data: (_) => Scaffold(
        appBar: VAppBar(
            context,
            '${modeApp.maybeWhen(
              checkSheetLoading: () => 'CCR Loading',
              checkSheetUnloading: () => 'CCR Unloading',
              checkSheetLoadingUnloading: () => 'CCR Loading & Unloading',
              orElse: () {},
            )}',
            leading: IconButton(
                onPressed: () => context.pop(), icon: Icon(Icons.arrow_back))),
        body: CheckSheetLoadingBody(),
        floatingActionButton: hideFAB || hideKelengkapanAndButton
            ? Container()
            : isOffline
                ? FloatingActionButton.small(
                    backgroundColor: Colors.white,
                    elevation: 5,
                    child: Icon(
                      Icons.signal_cellular_connected_no_internet_0_bar_rounded,
                      color: Palette.primaryColor,
                    ),
                    onPressed: () {},
                  )
                : FloatingActionButton.extended(
                    backgroundColor: Colors.white,
                    elevation: 5,
                    label: Text(
                      'Submit',
                      style: Themes.customColor(
                          FontWeight.normal, 11, Colors.black),
                    ),
                    icon: Icon(
                      Icons.download,
                      color: Palette.primaryColor,
                    ),
                    onPressed: () =>
                        context.pushNamed(RouteNames.dataUpdateQueryNameRoute),
                  ),
      ),
    ));
  }
}

// final csItem = ref.watch(csItemNotifierProvider);
// final csIdMap = csItem.csItemListByID;

// final updateCS = ref.watch(updateCSNotifierProvider);
// final isNGEmpty = updateCS.updateCSForm.isNG.isEmpty;

// final showErrorMessage = ref.watch(
//   updateCSNotifierProvider.select((value) => value.showErrorMessages));
