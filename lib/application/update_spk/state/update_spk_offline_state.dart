import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_spk_offline_state.freezed.dart';

@freezed
class UpdateSPKOfflineState with _$UpdateSPKOfflineState {
  const factory UpdateSPKOfflineState.initial() = _Initial;
  const factory UpdateSPKOfflineState.hasOfflineStorage() = _Storage;
  const factory UpdateSPKOfflineState.empty() = _Empty;
}
