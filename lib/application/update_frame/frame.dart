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
    @JsonKey(name: 'no_reff_expor') required String? noReffExp,
    @JsonKey(name: 'id_kend_type') required int? idKendType,
    required String? custnm,
  }) = _Frame;

  factory Frame.initial() => Frame(
      idUnit: 0,
      frame: '',
      engine: '',
      warna: '',
      noReffExp: '',
      idKendType: 0,
      custnm: '');

  factory Frame.fromJson(Map<String, Object?> json) => _$FrameFromJson(json);
}
