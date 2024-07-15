import 'package:agung_opr/application/widgets/v_button.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/local_failure.dart';
import '../../../../shared/providers.dart';
import '../../../../style/style.dart';
import '../../../mode/mode_state.dart';
import '../../../routes/route_names.dart';
import '../../../widgets/alert_helper.dart';
import '../../../widgets/v_appbar.dart';
import '../shared/csu_providers.dart';
import 'form/csu_new_form.dart';
import 'widget/csu_kelengkapan.dart';

class CSUNewScaffold extends HookConsumerWidget {
  const CSUNewScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*
      CALLED Upon Saving Query
    */
    ref.listen<Option<Either<LocalFailure, Unit>>>(
        updateCSUFrameNotifierProvider.select(
          (state) => state.FOSOUpdateCSU,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => AlertHelper.showSnackBar(
                          context,
                          message: failure.map(
                            empty: (_) => 'Data kosong',
                            format: (error) => 'Error format. $error',
                            storage: (_) =>
                                'Storage penuh. Tidak bisa menyimpan data update csu',
                          ),
                        ), (_) async {
                  await ref
                      .read(updateCSUFrameOfflineNotifierProvider.notifier)
                      .CUUpdateCSUFrameOFFLINEStatus();

                  context.pop();
                  context.pop();
                  context.pushNamed(RouteNames.historyNameRoute);
                  context.pushNamed(RouteNames.dataUpdateQueryNameRoute);
                })));

    final isDefect = ref.watch(updateCSUFrameNotifierProvider.select((value) =>
        value.updateFrameList.isNG.firstWhere(
            (checkSheet) => checkSheet == true,
            orElse: () => false)));

    final _frame = ref.watch(csuFrameNotifierProvider).frame;
    final _formKey = useMemoized(GlobalKey<FormState>.new);

    return WillPopScope(
      onWillPop: () {
        ModeState modeState = ref.read(modeNotifierProvider);
        modeState.maybeWhen(
          orElse: () {},
          checkSheetUnit: () => ref
              .read(modeNotifierProvider.notifier)
              .changeModeAplikasi(ModeState.checkSheetUnit()),
        );
        return Future.value(true);
      },
      child: KeyboardDismissOnTap(
          child: SafeArea(
        child: Scaffold(
            appBar: VAppBar(context, 'Check Sheet Unit New'),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CSUNewForm(_frame),
                        SizedBox(
                          height: 8,
                        ),
                        CSUKelengkapan(),
                        VButton(
                            label: 'DEFECT',
                            color: Palette.red,
                            isEnabled: isDefect,
                            onPressed: () async {
                              if (_formKey.currentState != null) {
                                if (_formKey.currentState!.validate()) {
                                  await ref
                                      .read(updateCSUFrameNotifierProvider
                                          .notifier)
                                      .saveQuery();
                                }
                              }
                            }),
                        VButton(
                            label: 'NO DEFECT',
                            isEnabled: !isDefect,
                            onPressed: () async {
                              if (_formKey.currentState != null) {
                                if (_formKey.currentState!.validate()) {
                                  await ref
                                      .read(updateCSUFrameNotifierProvider
                                          .notifier)
                                      .saveQuery();
                                }
                              }
                            }),
                      ],
                    ),
                  ),
                ))),
      )),
    );
  }
}
