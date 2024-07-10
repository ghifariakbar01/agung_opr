import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_ng_result.freezed.dart';

part 'csu_ng_result.g.dart';

@freezed
class CSUNGResult with _$CSUNGResult {
  const factory CSUNGResult({
    required String ket,
    required int idItem,
    required int idJenis,
    required int idPosisi,
  }) = _CSUNGResult;

  factory CSUNGResult.fromJson(Map<String, Object?> json) =>
      _$CSUNGResultFromJson(json);
}
