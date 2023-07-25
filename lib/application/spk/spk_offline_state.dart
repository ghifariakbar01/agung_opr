import 'package:freezed_annotation/freezed_annotation.dart';

part 'spk_offline_state.freezed.dart';

@freezed
class SPKOfflineState with _$SPKOfflineState {
  const factory SPKOfflineState.initial() = _Initial;
  const factory SPKOfflineState.hasOfflineStorage() = _Storage;
  const factory SPKOfflineState.empty() = _Empty;
}
