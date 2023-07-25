import 'dart:developer';

import 'package:agung_opr/application/auto_data/shared/auto_data_providers.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/auth_failure.dart';
import '../../../shared/providers.dart';
import '../../widgets/alert_helper.dart';
import '../../widgets/loading_overlay.dart';

import '../../widgets/v_button.dart';
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

    return Stack(
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
                      signIn: () => ref
                          .read(signInFormNotifierProvider.notifier)
                          .signInWithUserIdEmailAndPassword(),
                      remember: () => ref
                          .read(signInFormNotifierProvider.notifier)
                          .rememberInfo(),
                      clear: () => ref
                          .read(signInFormNotifierProvider.notifier)
                          .clearInfo(),
                    );
              },
              label: 'LOGIN',
            )),
        LoadingOverlay(isLoading: isSubmitting),
      ],
    );
  }
}
