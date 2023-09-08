import 'package:agung_opr/shared/providers.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../application/password_expired/password_expired_notifier.dart';
import '../application/password_expired/password_expired_state.dart';
import '../constants/constants.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._ref);

  final Ref _ref;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);

    final items = response.data?[0];

    // final message = items['error'] as String?;
    final errorNum = items['errornum'] as int?;

    PasswordExpiredState passwordExpired =
        _ref.watch(passwordExpiredNotifierStatusProvider);
    PasswordExpiredNotifier passwordExpiredNotifier =
        _ref.watch(passwordExpiredNotifierProvider.notifier);

    //

    if (errorNum == null) {
      //

      await passwordExpired.maybeWhen(
          expired: () => passwordExpiredNotifier.clearPasswordExpired(),
          orElse: () {});
    }

    if (errorNum == Constants.passWrongCode ||
        errorNum == Constants.passExpCode) {
      //

      await passwordExpiredNotifier.savePasswordExpired();
    }
  }
}
