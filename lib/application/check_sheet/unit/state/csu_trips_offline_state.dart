import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_trips_offline_state.freezed.dart';

@freezed
class CSUTripsOfflineState with _$CSUTripsOfflineState {
  const factory CSUTripsOfflineState.initial() = _Initial;
  const factory CSUTripsOfflineState.hasOfflineStorage() = _Storage;
  const factory CSUTripsOfflineState.empty() = _Empty;
}
