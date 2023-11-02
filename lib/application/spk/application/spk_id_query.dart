import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'spk_id_query.freezed.dart';

part 'spk_id_query.g.dart';

@freezed
class SPKIdQuery with _$SPKIdQuery {
  const factory SPKIdQuery({required int idSPK, required String query}) =
      _SPKIdQuery;

  factory SPKIdQuery.fromJson(Map<String, Object?> json) =>
      _$SPKIdQueryFromJson(json);

  factory SPKIdQuery.initial() => SPKIdQuery(idSPK: 0, query: '');

  // static List<Map<String, dynamic>> listToJsonSPKIdQuery(List<CSResult> list) {
  //   return list.map((item) => item.toJson()).toList();
  // }

  static List<SPKIdQuery> listSPKIdQueryFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => SPKIdQuery.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String listSPKIdQueryToJsonSavable(List<SPKIdQuery> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
