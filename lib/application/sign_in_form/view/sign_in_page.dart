import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/auth_failure.dart';
import '../../../shared/providers.dart';
import '../../../common/widgets/alert_helper.dart';
import '../../../common/widgets/loading_overlay.dart';

import '../../../common/widgets/v_button.dart';
import 'sign_in_scaffold.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<Option<Either<AuthFailure, Unit>>>(
        signInFormNotifierProvider.select(
          (state) => state.failureOrSuccessOption,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => AlertHelper.showSnackBar(
                      context,
                      message: failure.map(
                        storage: (_) => 'storage penuh',
                        server: (value) => value.message ?? 'server error',
                        noConnection: (_) => 'tidak ada koneksi',
                      ),
                    ),
                (_) => ref
                    .read(authNotifierProvider.notifier)
                    .checkAndUpdateAuthStatus())));

    final isSubmitting = ref.watch(
      signInFormNotifierProvider.select((state) => state.isSubmitting),
    );

    final jobDesk = ref
        .watch(signInFormNotifierProvider.select((value) => value.jobdesk))
        .getOrLeave('');

    return SafeArea(
      child: Stack(
        children: [
          const SignInScaffold(),
          Align(
              alignment: Alignment.bottomCenter,
              child: VButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  await ref
                      .read(signInFormNotifierProvider.notifier)
                      .signInAndRemember(
                        signIn: jobDesk == 'Cranny'
                            ? () => ref
                                .read(signInFormNotifierProvider.notifier)
                                .signInWithUserIdEmailAndPassword()
                            : () => ref
                                .read(signInFormNotifierProvider.notifier)
                                .signInWithUsernameAndNoKtp(),
                        remember: () => ref
                            .read(signInFormNotifierProvider.notifier)
                            .rememberInfo(),
                      );
                },
                label: 'LOGIN',
              )),
          LoadingOverlay(isLoading: isSubmitting),
        ],
      ),
    );
  }
}
