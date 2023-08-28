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
    required String nopol,
  }) = _SPK;

  factory SPK.initial() =>
      SPK(idSpk: 0, spkNo: '', supir1Nm: '', supir2Nm: '', nopol: '');

  factory SPK.fromJson(Map<String, Object?> json) => _$SPKFromJson(json);
}
