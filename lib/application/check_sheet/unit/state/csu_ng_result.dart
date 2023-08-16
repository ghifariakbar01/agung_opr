// {
//   "id_cs": 206514,
//   "id_item": 1,
//   "id_jns_defect": 9,
//   "id_p_defect": 3
// },

import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_ng_result.freezed.dart';

part 'csu_ng_result.g.dart';

@freezed
class CSUNGResult with _$CSUNGResult {
  const factory CSUNGResult(
      {required int idItem,
      required int idJenis,
      required int idPenyebab}) = _CSUNGResult;

  factory CSUNGResult.fromJson(Map<String, Object?> json) =>
      _$CSUNGResultFromJson(json);
}
