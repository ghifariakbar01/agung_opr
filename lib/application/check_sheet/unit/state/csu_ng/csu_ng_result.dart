// {
//   "id_cs": 206514,
//   "id_item": 1,
//   "id_jns_defect": 9,
//   "id_p_defect": 3
// },

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_ng_result.freezed.dart';

part 'csu_ng_result.g.dart';

@freezed
class CSUNGResult with _$CSUNGResult {
  const factory CSUNGResult(
      {required int idItem,
      required int idJenis,
      required int idPenyebab}) = _CSUNGResult;

  factory CSUNGResult.fromJson(Map<String, Object?> json) =>
      _$CSUNGResultFromJson(json);

  static List<CSUNGResult> CSUNGResultListFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => CSUNGResult.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String CSUNGResultListToJson(List<CSUNGResult> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
