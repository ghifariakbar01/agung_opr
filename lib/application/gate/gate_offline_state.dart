import 'package:freezed_annotation/freezed_annotation.dart';

part 'gate_offline_state.freezed.dart';

@freezed
class GateOfflineState with _$GateOfflineState {
  const factory GateOfflineState.initial() = _Initial;
  const factory GateOfflineState.hasOfflineStorage() = _Storage;
  const factory GateOfflineState.empty() = _Empty;
}
