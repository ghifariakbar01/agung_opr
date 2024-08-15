// {
//   "id": 45,
//   "nama": "NISSAN PWK"
// },
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_mst_gate.freezed.dart';

part 'csu_mst_gate.g.dart';

List<CSUMSTGate> listCSUMSTGateFromJson(List<dynamic> jsonList) {
  return jsonList
      .map((e) => CSUMSTGate.fromJson(e as Map<String, dynamic>))
      .toList();
}

String listCSUMSTGateToJsonSavable(List<CSUMSTGate> resultList) {
  List<Map<String, dynamic>> jsonList =
      resultList.map((e) => e.toJson()).toList();
  return jsonEncode(jsonList);
}

@freezed
class CSUMSTGate with _$CSUMSTGate {
  const factory CSUMSTGate({
    required int id,
    required String? nama,
    @JsonKey(name: 'is_csu') required bool? isCsu,
  }) = _CSUMSTGate;

  factory CSUMSTGate.initial() => CSUMSTGate(
        id: 0,
        nama: '',
        isCsu: false,
      );

  factory CSUMSTGate.fromJson(Map<String, Object?> json) =>
      _$CSUMSTGateFromJson(json);
}
