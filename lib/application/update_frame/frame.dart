import 'package:freezed_annotation/freezed_annotation.dart';

part 'frame.freezed.dart';

part 'frame.g.dart';

@freezed
class Frame with _$Frame {
  const factory Frame(
      {@JsonKey(name: 'id_unit') required int idUnit,
      required String? frame,
      required String? engine,
      required String? warna,
      @JsonKey(name: 'id_kend_type') required int? idKendType}) = _Frame;

  factory Frame.fromJson(Map<String, Object?> json) => _$FrameFromJson(json);
}
