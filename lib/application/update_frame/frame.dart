// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'frame.freezed.dart';

part 'frame.g.dart';

@freezed
class Frame with _$Frame {
  const factory Frame({
    @JsonKey(name: 'id_unit') required int idUnit,
    required String? frame,
    required String? engine,
    required String? warna,
    required String? custnm,
    @JsonKey(name: 'no_invoice') required String? sppdc,
    @JsonKey(name: 'last_spk') required String? lastSpk,
    @JsonKey(name: 'c_date') required String? tglDibuat,
    @JsonKey(name: 'u_date') required String? uDate,
    @JsonKey(name: 'u_user') required String? uUser,
    @JsonKey(name: 'id_kend_type') required int? idKendType,
  }) = _Frame;

  factory Frame.initial() => Frame(
        idUnit: 0,
        frame: '',
        warna: '',
        sppdc: '',
        engine: '',
        uDate: '',
        uUser: '',
        custnm: '',
        lastSpk: '',
        tglDibuat: '',
        idKendType: 0,
      );

  factory Frame.fromJson(Map<String, Object?> json) => _$FrameFromJson(json);
}
