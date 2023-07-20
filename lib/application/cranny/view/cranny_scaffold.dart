import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/v_appbar.dart';
import '../../widgets/v_bottomnav.dart';
import 'cranny_item.dart';

final List<String> labels = [
  'UPDATE FRAME DUMMY',
  'CHECKSHEET CCR LOADING',
  'CHECKSHEET CCR UNLOADING',
  'CHECKSHEET GATE MERAK',
  'ASSIGN UNIT MERAK',
];

class CrannyScaffold extends ConsumerWidget {
  const CrannyScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: VAppBar(
        'CCR Cranny',
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              itemCount: labels.length,
              itemBuilder: (context, index) => TextButton(
                  onPressed: () async {
                    ref
                        .read(modeNotifierProvider.notifier)
                        .changeModeAplikasi(labels[index]);

                    await context.pushNamed(RouteNames.spkNameRoute);
                  },
                  child: CrannyItem(label: labels[index])))),
      drawer: Drawer(),
      bottomNavigationBar: VBottomNav(),
    );
  }
}
