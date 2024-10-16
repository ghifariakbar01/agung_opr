import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../domain/remote_failure.dart';
import '../../../../../shared/providers.dart';
import '../../../../../style/style.dart';
import '../../../../gate/csu_mst_gate.dart';
import '../../../../gate/providers/gate_providers.dart';
import '../../../../routes/route_names.dart';
import '../../../../../common/widgets/alert_helper.dart';
import '../../shared/csu_providers.dart';

/// [TextEditingController] For displaying value only
///
///
class FormInsertGate extends ConsumerStatefulWidget {
  const FormInsertGate();

  @override
  ConsumerState<FormInsertGate> createState() => _FormInsertGateState();
}

class _FormInsertGateState extends ConsumerState<FormInsertGate> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isOffline = ref.read(isOfflineStateProvider);
      if (!isOffline) {
        await ref.read(gateNotifierProvider.notifier).getGates();
        await ref
            .read(gateOfflineNotifierProvider.notifier)
            .checkAndUpdateGateOFFLINEStatus();
        return;
      }

      await ref
          .read(gateOfflineNotifierProvider.notifier)
          .checkAndUpdateGateOFFLINEStatus();

      final gateOfflineOrOnline = ref.watch(gateOfflineNotifierProvider);

      await gateOfflineOrOnline.maybeWhen(
        hasOfflineStorage: () =>
            ref.read(gateNotifierProvider.notifier).getGatesOFFLINE(),
        orElse: () async {
          await ref.read(gateNotifierProvider.notifier).getGates();
          await ref
              .read(gateOfflineNotifierProvider.notifier)
              .checkAndUpdateGateOFFLINEStatus();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final gates = ref.watch(gateNotifierProvider);
    final defaultGate = gates.defaultGate;

    final gateTextController = ref.watch(updateCSUFrameNotifierProvider.select(
      (value) => value.updateFrameList.gateTextController,
    ));

    final gateStr = ref.watch(updateCSUFrameNotifierProvider.select((value) =>
        value.updateFrameList.gate.getOrLeave(
            defaultGate == CSUMSTGate.initial()
                ? ''
                : defaultGate.id.toString())));

    ref.listen<Option<Either<RemoteFailure, List<CSUMSTGate>>>>(
        gateNotifierProvider.select(
          (state) => state.FOSOGate,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => failure.maybeMap(
                          noConnection: (value) => ref
                              .read(isOfflineStateProvider.notifier)
                              .state = true,
                          orElse: () => AlertHelper.showSnackBar(
                            context,
                            message: failure.maybeMap(
                              orElse: () => '',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              parse: (value) => 'Parse $value',
                              storage: (_) =>
                                  'Storage penuh. Tidak bisa menyimpan data gate',
                            ),
                          ),
                        ), (gateResponse) {
                  if (gateResponse != []) {
                    final list = gateResponse
                        .where((e) => e.isCsu == null ? false : e.isCsu == true)
                        .toList();

                    ref
                        .read(gateNotifierProvider.notifier)
                        .changeGateList(list);

                    final def = ref.read(gateNotifierProvider).defaultGate;

                    if (def == CSUMSTGate.initial()) {
                      return;
                    }

                    ref
                        .read(updateCSUFrameNotifierProvider.notifier)
                        .changeGate(def.id.toString());

                    gateTextController.text = def.id.toString();
                  }
                })));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: SizedBox(
            height: 70,
            width: 65,
            child: Center(
              child: Text(
                'LOKASI/GATE',
                style: Themes.customColor(
                    FontWeight.bold, 14, Palette.primaryColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 1,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Palette.primaryColor, width: 2),
            ),
            child: Builder(builder: (_) {
              return TextButton(
                onPressed: () async {
                  final String? id = await context.pushNamed(
                    RouteNames.gateNameRoute,
                    extra: true,
                  );

                  if (id != null) {
                    ref
                        .read(updateCSUFrameNotifierProvider.notifier)
                        .changeGate(id);

                    ref
                        .read(updateCSUFrameNotifierProvider)
                        .updateFrameList
                        .gateTextController
                        .text = id;
                  }
                },
                style: ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                child: IgnorePointer(
                  ignoring: true,
                  child: TextFormField(
                    controller: gateTextController,
                    decoration: Themes.formStyle(
                      'Pilih Gate',
                    ),
                    keyboardType: TextInputType.name,
                    onChanged: (value) => {},
                    validator: (_) => ref
                        .read(updateCSUFrameNotifierProvider)
                        .updateFrameList
                        .gate
                        .value
                        .fold(
                          (f) => f.maybeMap(
                            empty: (_) => 'Silahkan Masukan Gate disini',
                            orElse: () => null,
                          ),
                          (_) => null,
                        ),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 2,
          child: Text(
            textAlign: TextAlign.center,
            gates.gates
                    .firstWhere(
                      (element) => element.id.toString() == gateStr,
                      orElse: () => CSUMSTGate.initial(),
                    )
                    .nama ??
                '',
            style:
                Themes.customColor(FontWeight.normal, 12, Palette.primaryColor),
          ),
        ),
      ],
    );
  }
}
