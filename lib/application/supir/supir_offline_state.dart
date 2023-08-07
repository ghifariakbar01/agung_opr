import 'package:freezed_annotation/freezed_annotation.dart';

part 'supir_offline_state.freezed.dart';

@freezed
class SupirOfflineState with _$SupirOfflineState {
  const factory SupirOfflineState.initial() = _Initial;
  const factory SupirOfflineState.hasOfflineStorage() = _Storage;
  const factory SupirOfflineState.empty() = _Empty;
}
