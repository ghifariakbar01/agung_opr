import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'spk.freezed.dart';

part 'spk.g.dart';

@freezed
class SPK with _$SPK {
  const factory SPK({
    @JsonKey(name: 'id_spk') required int idSpk,
    @JsonKey(name: 'spk_no') required String spkNo,
    @JsonKey(name: 'supir1_nm') required String? supir1Nm,
    @JsonKey(name: 'supir2_nm') required String? supir2Nm,
    @JsonKey(name: 'tgl_berangkat') required String? tglBerangkat,
    required String nopol,
  }) = _SPK;

  factory SPK.initial() => SPK(
      idSpk: 0,
      spkNo: '',
      supir1Nm: '',
      supir2Nm: '',
      nopol: '',
      tglBerangkat: '');

  factory SPK.fromJson(Map<String, Object?> json) => _$SPKFromJson(json);

  static List<SPK> SPKListFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => SPK.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String SPKListToJson(List<SPK> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
