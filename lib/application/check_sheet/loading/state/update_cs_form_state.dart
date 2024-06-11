import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'update_cs_ng_state.dart';

part 'update_cs_form_state.freezed.dart';

@freezed
class UpdateCSFormState with _$UpdateCSFormState {
  const factory UpdateCSFormState({
    required bool isEnabled,
    required Nopol nopol,
    required Supir1 namaSupir,
    required SupirSDR namaAsistenSupir,
    required TglBerangkat tglBerangkat,
    required JamLoad jamLoadUnload,
    required Gate gate,
    required Keterangan keterangan,
    required Tipe tipe,
    required bool isShowError,
    required TextEditingController jamLoadUnloadText,
    required TextEditingController gateTextController,
    required List<bool> isNG,
    required List<UpdateCSNGState> ngStates,
  }) = _UpdateCSFormState;

  factory UpdateCSFormState.initial() => UpdateCSFormState(
        isEnabled: false,
        nopol: Nopol(''),
        namaSupir: Supir1(''),
        namaAsistenSupir: SupirSDR(''),
        tglBerangkat: TglBerangkat(''),
        jamLoadUnload: JamLoad('', DateTime.now().toString()),
        gate: Gate(''),
        keterangan: Keterangan(''),
        tipe: Tipe.Unknown,
        jamLoadUnloadText: TextEditingController(),
        gateTextController: TextEditingController(),
        isShowError: false,
        isNG: [],
        ngStates: [],
      );
}
