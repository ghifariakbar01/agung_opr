import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../../check_sheet/shared/providers/cs_providers.dart';
import '../../clear_data/clear_data_providers.dart';
import '../../update_frame/shared/update_frame_providers.dart';
import 'cranny_appbar.dart';
import 'cranny_item.dart';
import 'cs/cs_cranny_column.dart';

class CrannyScaffold extends ConsumerStatefulWidget {
  const CrannyScaffold();

  @override
  ConsumerState<CrannyScaffold> createState() => _CrannyScaffoldState();
}

class _CrannyScaffoldState extends ConsumerState<CrannyScaffold> {
  @override
  Widget build(BuildContext context) {
    final jobdesk =
        ref.watch(userNotifierProvider.select((value) => value.user.jobdesk));
    final _isCranny = jobdesk!.toLowerCase() == 'cranny';

    final updateFrameOfflineOrOnline =
        ref.watch(updateFrameOfflineNotifierProvider);

    final updateCSUFrameOfflineOrOnline =
        ref.watch(updateCSUFrameOfflineNotifierProvider);

    final updateCSfflineOrOnline = ref.watch(updateCSOfflineNotifierProvider);

    final isUpdateAvailable = updateFrameOfflineOrOnline.maybeWhen(
            hasOfflineStorage: () => true, orElse: () => false) ||
        updateCSUFrameOfflineOrOnline.maybeWhen(
            hasOfflineStorage: () => true,
            orElse: () =>
                false ||
                updateCSfflineOrOnline.maybeWhen(
                    hasOfflineStorage: () => true, orElse: () => false));

    final isOffline = ref.watch(isOfflineStateProvider);
    final getBuild = ref.watch(getBuildProvider);

    return Scaffold(
      appBar: CrannyAppBar(),
      floatingActionButton: !isOffline
          ? FloatingActionButton.small(
              backgroundColor: Colors.white,
              elevation: 5,
              child: Icon(
                Icons.storage,
                color: Palette.primaryColor,
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (c) {
                    return AlertDialog(
                      title: Text('Hapus data tersimpan ?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Kembali'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Hapus data frame & spk'),
                          onPressed: () {
                            context.pop();
                            ref
                                .read(clearDataNotifierProvider.notifier)
                                .clearAllStorage();
                          },
                        ),
                      ],
                    );
                  }),
            )
          : FloatingActionButton.small(
              backgroundColor: Colors.white,
              elevation: 5,
              child: Icon(
                Icons.signal_cellular_connected_no_internet_0_bar_rounded,
                color: Palette.primaryColor,
              ),
              onPressed: () {},
            ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              ListView(
                children: [
                  if (isOffline) ...[
                    Center(
                      child: Text(
                        '( MODE OFFLINE )',
                        style: Themes.customColor(
                            FontWeight.bold, 15, Palette.primaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                  if (isUpdateAvailable) ...[
                    TextButton(
                        onPressed: () async {
                          await context
                              .pushNamed(RouteNames.dataUpdateQueryNameRoute);
                        },
                        child: CrannyItem(label: 'DATA AKAN DIUPDATE'))
                  ],
                  TextButton(
                      onPressed: () =>
                          context.pushNamed(RouteNames.historyName),
                      child: CrannyItem(label: 'RIWAYAT UPDATE')),
                  if (_isCranny) ...[
                    CSCrannyColumn(),
                    const SizedBox(height: 8),
                  ],
                  if (_isCranny == false) ...[
                    TextButton(
                        onPressed: () => context.pushNamed(RouteNames.unitName),
                        child: CrannyItem(label: 'CHECK SHEET UNIT')),
                  ]
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: getBuild.when(
                    data: (data) => InkWell(
                          onTap: () =>
                              context.pushNamed(RouteNames.copyrightNameRoute),
                          child: Ink(
                            child: Text(
                              'Build ${data.version}',
                              style: Themes.customColor(
                                  FontWeight.normal, 11, Palette.primaryColor),
                            ),
                          ),
                        ),
                    error: (error, stackTrace) => Text('Error'),
                    loading: () => Container()),
              ),
            ],
          )),
    );
  }
}
