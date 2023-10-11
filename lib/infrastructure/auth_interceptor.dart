import 'package:agung_opr/infrastructure/dio_extensions.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._ref);

  final Ref _ref;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);

    final items = response.data?[0];

    final errorNum = items['errornum'] as int?;

    if (errorNum == 3) {
      _ref.read(userNotifierProvider.notifier).logout();
    }

    if (items != null) {
      _ref.read(isOfflineStateProvider.notifier).state = false;
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    if (err.isNoConnectionError || err.isConnectionTimeout) {
      _ref.read(isOfflineStateProvider.notifier).state = true;
    }
  }
}
