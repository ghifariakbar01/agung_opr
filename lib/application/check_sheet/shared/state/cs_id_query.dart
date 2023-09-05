//  "id": 119886,
//  "frame": "DUMMY 324",
//  "gate": "TAM CCY CIBITUNG",
//  "inOut": false,
//  "isDefect": 0,
//  "updatedAt": "2019-10-09 09:39:34"

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';


part 'cs_id_query.freezed.dart';

part 'cs_id_query.g.dart';

@freezed
class CSIDQuery with _$CSIDQuery {
  const factory CSIDQuery({required int idSPK, required String query}) =
      _CSIDQuery;

  factory CSIDQuery.fromJson(Map<String, Object?> json) =>
      _$CSIDQueryFromJson(json);

  factory CSIDQuery.initial() => CSIDQuery(idSPK: 0, query: '');

  // static List<Map<String, dynamic>> listToJsonCSIDQuery(List<CSResult> list) {
  //   return list.map((item) => item.toJson()).toList();
  // }

  static List<CSIDQuery> listCSIDQueryFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => CSIDQuery.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String listCSIDQueryToJsonSavable(List<CSIDQuery> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
