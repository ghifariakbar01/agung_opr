import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/remote_failure.dart';
import '../../../update_frame/frame.dart';
import 'csu_ng/csu_ng_result.dart';
import 'csu_result.dart';
import 'csu_trips/csu_trips.dart';

part 'csu_result_state.freezed.dart';

@freezed
class CSUResultState with _$CSUResultState {
  const factory CSUResultState({
    required bool isProcessing,
    required Frame frame,
    //
    required List<CSUResult> csuResultList,
    required List<CSUNGResult> csuNGResultList,
    required List<CSUTrips> csuTripsResultList,
    //
    required Option<Either<RemoteFailure, List<CSUResult>>> FOSOCSUResult,
    required Option<Either<RemoteFailure, List<CSUNGResult>>> FOSOCSUNGResult,
    required Option<Either<RemoteFailure, List<CSUTrips>>> FOSOCSUTripsResult,
  }) = _CSUResultState;

  factory CSUResultState.initial() => CSUResultState(
      isProcessing: false,
      frame: Frame.initial(),
      csuResultList: [],
      csuNGResultList: [],
      csuTripsResultList: [],
      FOSOCSUResult: none(),
      FOSOCSUNGResult: none(),
      FOSOCSUTripsResult: none());
}
