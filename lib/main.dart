import 'dart:developer';

import 'package:agung_opr/application/auto_data/shared/auto_data_providers.dart';
import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'application/check_sheet/shared/providers/cs_providers.dart';
import 'application/spk/shared/spk_providers.dart';
import 'application/tc/shared/tc_providers.dart';
import 'application/update_spk/providers/update_spk_providers.dart';
import 'config/configuration.dart';
import 'shared/providers.dart';
import 'style/style.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  Themes.initUiOverlayStyle();

  BuildConfig.init(flavor: const String.fromEnvironment('flavor'));

  runApp(ProviderScope(child: MyApp()));
}

final initializationProvider = FutureProvider<Unit>((ref) async {
  // await ref.read(hiveProvider).init();
  ref.read(dioProvider)
    ..options = BaseOptions(
      connectTimeout: BuildConfig.get().connectTimeout,
      receiveTimeout: BuildConfig.get().receiveTimeout,
      validateStatus: (status) {
        return true;
      },
      baseUrl: BuildConfig.get().baseUrl,
    )
    ..interceptors.add(ref.read(authInterceptorProvider));

  if (!BuildConfig.isProduction) {
    ref.read(dioProvider).interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ));
  }

  final authNotifier = ref.read(authNotifierProvider.notifier);
  await authNotifier.checkAndUpdateAuthStatus();

  final tcNotifier = ref.read(tcNotifierProvider.notifier);
  await tcNotifier.checkAndUpdateStatusTC();

  // SPK DATA ONLINE / OFFLINE
  await ref
      .read(spkOfflineNotifierProvider.notifier)
      .checkAndUpdateSPKOFFLINEStatus();

  final spkOfflineOrOnline = ref.watch(spkOfflineNotifierProvider);

  log('spkOfflineOrOnline $spkOfflineOrOnline');

  await spkOfflineOrOnline.maybeWhen(
    hasOfflineStorage: () =>
        ref.read(spkNotifierProvider.notifier).getSPKListOFFLINE(page: 0),
    orElse: () async {
      await ref.read(spkNotifierProvider.notifier).getSPKList(page: 0);

      await ref
          .read(spkOfflineNotifierProvider.notifier)
          .checkAndUpdateSPKOFFLINEStatus();
    },
  );

  // UPDATE FRAME DATA ONLINE / OFFLINE
  await ref
      .read(updateFrameOfflineNotifierProvider.notifier)
      .CUUpdateFrameOFFLINEStatus();

  final updateFrameOfflineOrOnline =
      ref.watch(updateFrameOfflineNotifierProvider);

  log('updateFrameOfflineOrOnline $updateFrameOfflineOrOnline');

  await updateFrameOfflineOrOnline.maybeWhen(
    hasOfflineStorage: () => ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedQueryFromRepository(),
    orElse: () {},
  );

  // UPDATE CSU FRAME DATA ONLINE / OFFLINE
  await ref
      .read(updateCSUFrameOfflineNotifierProvider.notifier)
      .CUUpdateCSUFrameOFFLINEStatus();

  final updateCSUrameOfflineOrOnline =
      ref.watch(updateCSUFrameOfflineNotifierProvider);

  log('updateCSUrameOfflineOrOnline $updateCSUrameOfflineOrOnline');

  await updateCSUrameOfflineOrOnline.maybeWhen(
    hasOfflineStorage: () => ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedCSUQueryFromRepository(),
    orElse: () {},
  );

  // UPDATE CS FRAME DATA ONLINE / OFFLINE
  await ref
      .read(updateCSOfflineNotifierProvider.notifier)
      .CUUpdateCSOFFLINEStatus();

  final updateCSOfflineOrOnline = ref.watch(updateCSOfflineNotifierProvider);

  log('updateCSOfflineOrOnline $updateCSOfflineOrOnline');

  await updateCSOfflineOrOnline.maybeWhen(
    hasOfflineStorage: () => ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedCSQueryFromRepository(),
    orElse: () {},
  );

  // UPDATE SPK DATA ONLINE / OFFLINE
  await ref
      .read(updateSPKOfflineNotifierProvider.notifier)
      .CUUpdateSPKOFFLINEStatus();

  final updateSPKOfflineOrOnline = ref.watch(updateSPKOfflineNotifierProvider);

  log('updateSPKOfflineOrOnline $updateSPKOfflineOrOnline');

  await updateSPKOfflineOrOnline.maybeWhen(
    hasOfflineStorage: () => ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedSPKQueryFromRepository(),
    orElse: () {},
  );

  return unit;
});

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initializationProvider, (_, __) {});

    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
