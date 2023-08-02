import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/remote_failure.dart';

part 'auto_data_update_frame_state.freezed.dart';

@freezed
class AutoDataUpdateFrameState with _$AutoDataUpdateFrameState {
  const factory AutoDataUpdateFrameState({
    required bool isGetting,
    required Map<String, Map<String, String>> idSPKMapidTIUnitMapQuery,
    required Option<Either<RemoteFailure, Unit>> FOSOSPKAutoDataUpdateFrame,
    required Option<Either<LocalFailure, Map<String, Map<String, String>>>>
        FOSOSPKAutoDataGetSavedUpdateFrame,
  }) = _AutoDataUpdateFrameState;

  factory AutoDataUpdateFrameState.initial() => AutoDataUpdateFrameState(
      isGetting: false,
      idSPKMapidTIUnitMapQuery: {},
      FOSOSPKAutoDataUpdateFrame: none(),
      FOSOSPKAutoDataGetSavedUpdateFrame: none());
}
