import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'supir.freezed.dart';

part 'supir.g.dart';

@freezed
class Supir with _$Supir {
  const factory Supir(
      {required int id,
      required String? nama,
      required String? phone,
      required String? alamat,
      required String? kategori}) = _Supir;

  factory Supir.fromJson(Map<String, Object?> json) => _$SupirFromJson(json);

  static List<Supir> SupirListFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => Supir.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String SupirListToJson(List<Supir> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
