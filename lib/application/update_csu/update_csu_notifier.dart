import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/state/csu_id_query.dart';
import 'package:agung_opr/application/update_csu/state/update_csu_ng_state.dart';
import 'package:agung_opr/application/update_csu/state/update_csu_state.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/update_csu/update_csu_repository.dart';
import '../../utils/validator.dart';

class UpdateCSUNotifier extends StateNotifier<UpdateCSUState> {
  UpdateCSUNotifier(
    this._repository,
  ) : super(UpdateCSUState.initial());

  final UpdateCSUFrameRepository _repository;

  Future<void> saveQueryOK() async {
    Either<LocalFailure, Unit>? FOS;

    if (isValid()) {
      state = state.copyWith(
          isProcessing: true, showErrorMessages: false, FOSOUpdateCSU: none());

      debugger(message: 'called');

      final stateCSU = state.updateFrameList;

      final queryId = _repository.getOKSavableQuery(
          idUnit: state.idUnit,
          frameName: state.frameName,
          gate: stateCSU.gate,
          posisi: stateCSU.deck,
          supir1: stateCSU.supir1,
          supir2: stateCSU.supir2,
          supirSDR: stateCSU.supirSDR,
          tglKirim: stateCSU.tglKirim,
          tglTerima: stateCSU.tglTerima);

      FOS = await _repository.saveCSUQueryOK(queryId: queryId);

      state = state.copyWith(
          isProcessing: false,
          showErrorMessages: false,
          FOSOUpdateCSU: optionOf(FOS));
    } else {
      state = state.copyWith(
          isProcessing: false,
          showErrorMessages: true,
          FOSOUpdateCSU: optionOf(FOS));
    }
  }

  Future<void> saveQueryNG() async {
    Either<LocalFailure, Unit>? FOS;

    if (isValid()) {
      state = state.copyWith(
          isProcessing: true, showErrorMessages: false, FOSOUpdateCSU: none());

      // debugger(message: 'called');

      final NG = state.updateFrameList.isNG;

      final List<CSUIDQuery> queryIds = [];

      for (int index = 0; index < state.updateFrameList.isNG.length; index++) {
        if (NG[index] == true) {
          // GET NG ITEM, JENIS, PENYEBAB
          final NGItem = state.updateFrameList.ngStates[index];

          final query = _repository.getNGSavableQuery(
              idUnit: state.idUnit,
              frameName: state.frameName,
              idCheckSheet: NGItem.idCs,
              idJenisDefect: NGItem.idJenis,
              idPenyebabDefect: NGItem.idPenyebab);

          queryIds.add(query);
        }
      }

      FOS = await _repository.saveCSUQueryNG(queryIds: queryIds);

      state = state.copyWith(
          isProcessing: false,
          showErrorMessages: false,
          FOSOUpdateCSU: optionOf(FOS));
    } else {
      state = state.copyWith(
          isProcessing: false,
          showErrorMessages: true,
          FOSOUpdateCSU: optionOf(FOS));
    }
  }

  void changeIsNG({required bool isNG, required int index}) {
    final list = [...state.updateFrameList.isNG]; // Create a copy of the list

    // Update the element at the given index
    list[index] = isNG;

    // Update the state with the new list
    state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(isNG: list));
  }

  void changeNGJenis({required int id, required int index}) {
    final list = [
      ...state.updateFrameList.ngStates
    ]; // Create a copy of the list

    final elementAt = list.elementAt(index).copyWith(idJenis: id);

    // Update the element at the given index
    list[index] = elementAt;

    // Update the state with the new list
    state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(ngStates: list));
  }

  void changeNGPenyebab({required int id, required int index}) {
    final list = [
      ...state.updateFrameList.ngStates
    ]; // Create a copy of the list

    final elementAt = list.elementAt(index).copyWith(idPenyebab: id);

    // Update the element at the given index
    list[index] = elementAt;

    // Update the state with the new list
    state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(ngStates: list));
  }

  void changeFillEmptyList({required int length}) {
    final generateIsNG = List.generate(length, (index) => false);

    state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(isNG: generateIsNG));

    final generateNGStates =
        List.generate(length, (index) => UpdateCSUNGState.initial());

    state = state.copyWith(
        updateFrameList:
            state.updateFrameList.copyWith(ngStates: generateNGStates));

    // debugger(message: 'called');
  }

  void changeIdUnit(int idUnit) {
    state = state.copyWith(
      idUnit: idUnit,
      FOSOUpdateCSU: none(),
    );
  }

  void changeFrameName(String frameName) {
    state = state.copyWith(
      frameName: frameName,
      FOSOUpdateCSU: none(),
    );
  }

  void changeGate(String gateStr) {
    state = state.copyWith(
      updateFrameList: state.updateFrameList.copyWith(gate: Gate(gateStr)),
      FOSOUpdateCSU: none(),
    );
  }

  void changeDeck(String deckStr) {
    state = state.copyWith(
      updateFrameList: state.updateFrameList.copyWith(deck: Deck(deckStr)),
      FOSOUpdateCSU: none(),
    );
  }

  void changeSupir1(String supirStr) {
    state = state.copyWith(
      updateFrameList: state.updateFrameList.copyWith(supir1: Supir1(supirStr)),
      FOSOUpdateCSU: none(),
    );
  }

  void changeSupir2(String supirStr) {
    state = state.copyWith(
      updateFrameList: state.updateFrameList.copyWith(supir2: Supir2(supirStr)),
      FOSOUpdateCSU: none(),
    );
  }

  void changeSupirSDR(String supirStr) {
    state = state.copyWith(
      updateFrameList:
          state.updateFrameList.copyWith(supirSDR: SupirSDR(supirStr)),
      FOSOUpdateCSU: none(),
    );
  }

  void changeTglTerima(String tglTerimaStr) {
    state = state.copyWith(
      updateFrameList:
          state.updateFrameList.copyWith(tglTerima: TglTerima(tglTerimaStr)),
      FOSOUpdateCSU: none(),
    );
  }

  void changeTglKirim(String tglKirimStr) {
    state = state.copyWith(
      updateFrameList:
          state.updateFrameList.copyWith(tglKirim: TglKirim(tglKirimStr)),
      FOSOUpdateCSU: none(),
    );
  }

  bool isValid() {
    final frame = state.updateFrameList;

    // HERE
    final values = [
      frame.gate,
      frame.deck,
      frame.supir1,
      frame.supir2,
      frame.supirSDR,
      frame.tglTerima,
      frame.tglKirim,
    ];

    return Validator.validate(values);
  }

  Future<void> updateCheckSheet() async {
    Either<LocalFailure, Unit>? FOS;

    final item = state.updateFrameList;

    if (isValid()) {
      state = state.copyWith(
          isProcessing: true, showErrorMessages: false, FOSOUpdateCSU: none());

      debugger(message: 'called');

      // FOS = await _repository.(
      //   idSPK: state.idSPK.toString(),
      //   idUnit: item.idUnit,
      //   idKendType: item.idKendType,
      //   engine: item.engine,
      //   frame: item.frame,
      //   noReff: item.noReff,
      //   warna: item.warna,
      //   sppdc: item.sppdc,
      // );

      state = state.copyWith(
          isProcessing: false, showErrorMessages: false, FOSOUpdateCSU: none());
    } else {
      state = state.copyWith(
          isProcessing: false,
          showErrorMessages: true,
          FOSOUpdateCSU: optionOf(FOS));
    }
  }
}
