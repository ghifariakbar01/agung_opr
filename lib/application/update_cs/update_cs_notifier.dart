import 'dart:developer';

import 'package:agung_opr/application/user/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/local_failure.dart';
import '../../domain/value_objects_copy.dart';
import '../../infrastructure/update_cs/update_cs_repository.dart';
import '../../utils/validator.dart';
import '../check_sheet/loading/state/update_cs_form_state.dart';
import '../check_sheet/loading/state/update_cs_ng_state.dart';
import '../check_sheet/loading/state/update_cs_state.dart';
import '../check_sheet/shared/state/cs_id_query.dart';
import '../mode/mode_state.dart';
import '../spk/spk.dart';

class UpdateCSNotifier extends StateNotifier<UpdateCSState> {
  UpdateCSNotifier(
    this._repository,
    this._userModelWithPassword,
  ) : super(UpdateCSState.initial());

  final UpdateCSRepository _repository;
  final UserModelWithPassword _userModelWithPassword;

  changeModeState(ModeState mode) => state = state.copyWith(modeSelected: mode);

  void changeFillInitial() {
    state = state.copyWith(updateCSForm: UpdateCSFormState.initial());
  }

  changeSelectedSPK(SPK spk) => state = state.copyWith(selectedSPK: spk);

  void changeFillWithValue({
    required SPK spk,
  }) {
    // debugger(message: 'called');
    final picked = TimeOfDay.now();
    final jam =
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

    state = state.copyWith(
        updateCSForm: state.updateCSForm.copyWith(
      nopol: Nopol(spk.nopol),
      jamLoadUnload: JamLoad(jam),
      namaSupir: Supir1(spk.supir1Nm ?? ''),
      keterangan: Keterangan(spk.ket ?? ''),
      namaAsistenSupir: SupirSDR(spk.supir2Nm ?? ''),
      jamLoadUnloadText: TextEditingController(text: jam),
    ));
  }

  void changeFillEmptyList({required int isNGLength}) {
    final generateNGStates =
        List.generate(isNGLength, (index) => UpdateCSNGState.initial());

    state = state.copyWith(
        updateCSForm: state.updateCSForm.copyWith(ngStates: generateNGStates));

    final generateIsNG = List.generate(isNGLength, (index) => false);

    state = state.copyWith(
        updateCSForm: state.updateCSForm.copyWith(isNG: generateIsNG));
  }

  Future<void> saveQuery() async {
    Either<LocalFailure, Unit>? FOS;

    if (isValid()) {
      state = state.copyWith(
        FOSOUpdateCS: none(),
        isProcessing: true,
        showErrorMessages: false,
      );

      final stateCS = state.updateCSForm;
      final CSIDQuery _queryId = await _repository.getOKSavableQuery(
        idSPK: state.selectedSPK.idSpk,
        nopol: stateCS.nopol,
        supir1: stateCS.namaSupir,
        jamLoad: stateCS.jamLoadUnload,
        supir2: stateCS.namaAsistenSupir,
        gate: stateCS.gate,
        tipe: stateCS.tipe,
        ket: stateCS.keterangan,
        status: stateCS.ngStates
            .firstWhere(
              (element) => element.status == OKorNG.NG,
              orElse: () =>
                  UpdateCSNGState.initial().copyWith(status: OKorNG.OK),
            )
            .status,
      );

      final ngStates = state.updateCSForm.ngStates;

      final CSIDQuery _queryIdNg = await _repository.getNGSavableQuery(
        ngStates: ngStates,
        frameName: state.frameName,
        idSPK: state.selectedSPK.idSpk,
      );

      final idSpk = state.selectedSPK.idSpk;
      final CSIDQuery queryIdToSave =
          CSIDQuery(idSPK: idSpk, query: _queryId.query + _queryIdNg.query);

      FOS = await _repository.saveCSQuery(
        queryId: queryIdToSave,
        idUser: _userModelWithPassword.idUser.toString(),
        gate: state.updateCSForm.gate.getOrLeave(''),
        nama: _userModelWithPassword.nama ?? '',
      );

      state = state.copyWith(
          isProcessing: false,
          showErrorMessages: false,
          FOSOUpdateCS: optionOf(FOS));
      return;
    } else {
      state = state.copyWith(showErrorMessages: true);

      return;
    }
  }

