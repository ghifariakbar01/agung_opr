import 'package:agung_opr/application/check_sheet/unit/state/csu_id_query.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/remote_failure.dart';

part 'auto_data_update_frame_state.freezed.dart';

@freezed
class AutoDataUpdateFrameState with _$AutoDataUpdateFrameState {
  const factory AutoDataUpdateFrameState({
    required bool isGetting,
    //
    required Map<String, Map<String, String>> idSPKMapidTIUnitMapQuery,
    required List<CSUIDQuery> csuIdQueries,
    //
    required Option<Either<RemoteFailure, Unit>> FOSOAutoDataRemote,
    //
    required Option<Either<LocalFailure, Map<String, Map<String, String>>>>
        FOSOSPKAutoDataLocalUpdateFrame,
    required Option<Either<LocalFailure, List<CSUIDQuery>>>
        FOSOAutoDataLocalUpdateFrameCSU,
  }) = _AutoDataUpdateFrameState;

  factory AutoDataUpdateFrameState.initial() => AutoDataUpdateFrameState(
      isGetting: false,
      idSPKMapidTIUnitMapQuery: {},
      csuIdQueries: [],
      FOSOAutoDataRemote: none(),
      FOSOSPKAutoDataLocalUpdateFrame: none(),
      FOSOAutoDataLocalUpdateFrameCSU: none());
}
