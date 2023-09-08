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
    @JsonKey(name: 'id_kend_type') required int? idKendType,
    @JsonKey(name: 'no_invoice') required String? sppdc,
    required String? custnm,
    @JsonKey(name: 'c_date') required String? tglDibuat,
  }) = _Frame;

  factory Frame.initial() => Frame(
      idUnit: 0,
      frame: '',
      engine: '',
      warna: '',
      idKendType: 0,
      sppdc: '',
      custnm: '',
      tglDibuat: '');

  factory Frame.fromJson(Map<String, Object?> json) => _$FrameFromJson(json);
}
