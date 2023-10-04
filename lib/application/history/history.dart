import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'history.freezed.dart';

part 'history.g.dart';

@freezed
class History with _$History {
  const factory History({
    @JsonKey(name: 'id_user') required int idUser,
    required String query,
    required String content,
    @JsonKey(name: 'c_user') required String? cUser,
    @JsonKey(name: 'c_date') required String? cDate,
    @JsonKey(name: 's_date') required String? sDate,
  }) = _History;

  factory History.initial() => History(
        idUser: 0,
        query: '',
        cUser: '',
        cDate: '',
        sDate: '',
        content: '',
      );

  factory History.fromJson(Map<String, Object?> json) =>
      _$HistoryFromJson(json);

  static List<History> HistoryListFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => History.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String HistoryListToJson(List<History> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
