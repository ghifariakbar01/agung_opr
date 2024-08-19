import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_frame_single_state.freezed.dart';

@freezed
class UpdateFrameStateSingle with _$UpdateFrameStateSingle {
  const factory UpdateFrameStateSingle({
    required IDUnit idUnit,
    required String uDate,
    required String uUser,
    required FrameUnit frame,
    required WarnaUnit warna,
    required bool isShowError,
    required IDKendType idKendType,
  }) = _UpdateFrameStateSingle;

  factory UpdateFrameStateSingle.initial() => UpdateFrameStateSingle(
        idUnit: IDUnit(''),
        uDate: '',
        uUser: '',
        isShowError: false,
        frame: FrameUnit(''),
        warna: WarnaUnit('Hijau'),
        idKendType: IDKendType(''),
      );
}
