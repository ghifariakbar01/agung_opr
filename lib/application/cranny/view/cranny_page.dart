import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upgrader/upgrader.dart';

import '../../../constants/assets.dart';
import '../../../domain/local_failure.dart';
import '../../../domain/remote_failure.dart';
import '../../../domain/user_failure.dart';
import '../../../shared/providers.dart';
import '../../auto_data/view/data_update_linear_progress.dart';
import '../../clear_data/clear_data_providers.dart';
import '../../model/shared/model_providers.dart';
import '../../user/user_model.dart';
import '../../../common/widgets/loading_overlay.dart';
import '../../../common/widgets/v_dialogs.dart';
import 'cranny_middle.dart';

class CrannyPage extends StatefulHookConsumerWidget {
  const CrannyPage();

  @override
  ConsumerState<CrannyPage> createState() => _CrannyPageState();
}

class _CrannyPageState extends ConsumerState<CrannyPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(userNotifierProvider.notifier).getUser());
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useState(false);

    // MODEL function get and update offline status
    Future<void> modelFunction() async {
      for (int i = 0; i < 5; i++) {
        await ref.read(modelNotifierProvider.notifier).getModelList(page: i);
      }

      final list = await ref
          .read(modelNotifierProvider.notifier)
          .initModelListOFFLINE(limit: 5);

      ref.read(modelNotifierProvider.notifier).replaceModelList(list);

      await ref
          .read(modelOfflineNotifierProvider.notifier)
          .checkAndUpdateModelOFFLINEStatus();
    }

    //
    ref.listen<Option<Either<UserFailure, String?>>>(
        userNotifierProvider.select(
          (state) => state.failureOrSuccessOption,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => VSimpleDialog(
                            label: 'Error',
                            labelDescription: failure.maybeMap(
                                empty: (_) => 'No user found',
                                unknown: (unkn) =>
                                    '${unkn.errorCode} ${unkn.message}',
                                orElse: () => ''),
                            asset: Assets.iconCrossed,
                          ),
                        ), (_str) async {
                  Either<UserFailure, UserModelWithPassword> userParsed =
                      ref.read(userNotifierProvider.notifier).parseUser(_str);

                  // GET RECENT USER VALUES FROM DB
                  return userParsed.fold(
                      (failure) => _errGetUser(context, failure),
                      (user) => ref
                          .read(userNotifierProvider.notifier)
                          .onUserParsed(
                              user: user,
                              initializeDioRequest: () =>
                                  ref.read(dioRequestProvider).addAll({
                                    "username": "${user.nama}",
                                    "password": "${user.password}",
                                  }),
                              initializeAndCheckData: () async {
                                await modelFunction();
                              },
                              checkAndUpdateStatus: ref
                                  .read(authNotifierProvider.notifier)
                                  .checkAndUpdateAuthStatus,
                              sortDataFrameInSPK: ref
                                  .read(sortDataFormNotifierProvider.notifier)
                                  .sortDataFrameInSPK));
                })));

    // Sort Data
    ref.listen<Option<Either<RemoteFailure, Unit>>>(
        sortDataFormNotifierProvider.select(
          (state) => state.FOSOSPKSortData,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => VSimpleDialog(
                          label: 'Error',
                          asset: Assets.iconCrossed,
                          labelDescription: failure.maybeMap(
                            orElse: () => '',
                            parse: (value) => 'Error Parse $value',
                            server: (error) => 'Error Format Sort Data: $error',
                            storage: (_) =>
                                'mohon maaf storage anda penuh saat menyimpan frame dan spk',
                          ),
                        )),
                (_) {})));

    ref.listen<Option<Either<LocalFailure, Unit>>>(
        clearDataNotifierProvider.select(
          (state) => state.FOSOSPKClearData,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => VSimpleDialog(
                              label: 'Error',
                              labelDescription: failure.maybeMap(
                                  storage: (_) => 'storage penuh',
                                  format: (error) =>
                                      'Error Format Clear: $error',
                                  orElse: () => ''),
                              asset: Assets.iconCrossed,
                            )), (_) async {
                  _isLoading.value = true;

                  await modelFunction();

                  _isLoading.value = false;
                })));

    final isSubmitting = _isLoading.value ||
        ref.watch(
          sortDataFormNotifierProvider.select((value) => value.isGetting),
        );

    return SafeArea(
      child: UpgradeAlert(
        key: UniqueKey(),
        upgrader: Upgrader(
          showLater: false,
          showIgnore: false,
          canDismissDialog: false,
          minAppVersion: '3.0.7',
          messages: MyUpgraderMessages(),
          dialogStyle: UpgradeDialogStyle.cupertino,
        ),
        child: Stack(
          children: [
            CrannyMiddle(),
            Positioned(top: 100, child: DataUpdateLinearProgress()),
            LoadingOverlay(isLoading: isSubmitting),
          ],
        ),
      ),
    );
  }

  Future<void> _errGetUser(BuildContext context, UserFailure failure) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => VSimpleDialog(
        label: 'Error',
        asset: Assets.iconCrossed,
        labelDescription: failure.maybeMap(
          orElse: () => '',
          errorParsing: (error) => 'Error while parsing user. ${error.message}',
        ),
      ),
    );
  }
}

class MyUpgraderMessages extends UpgraderMessages {
  @override
  String get body =>
      'Mohon lakukan update dengan versi aplikasi Mobile Carrier OPR CCR terbaru.';

  @override
  String get buttonTitleIgnore => '-';

  @override
  String get buttonTitleLater => 'Nanti Saja';
}
