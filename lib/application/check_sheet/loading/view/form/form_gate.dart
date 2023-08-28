import 'dart:developer';

import 'package:agung_opr/application/check_sheet/shared/providers/cs_providers.dart';
import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/gate/csu_mst_gate.dart';
import 'package:agung_opr/application/gate/providers/gate_providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../domain/remote_failure.dart';
import '../../../../../shared/providers.dart';
import '../../../../../style/style.dart';
import '../../../../widgets/alert_helper.dart';

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
                                  'Storage penuh. Tidak bisa menyimpan data FRAME',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              parse: (value) => 'Parse $value',
                              orElse: () => '',
                            ),
                          ),
                        ), (gateResponse) {
                  /// SET [gateResponse] from GOT gateList
                  // debugger(message: 'called');
                  log('GATE RESPONSE: $gateResponse');
                  if (gateResponse != []) {
                    ref
                        .read(gateNotifierProvider.notifier)
                        .changeGateList(gateResponse);
                  }
                })));

    final gates = ref.watch(gateNotifierProvider);

    final gateItem = ref.watch(
        updateCSNotifierProvider.select((value) => value.updateCSForm.gate));

    final gateStr = gateItem.getOrLeave('');

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
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(color: Palette.primaryColor, width: 2),
                borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(4),
            child: DropdownButton<CSUMSTGate>(
              value: gates.gates.firstWhere(
                (element) => element.nama.toString() == gateStr,
                orElse: () => CSUMSTGate.initial(),
              ),
              elevation: 16,
              underline: Container(),
              onChanged: (CSUMSTGate? value) {
                // This is called when the user selects an item.
                if (value != null)
                  ref
                      .read(updateCSNotifierProvider.notifier)
                      .changeGate(value.nama.toString());
              },
              items: gates.gates
                  .map<DropdownMenuItem<CSUMSTGate>>((CSUMSTGate value) {
                return DropdownMenuItem<CSUMSTGate>(
                  value: value,
                  child: Text(
                    '${value.nama}',
                    style:
                        Themes.customColor(FontWeight.normal, 14, Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
