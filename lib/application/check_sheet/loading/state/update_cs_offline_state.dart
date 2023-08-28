import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_cs_offline_state.freezed.dart';

@freezed
class UpdateCSOfflineState with _$UpdateCSOfflineState {
  const factory UpdateCSOfflineState.initial() = _Initial;
  const factory UpdateCSOfflineState.hasOfflineStorage() = _Storage;
  const factory UpdateCSOfflineState.empty() = _Empty;
}
