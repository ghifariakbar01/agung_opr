import 'package:agung_opr/application/mode/mode_state.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../../widgets/v_appbar.dart';
import '../csu_mst_gate.dart';
import '../gate_item.dart';
import '../providers/gate_providers.dart';
import 'gate_search.dart';

class GateScaffold extends ConsumerStatefulWidget {
  const GateScaffold();

  @override
  ConsumerState<GateScaffold> createState() => _GateScaffoldState();
}

class _GateScaffoldState extends ConsumerState<GateScaffold> {
  @override
  Widget build(BuildContext context) {
    final gateList = ref.watch(
      gateNotifierProvider.select((value) => value.gates),
    );

    return KeyboardDismissOnTap(
      child: SafeArea(
        child: Scaffold(
          appBar: VAppBar(
            context,
            'Gate List',
          ),
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GateSearch(),
                    for (int i = 0; i < gateList.length; i++) ...[
                      TextButton(
                        onPressed: () async {
                          final item = gateList[i];

                          if (item == CSUMSTGate.initial()) {
                            return;
                          }

                          ModeState modeState = ref.read(modeNotifierProvider);

                          String gateParam = modeState.maybeWhen(
                              checkSheetUnit: () => item.id.toString(),
                              orElse: () => item.nama.toString());

                          await ref
                              .read(gateNotifierProvider.notifier)
                              .saveDefaultGate(item);

                          context.pop(gateParam);
                        },
                        style: ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                        child: GateItem(
                          gate: gateList[i],
                        ),
                      )
                    ]
                  ],
                ),
              )),
          bottomNavigationBar: Container(
            height: 63,
            width: MediaQuery.of(context).size.width,
            color: Palette.greySecondary,
            child: TextButton(
              style:
                  ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
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
                    style:
                        Themes.customColor(FontWeight.bold, 14, Colors.black),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
