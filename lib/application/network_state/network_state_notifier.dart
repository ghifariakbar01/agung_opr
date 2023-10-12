import 'dart:async';

import 'package:agung_opr/shared/providers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'network_state.dart';

final networkStateNotifierProvider =
    StateNotifierProvider<NetworkStateNotifier, NetworkState>(
        (ref) => NetworkStateNotifier(ref));

class NetworkStateNotifier extends StateNotifier<NetworkState> {
  final Ref ref;

  get controller => StreamController<ConnectivityResult>();

  NetworkStateNotifier(this.ref) : super(NetworkState.offline()) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        if (state != NetworkState.offline()) {
          state = NetworkState.offline();
          ref.read(isOfflineStateProvider.notifier).state = true;
        }
      } else {
        if (state != NetworkState.online()) {
          state = NetworkState.online();
          ref.read(isOfflineStateProvider.notifier).state = false;
        }
      }
    });
  }
}
