import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_frame_offline_state.freezed.dart';

@freezed
class UpdateFrameOfflineState with _$UpdateFrameOfflineState {
  const factory UpdateFrameOfflineState.initial() = _Initial;
  const factory UpdateFrameOfflineState.hasOfflineStorage() = _Storage;
  const factory UpdateFrameOfflineState.empty() = _Empty;
}
