//  {
//    "id_kr_chk": 1,
//    "id_spk": 133889,
//    "nopol": "B9558PEI",
//    "driver1": "WAGINO",
//    "driver2": "TONI",
//    "jamload": "21:12:01",
//    "gate": "NVDC KARAWANG",
//    "status": "OK",
//    "u_date": "2022-11-15 09:23:06",
//    "u_user": "BACHTIAR",
//    "tipe": "loading",
//    "ket": null
//  }

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cs_result.freezed.dart';

part 'cs_result.g.dart';

@freezed
class CSResult with _$CSResult {
  const factory CSResult({
    @JsonKey(name: 'id_kr_chk') required int idKrChk,
    @JsonKey(name: 'id_spk') required int idSPK,
    required String? nopol,
    required String? gate,
    required String? driver1,
    required String? driver2,
    required String? jamload,
    required String? status,
    required String? tipe,
    required String? ket,
    @JsonKey(name: 'u_date') required String? updatedAt,
    @JsonKey(name: 'u_user') required String? updatedBy,
  }) = _CSResult;

  factory CSResult.initial() => CSResult(
        idKrChk: 0,
        idSPK: 0,
        ket: '',
        gate: '',
        tipe: '',
        nopol: '',
        status: '',
        driver1: '',
        driver2: '',
        jamload: '',
        updatedAt: '',
        updatedBy: '',
      );

  factory CSResult.fromJson(Map<String, Object?> json) =>
      _$CSResultFromJson(json);
}
