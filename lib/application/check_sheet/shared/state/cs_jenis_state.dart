import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cs_jenis_state.freezed.dart';

part 'cs_jenis_state.g.dart';

@freezed
class CSJenisState with _$CSJenisState {
  const factory CSJenisState({required int id, required String nama}) =
      _CSJenisState;

  factory CSJenisState.initial() => CSJenisState(id: 0, nama: '');

  factory CSJenisState.fromJson(Map<String, Object?> json) =>
      _$CSJenisStateFromJson(json);

  static List<CSJenisState> CSJenisListFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => CSJenisState.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String CSJenisListToJson(List<CSJenisState> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
