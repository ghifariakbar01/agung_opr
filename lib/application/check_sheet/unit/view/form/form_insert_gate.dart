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
import '../../../../widgets/alert_helper.dart';
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
      await ref.read(gateNotifierProvider.notifier).getGates();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                              storage: (_) =>
                                  'Storage penuh. Tidak bisa menyimpan data FRAME',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              parse: (value) => 'Parse $value',
                              orElse: () => '',
                            ),
                          ),
                        ), (gateResponse) {
                  if (gateResponse != []) {
                    ref
                        .read(gateNotifierProvider.notifier)
                        .changeGateList(gateResponse);
                  }
                })));

    final gates = ref.watch(gateNotifierProvider);

    final gateTextController = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.gateTextController));

    final gateStr = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.gate.getOrLeave('')));

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
            child: TextButton(
              onPressed: () async {
                final String? id =
                    await context.pushNamed(RouteNames.gateNameRoute);

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
                  padding: MaterialStatePropertyAll(EdgeInsets.zero)),
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
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 2,
          child: Text(
            gates.gates
                    .firstWhere((element) => element.id.toString() == gateStr,
                        orElse: () => CSUMSTGate.initial())
                    .nama ??
                '',
            style:
                Themes.customColor(FontWeight.normal, 12, Palette.primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
