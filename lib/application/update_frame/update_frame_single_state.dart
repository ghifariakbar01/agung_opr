import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_frame_single_state.freezed.dart';

@freezed
class UpdateFrameStateSingle with _$UpdateFrameStateSingle {
  const factory UpdateFrameStateSingle({
    required IDUnit idUnit,
    required FrameUnit frame,
    required WarnaUnit warna,
    required bool isShowError,
    required EngineUnit engine,
    required IDKendType idKendType,
  }) = _UpdateFrameStateSingle;

  factory UpdateFrameStateSingle.initial() => UpdateFrameStateSingle(
        isShowError: false,
        idUnit: IDUnit(''),
        frame: FrameUnit(''),
        warna: WarnaUnit(''),
        engine: EngineUnit(''),
        idKendType: IDKendType(''),
      );
}
