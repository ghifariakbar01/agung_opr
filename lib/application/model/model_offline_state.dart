import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_offline_state.freezed.dart';

@freezed
class ModelOfflineState with _$ModelOfflineState {
  const factory ModelOfflineState.initial() = _Initial;
  const factory ModelOfflineState.hasOfflineStorage() = _Storage;
  const factory ModelOfflineState.empty() = _Empty;
}
