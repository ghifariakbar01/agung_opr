//  "id": 119886,
//  "frame": "DUMMY 324",
//  "gate": "TAM CCY CIBITUNG",
//  "inOut": false,
//  "isDefect": 0,
//  "updatedAt": "2019-10-09 09:39:34"

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'csu_result.dart';

part 'csu_id_query.freezed.dart';

part 'csu_id_query.g.dart';

@freezed
class CSUIDQuery with _$CSUIDQuery {
  const factory CSUIDQuery({required int idUnit, required String query}) =
      _CSUIDQuery;

  factory CSUIDQuery.fromJson(Map<String, Object?> json) =>
      _$CSUIDQueryFromJson(json);

  static List<Map<String, dynamic>> listToJsonCSUIDQuery(List<CSUResult> list) {
    return list.map((item) => item.toJson()).toList();
  }

  static List<CSUIDQuery> listCSUIDQueryFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => CSUIDQuery.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String listCSUIDQueryToJsonSavable(List<CSUIDQuery> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
