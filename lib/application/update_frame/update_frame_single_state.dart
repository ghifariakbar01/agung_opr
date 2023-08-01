import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_frame_single_state.freezed.dart';

@freezed
class UpdateFrameStateSingle with _$UpdateFrameStateSingle {
  const factory UpdateFrameStateSingle(
      {required IDUnit idUnit,
      required FrameUnit frame,
      required EngineUnit engine,
      required WarnaUnit warna,
      required NoReffEXP noReff,
      required SPPDC sppdc,
      required IDKendType idKendType}) = _UpdateFrameStateSingle;

  factory UpdateFrameStateSingle.initial() => UpdateFrameStateSingle(
      idUnit: IDUnit(''),
      frame: FrameUnit(''),
      engine: EngineUnit(''),
      warna: WarnaUnit(''),
      noReff: NoReffEXP(''),
      sppdc: SPPDC(''),
      idKendType: IDKendType(''));
}
