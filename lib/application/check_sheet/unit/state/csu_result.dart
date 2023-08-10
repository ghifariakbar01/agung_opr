//  "id": 119886,
//  "frame": "DUMMY 324",
//  "gate": "TAM CCY CIBITUNG",
//  "inOut": false,
//  "isDefect": 0,
//  "updatedAt": "2019-10-09 09:39:34"

import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_result.freezed.dart';

part 'csu_result.g.dart';

@freezed
class CSUResult with _$CSUResult {
  const factory CSUResult(
      {required int id,
      required String? frame,
      required String? gate,
      required bool? inOut,
      required int? isDefect,
      required String? updatedAt}) = _CSUResult;

  factory CSUResult.fromJson(Map<String, Object?> json) =>
      _$CSUResultFromJson(json);
}
