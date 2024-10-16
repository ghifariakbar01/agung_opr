import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/remote_failure.dart';
import 'csu_trips.dart';

part 'csu_trips_state.freezed.dart';

@freezed
class CSUTripsState with _$CSUTripsState {
  const factory CSUTripsState({
    required bool isProcessing,
    required List<CSUTrips> csuTripsList,
    required Option<Either<RemoteFailure, List<CSUTrips>>> FOSOCSUTrips,
  }) = _CSUTripsState;

  factory CSUTripsState.initial() => CSUTripsState(
        isProcessing: false,
        csuTripsList: [],
        FOSOCSUTrips: none(),
      );
}
