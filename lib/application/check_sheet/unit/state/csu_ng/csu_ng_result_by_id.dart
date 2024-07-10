import 'dart:convert';
import 'dart:developer';

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
    List<CSUNGResultByID> list = [];

    try {
      list = jsonList
          .map((e) => CSUNGResultByID.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('error $e');
    }

    return list;
  }

  static String CSUNGResultListToJson(List<CSUNGResultByID> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();

    return jsonEncode(jsonList);
  }
}
