import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_frame_single_state.freezed.dart';

@freezed
class UpdateFrameStateSingle with _$UpdateFrameStateSingle {
  const factory UpdateFrameStateSingle({
    required IDUnit idUnit,
    required FrameUnit frame,
    required EngineUnit engine,
    required WarnaUnit warna,
    required CustomerId customerId,
    required SPPDC sppdc,
    required IDKendType idKendType,
    required bool isShowError,
  }) = _UpdateFrameStateSingle;

  factory UpdateFrameStateSingle.initial() => UpdateFrameStateSingle(
      idUnit: IDUnit(''),
      frame: FrameUnit(''),
      engine: EngineUnit(''),
      warna: WarnaUnit(''),
      customerId: CustomerId(''),
      sppdc: SPPDC(''),
      idKendType: IDKendType(''),
      isShowError: false);
}
