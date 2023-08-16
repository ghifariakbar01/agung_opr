// {
//    "id": 206514,
//    "defectAmount": 2,
//    "gate": "ACT MERAK",
//    "frame": "MHKAB1BC7PJ010871",
//    "inOut": false,
//    "isDefect": 0,
//    "updatedAt": "2023-08-16 11:04:43",
//    "updatedBy": "Ghifar"
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_result.freezed.dart';

part 'csu_result.g.dart';

@freezed
class CSUResult with _$CSUResult {
  const factory CSUResult({
    required int id,
    required int? defectAmount,
    required String? gate,
    required String? frame,
    required bool? inOut,
    required int? isDefect,
    required String? updatedAt,
    required String? updatedBy,
  }) = _CSUResult;

  factory CSUResult.fromJson(Map<String, Object?> json) =>
      _$CSUResultFromJson(json);
}
