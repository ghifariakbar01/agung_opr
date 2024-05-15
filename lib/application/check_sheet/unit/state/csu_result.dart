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

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'csu_result.freezed.dart';

part 'csu_result.g.dart';

@freezed
class CSUResult with _$CSUResult {
  const factory CSUResult({
    required bool? inout,
    @JsonKey(name: 'id_cs') required int id,
    @JsonKey(name: 'id_gate') required int idGate,
    required int? defectAmount,
    @JsonKey(name: 'no_defect') required int? isDefect,
    required String? gate,
    required String? frame,
    required String? supir1,
    required String? supir2,
    required String? posisi,
    @JsonKey(name: 'supir_sdr') required String? supirSDR,
    @JsonKey(name: 'tgl_kirim_unit') required String? tglKirim,
    @JsonKey(name: 'tgl_terima_unit') required String? tglTerima,
    @JsonKey(name: 'ket') required String? keterangan,
    @JsonKey(name: 'u_date') required String? updatedAt,
    @JsonKey(name: 'u_user') required String? updatedBy,
  }) = _CSUResult;

  factory CSUResult.initial() => CSUResult(
        defectAmount: 0,
        frame: '',
        gate: '',
        id: 0,
        idGate: 0,
        inout: null,
        isDefect: null,
        posisi: '',
        supir1: '',
        supir2: '',
        supirSDR: '',
        tglKirim: '',
        tglTerima: '',
        keterangan: '',
        updatedAt: '',
        updatedBy: '',
      );

  factory CSUResult.fromJson(Map<String, Object?> json) =>
      _$CSUResultFromJson(json);
}
