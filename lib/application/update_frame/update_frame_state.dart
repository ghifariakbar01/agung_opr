import 'package:freezed_annotation/freezed_annotation.dart';

import 'update_frame_single_state.dart';

part 'update_frame_state.freezed.dart';

@freezed
class UpdateFrameState with _$UpdateFrameState {
  const factory UpdateFrameState(
          {required List<UpdateFrameStateSingle> updateFrameList}) =
      _UpdateFrameState;

  factory UpdateFrameState.initial() => UpdateFrameState(updateFrameList: []);
}
