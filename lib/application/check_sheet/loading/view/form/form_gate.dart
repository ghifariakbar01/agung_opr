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
import '../../../shared/providers/cs_providers.dart';

/// [TextEditingController] For displaying value only
///
///
class FormGate extends ConsumerStatefulWidget {
  const FormGate();

  @override
  ConsumerState<FormGate> createState() => _FormGateState();
}

class _FormGateState extends ConsumerState<FormGate> {
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
                                  'Storage penuh. Tidak bisa menyimpan data gate',
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
                    final def = ref.read(gateNotifierProvider).defaultGate;

                    if (def == CSUMSTGate.initial()) {
                      return;
                    }

                    ref
                        .read(updateCSNotifierProvider.notifier)
                        .changeGate(def.nama ?? '');
                  }
                })));

    final gates = ref.watch(gateNotifierProvider);
    final defaultGate = gates.defaultGate;

    final gateTextController = ref.watch(updateCSNotifierProvider
        .select((value) => value.updateCSForm.gateTextController));

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
          child: Builder(builder: (_) {
            if (defaultGate == CSUMSTGate.initial()) {
              //
            } else {
              final _nama = defaultGate.nama.toString();
              gateTextController.text = _nama;
            }

            return TextButton(
              onPressed: () async {
                final String? nama =
                    await context.pushNamed(RouteNames.gateNameRoute);

                if (nama != null) {
                  ref.read(updateCSNotifierProvider.notifier).changeGate(nama);

                  ref
                      .read(updateCSNotifierProvider)
                      .updateCSForm
                      .gateTextController
                      .text = nama;
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
                      .read(updateCSNotifierProvider)
                      .updateCSForm
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
        SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
