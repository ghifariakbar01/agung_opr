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
        idSPK: spk.idSpk,
        updateCSForm: state.updateCSForm.copyWith(
          nopol: Nopol(spk.nopol),
          jamLoadUnload: JamLoad(jam),
          namaSupir: Supir1(spk.supir1Nm ?? ''),
          namaAsistenSupir: SupirSDR(spk.supir2Nm ?? ''),
          jamLoadUnloadText: TextEditingController(text: jam),
        ));
  }

  // void changeFillNG({required List<CSUNGResult> csuNGResult}) {
  //   for (final NG in csuNGResult) {
  //     final index = NG.idItem;

  //     final NGList = [
  //       ...state.updateFrameList.isNG
  //     ]; // Create a copy of the list

  //     // Update the element at the given index
  //     NGList[index] = true;

  //     // Update the state with the new list
  //     state = state.copyWith(
  //         updateFrameList: state.updateFrameList.copyWith(isNG: NGList));

  //     final NGItemsList = [...state.updateFrameList.ngStates];

  //     // Update the element at the given index
  //     NGItemsList[index] = UpdateCSUNGState(
  //         idCs: NG.idItem, idJenis: NG.idJenis, idPenyebab: NG.idPenyebab);

  //     // Update the state with the new list
  //     state = state.copyWith(
  //         updateFrameList:
  //             state.updateFrameList.copyWith(ngStates: NGItemsList));
  //   }
  // }

  void changeFillEmptyList({required int length}) {
    final generateNGStates =
        List.generate(length, (index) => UpdateCSNGState.initial());

    state = state.copyWith(
        updateCSForm: state.updateCSForm.copyWith(ngStates: generateNGStates));

    final generateIsNG = List.generate(length, (index) => false);

    state = state.copyWith(
        updateCSForm: state.updateCSForm.copyWith(isNG: generateIsNG));
  }

  Future<void> saveQueryOK() async {
    Either<LocalFailure, Unit>? FOS;

    if (isValid()) {
      state = state.copyWith(
          isProcessing: true, showErrorMessages: false, FOSOUpdateCS: none());

      final stateCS = state.updateCSForm;

      // NG

      final queryId = await _repository.getOKSavableQuery(
          idSPK: state.idSPK,
          nopol: stateCS.nopol,
          supir1: stateCS.namaSupir,
          supir2: stateCS.namaAsistenSupir,
          jamLoad: stateCS.jamLoadUnload,
          gate: stateCS.gate,
          ket: stateCS.keterangan,
          status: stateCS.ngStates
              .firstWhere(
                (element) => element.status == OKorNG.NG,
                orElse: () =>
                    UpdateCSNGState.initial().copyWith(status: OKorNG.OK),
              )
              .status,
          tipe: stateCS.tipe);

      debugger();

      // set isNG to true
      FOS = await _repository.saveCSQueryOK(
          idUser: _userModelWithPassword.idUser.toString(),
          gate: state.updateCSForm.gate.getOrLeave(''),
          nama: _userModelWithPassword.nama ?? '',
          queryId: queryId,
          isNG: true);

      state = state.copyWith(
          isProcessing: false,
          showErrorMessages: false,
          FOSOUpdateCS: optionOf(FOS));
    } else {
      // debugger();

      state = state.copyWith(
          isProcessing: false,
          showErrorMessages: true,
          FOSOUpdateCS: optionOf(FOS));
    }
  }

  Future<void> saveQueryNG() async {
    Either<LocalFailure, Unit>? FOS;

    if (isValid()) {
      state = state.copyWith(
          isProcessing: true, showErrorMessages: false, FOSOUpdateCS: none());

      final ngStates = state.updateCSForm.ngStates;

      final queryId = await _repository.getNGSavableQuery(
          idSPK: state.idSPK, frameName: state.frameName, ngStates: ngStates);

      FOS = await _repository.saveCSQueryOK(
          idUser: _userModelWithPassword.idUser.toString(),
          gate: state.updateCSForm.gate.getOrLeave(''),
          nama: _userModelWithPassword.nama ?? '',
          queryId: queryId);

      state = state.copyWith(
          isProcessing: false,
          showErrorMessages: false,
          FOSOUpdateCS: optionOf(FOS));
    } else {
      // debugger();

      state = state.copyWith(
          isProcessing: false,
          showErrorMessages: true,
          FOSOUpdateCS: optionOf(FOS));
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

  void changeidSPK(int idSPK) {
    state = state.copyWith(
      idSPK: idSPK,
      FOSOUpdateCS: none(),
    );
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
        orElse: () {
          debugger();
          return Tipe.Unknown;
        });

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
