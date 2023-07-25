import 'package:freezed_annotation/freezed_annotation.dart';

part 'frame_offline_state.freezed.dart';

@freezed
class FrameOfflineState with _$FrameOfflineState {
  const factory FrameOfflineState.initial() = _Initial;
  const factory FrameOfflineState.hasOfflineStorage() = _Storage;
  const factory FrameOfflineState.empty() = _Empty;
}
