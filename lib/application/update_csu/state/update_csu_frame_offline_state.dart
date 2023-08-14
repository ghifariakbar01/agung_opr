import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_csu_frame_offline_state.freezed.dart';

@freezed
class UpdateCSUFrameOfflineState with _$UpdateCSUFrameOfflineState {
  const factory UpdateCSUFrameOfflineState.initial() = _Initial;
  const factory UpdateCSUFrameOfflineState.hasOfflineStorage() = _Storage;
  const factory UpdateCSUFrameOfflineState.empty() = _Empty;
}
