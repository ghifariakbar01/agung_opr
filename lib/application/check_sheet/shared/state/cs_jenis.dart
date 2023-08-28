import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cs_jenis.freezed.dart';

part 'cs_jenis.g.dart';

@freezed
class CSJenis with _$CSJenis {
  const factory CSJenis({required int id, required String nama}) = _CSJenis;

  factory CSJenis.initial() => CSJenis(id: 0, nama: '');

  factory CSJenis.fromJson(Map<String, Object?> json) =>
      _$CSJenisFromJson(json);

  static List<CSJenis> CSJenisListFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => CSJenis.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String CSJenisListToJson(List<CSJenis> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
