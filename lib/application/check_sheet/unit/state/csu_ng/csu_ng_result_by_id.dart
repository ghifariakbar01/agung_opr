// {
//   "id_cs": 206514,
//   "id_item": 1,
//   "id_jns_defect": 9,
//   "id_p_defect": 3
// },

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'csu_ng_result.dart';

part 'csu_ng_result_by_id.freezed.dart';

part 'csu_ng_result_by_id.g.dart';

@freezed
class CSUNGResultByID with _$CSUNGResultByID {
  const factory CSUNGResultByID({
    required int idCS,
    required List<CSUNGResult> csuNGResult,
  }) = _CSUNGResult;

  factory CSUNGResultByID.fromJson(Map<String, Object?> json) =>
      _$CSUNGResultByIDFromJson(json);

  static List<CSUNGResultByID> CSUNGResultListFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => CSUNGResultByID.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String CSUNGResultListToJson(List<CSUNGResultByID> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
