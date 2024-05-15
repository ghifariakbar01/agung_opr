// ignore_for_file: invalid_annotation_target

//  "id": 119886,
//  "frame": "DUMMY 324",
//  "gate": "TAM CCY CIBITUNG",
//  "inOut": false,
//  "isDefect": 0,
//  "updatedAt": "2019-10-09 09:39:34"

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import 'csu_trips/csu_trips.dart';

part 'unit_csu_trips.freezed.dart';
part 'unit_csu_trips.g.dart';

@freezed
class UnitCSUTrips with _$UnitCSUTrips {
  const factory UnitCSUTrips(
      {required int idUnit,
      @JsonKey(toJson: UnitCSUTrips.listToJson)
      required List<CSUTrips> csuResult}) = _UnitCSUTrips;

  factory UnitCSUTrips.fromJson(Map<String, Object?> json) =>
      _$UnitCSUTripsFromJson(json);

  static List<Map<String, dynamic>> listToJson(List<CSUTrips> list) {
    return list.map((item) => item.toJson()).toList();
  }

  static List<UnitCSUTrips> listCSUResultTripsFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => UnitCSUTrips.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String listCSUResultTripsToJson(List<UnitCSUTrips> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