  void changeIsNG({required bool isNG, required int index}) {
    final list = [...state.updateCSForm.isNG]; // Create a copy of the list

    // Update the element at the given index
    list[index] = isNG;

    // Update the state with the new list
    state =
        state.copyWith(updateCSForm: state.updateCSForm.copyWith(isNG: list));
  }

  void changeNGId({required int id, required int index}) {
    final list = [...state.updateCSForm.ngStates]; // Create a copy of the list

    final elementAt = list.elementAt(index).copyWith(id: id);

    // Update the element at the given index
    list[index] = elementAt;

    // Update the state with the new list
    state = state.copyWith(
        updateCSForm: state.updateCSForm.copyWith(ngStates: list));
  }

  void changeNGStatus({required OKorNG status, required int index}) {
    final list = [...state.updateCSForm.ngStates]; // Create a copy of the list

    final elementAt = list.elementAt(index).copyWith(status: status);

    // Update the element at the given index
    list[index] = elementAt;

    // Update the state with the new list
    state = state.copyWith(
        updateCSForm: state.updateCSForm.copyWith(ngStates: list));
  }

  void changeNGKeterangan({required String keteranganStr, required int index}) {
    final list = [...state.updateCSForm.ngStates]; // Create a copy of the list

    final elementAt =
        list.elementAt(index).copyWith(keterangan: Keterangan(keteranganStr));

    // Update the element at the given index
    list[index] = elementAt;

    log('keteranganStr $keteranganStr index $index');

    // Update the state with the new list
    state = state.copyWith(
        updateCSForm: state.updateCSForm.copyWith(ngStates: list));
  }

  void changeIdCS(int idCS) {
    state = state.copyWith(
      idCS: idCS,
      FOSOUpdateCS: none(),
    );
  }

  void changeFrameName(String frameName) {
    state = state.copyWith(
      frameName: frameName,
      FOSOUpdateCS: none(),
    );
  }

  void changeGate(String gateStr) {
    state = state.copyWith(
      updateCSForm: state.updateCSForm.copyWith(gate: Gate(gateStr)),
      FOSOUpdateCS: none(),
    );
  }

  Future<void> changeTipe(ModeState modeState) async {
    final tipe = modeState.maybeWhen(
        checkSheetLoading: () => Tipe.loading,
        checkSheetUnloading: () => Tipe.unload,
        checkSheetLoadingUnloading: () => Tipe.loadunload,
        orElse: () => Tipe.Unknown);

    state = state.copyWith(
      updateCSForm: state.updateCSForm.copyWith(tipe: tipe),
      FOSOUpdateCS: none(),
    );
  }

  void changeJamLoad(String jamLoadStr) {
    state = state.copyWith(
      updateCSForm:
          state.updateCSForm.copyWith(jamLoadUnload: JamLoad(jamLoadStr)),
      FOSOUpdateCS: none(),
    );
  }

  // void changeSupir1(String supirStr) {
  //   state = state.copyWith(
  //     updateFrameList: state.updateFrameList.copyWith(supir1: Supir1(supirStr)),
  //     FOSOUpdateCS: none(),
  //   );
  // }

  // void changeSupir2(String supirStr) {
  //   state = state.copyWith(
  //     updateFrameList: state.updateFrameList.copyWith(supir2: Supir2(supirStr)),
  //     FOSOUpdateCS: none(),
  //   );
  // }

  // void changeSupirSDR(String supirStr) {
  //   state = state.copyWith(
  //     updateFrameList:
  //         state.updateFrameList.copyWith(supirSDR: SupirSDR(supirStr)),
  //     FOSOUpdateCS: none(),
  //   );
  // }

  // void changeTglTerima(String tglTerimaStr) {
  //   state = state.copyWith(
  //     updateFrameList:
  //         state.updateFrameList.copyWith(tglTerima: TglTerima(tglTerimaStr)),
  //     FOSOUpdateCS: none(),
  //   );
  // }

  void changeKeterangan(String keteranganStr) {
    state = state.copyWith(
      updateCSForm:
          state.updateCSForm.copyWith(keterangan: Keterangan(keteranganStr)),
      FOSOUpdateCS: none(),
    );
  }

  bool isValid() {
    final frame = state.updateCSForm;

    // HERE
    final values = [
      frame.gate,
      frame.jamLoadUnload,
      // frame.supir1,
      // frame.supir2,
      // frame.supirSDR,
      // frame.tglTerima,
      // frame.tglKirim,
    ];

    return Validator.validate(values);
  }
}
