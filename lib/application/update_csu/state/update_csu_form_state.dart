import 'package:agung_opr/application/update_csu/state/update_csu_ng_state.dart';
import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_csu_form_state.freezed.dart';

@freezed
class UpdateCSUFrameStateSingle with _$UpdateCSUFrameStateSingle {
  const factory UpdateCSUFrameStateSingle({
    required Gate gate,
    required Deck deck,
    required Supir1 supir1,
    required Supir2 supir2,
    required SupirSDR supirSDR,
    required TglTerima tglTerima,
    required TglKirim tglKirim,
    required TextEditingController gateTextController,
    required TextEditingController deckTextController,
    required TextEditingController supir1TextController,
    required TextEditingController supir2TextController,
    required TextEditingController supirSDRTextController,
    required TextEditingController tglTerimaTextController,
    required TextEditingController tglKirimTextController,
    required bool inOut,
    required bool isShowError,
    required List<bool> isNG,
    required List<UpdateCSUNGState> ngStates,
  }) = _UpdateCSUFrameStateSingle;

  factory UpdateCSUFrameStateSingle.initial() => UpdateCSUFrameStateSingle(
        gate: Gate(''),
        deck: Deck(''),
        supir1: Supir1(''),
        supir2: Supir2(''),
        supirSDR: SupirSDR(''),
        tglTerima: TglTerima(''),
        tglKirim: TglKirim(''),
        gateTextController: TextEditingController(),
        deckTextController: TextEditingController(),
        supir1TextController: TextEditingController(),
        supir2TextController: TextEditingController(),
        supirSDRTextController: TextEditingController(),
        tglTerimaTextController: TextEditingController(),
        tglKirimTextController: TextEditingController(),
        inOut: false,
        isShowError: false,
        isNG: [],
        ngStates: [],
      );
}
