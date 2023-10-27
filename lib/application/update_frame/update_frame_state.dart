import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/value_objects_copy.dart';
import 'update_frame_single_state.dart';

part 'update_frame_state.freezed.dart';

@freezed
class UpdateFrameState with _$UpdateFrameState {
  const factory UpdateFrameState({
    required int idSPK,
    required int index,
    required SPPDC sppdc,
    required bool isValid,
    required bool isProcessing,
    required Map<String, dynamic> basicColors,

    /// Hack for model value to change after tapping model
    required TextEditingController sjkbTextController,
    required List<UpdateFrameStateSingle> updateFrameList,
    required List<TextEditingController> warnaTextController,
    required List<TextEditingController> modelTextController,
    required List<TextEditingController> frameTextController,
    required List<TextEditingController> customerTextController,
    required Option<Either<LocalFailure, Unit>> FOSOUpdateFrame,
  }) = _UpdateFrameState;

  factory UpdateFrameState.initial() => UpdateFrameState(
        idSPK: 0,
        index: 0,
        isValid: false,
        sppdc: SPPDC(''),
        isProcessing: false,
        updateFrameList: [],
        FOSOUpdateFrame: none(),
        modelTextController: [],
        frameTextController: [],
        warnaTextController: [],
        customerTextController: [],
        sjkbTextController: TextEditingController(),
        basicColors: {
          '': Colors.transparent,
          'Merah': Colors.red,
          'Hijau': Colors.green,
          'Biru': Colors.blue,
          'Kuning': Colors.yellow,
          'Oranye': Colors.orange,
          'Ungu': Colors.purple,
          'Coklat': Colors.brown,
          'Silver': Colors.grey,
          'Abu-abu': Colors.grey.shade600,
          'Hitam': Colors.black,
          'Putih': Colors.white,
        },
      );
}
