//  {
//      "costanalis": "AGUNG RAYA CCR KARAWANG - PATIMBAN ",
//      "custnm": "AGUNG RAYA"
//  },
//  {
//      "costanalis": "AGUNG RAYA CCR KARAWANG - PATIMBAN ",
//      "custnm": "AGUNG RAYA"
//  },
//  {
//      "costanalis": "AGUNG RAYA CCR KARAWANG - PATIMBAN ",
//      "custnm": "AGUNG RAYA"
//  },

import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_trips.freezed.dart';

part 'csu_trips.g.dart';

@freezed
class CSUTrips with _$CSUTrips {
  const factory CSUTrips({
    required String? costanalis,
    required String? custnm,
  }) = _CSUTrips;

  factory CSUTrips.fromJson(Map<String, Object?> json) =>
      _$CSUTripsFromJson(json);
}
