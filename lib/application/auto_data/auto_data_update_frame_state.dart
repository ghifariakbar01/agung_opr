import 'package:agung_opr/application/check_sheet/shared/state/cs_id_query.dart';
import 'package:agung_opr/application/check_sheet/unit/state/csu_id_query.dart';
import 'package:agung_opr/application/spk/application/spk_id_query.dart';
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
    required List<SPKIdQuery> spkIdQueries,
    required List<CSUIDQuery> csuIdQueries,
    required List<CSIDQuery> csIdQueries,
    required Option<Either<RemoteFailure, Unit>> FOSOAutoDataRemote,
    required Option<Either<LocalFailure, Map<String, Map<String, String>>>>
        FOSOSPKAutoDataLocalUpdateFrame,
    required Option<Either<LocalFailure, List<CSUIDQuery>>>
        FOSOAutoDataLocalUpdateFrameCSU,
    required Option<Either<LocalFailure, List<CSIDQuery>>>
        FOSOAutoDataLocalUpdateFrameCS,
    required Option<Either<LocalFailure, List<SPKIdQuery>>>
        FOSOAutoDataLocalUpdateFrameSPK,
  }) = _AutoDataUpdateFrameState;

  factory AutoDataUpdateFrameState.initial() => AutoDataUpdateFrameState(
        isGetting: false,
        idSPKMapidTIUnitMapQuery: {},
        csuIdQueries: [],
        csIdQueries: [],
        spkIdQueries: [],
        FOSOAutoDataRemote: none(),
        FOSOSPKAutoDataLocalUpdateFrame: none(),
        FOSOAutoDataLocalUpdateFrameCSU: none(),
        FOSOAutoDataLocalUpdateFrameCS: none(),
        FOSOAutoDataLocalUpdateFrameSPK: none(),
      );
}
