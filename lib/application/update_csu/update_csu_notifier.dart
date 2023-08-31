import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/local_failure.dart';
import '../../domain/value_objects_copy.dart';
import '../../infrastructure/update_csu/update_csu_repository.dart';
import '../../utils/validator.dart';
import '../check_sheet/unit/state/csu_ng_result.dart';
import '../check_sheet/unit/state/csu_result.dart';
import 'state/update_csu_ng_state.dart';
import 'state/update_csu_state.dart';

class UpdateCSUNotifier extends StateNotifier<UpdateCSUState> {
  UpdateCSUNotifier(
    this._repository,
  ) : super(UpdateCSUState.initial());

  final UpdateCSUFrameRepository _repository;

  void changeFillInitial() {
    // debugger(message: 'called');

    state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(
            gate: Gate(''),
            deck: Deck(''),
            // supir1: Supir1(''),
            // supir2: Supir2(''),
            supirSDR: SupirSDR(''),
            tglTerima: TglTerima(''),
            tglKirim: TglKirim(''),
            gateTextController: TextEditingController(),
            deckTextController: TextEditingController(),
            // supir1TextController: TextEditingController(),
            // supir2TextController: TextEditingController(),
            supirSDRTextController: TextEditingController(),
            tglTerimaTextController: TextEditingController(),
            tglKirimTextController: TextEditingController(),
            inOut: false));
  }

  void changeFillWithValue({required CSUResult csuResult}) {
    // debugger(message: 'called');

    state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(
            gate: Gate(csuResult.idGate.toString()),
            deck: Deck(csuResult.posisi ?? ''),
            // supir1: Supir1(csuResult.supir1 ?? ''),
            // supir2: Supir2(csuResult.supir2 ?? ''),
            supirSDR: SupirSDR(csuResult.supirSDR ?? ''),
            tglKirim: TglKirim(''),
            tglTerima: TglTerima(''),
            gateTextController:
                TextEditingController(text: csuResult.idGate.toString()),
            deckTextController:
                TextEditingController(text: csuResult.posisi ?? ''),
            // supir1TextController:
            //     TextEditingController(text: csuResult.supir1 ?? ''),
            // supir2TextController:
            //     TextEditingController(text: csuResult.supir2 ?? ''),
            supirSDRTextController:
                TextEditingController(text: csuResult.supirSDR ?? ''),
            tglTerimaTextController: TextEditingController(),
            tglKirimTextController: TextEditingController(),
            inOut: csuResult.inout == false ? true : false));
  }

  void changeFillNG({required List<CSUNGResult> csuNGResult}) {
    for (final NG in csuNGResult) {
      final index = NG.idItem;

      final NGList = [
        ...state.updateFrameList.isNG
      ]; // Create a copy of the list

      // Update the element at the given index
      NGList[index] = true;

      // Update the state with the new list
      state = state.copyWith(
          updateFrameList: state.updateFrameList.copyWith(isNG: NGList));

      final NGItemsList = [...state.updateFrameList.ngStates];

      // Update the element at the given index
      NGItemsList[index] = UpdateCSUNGState(
          idCs: NG.idItem, idJenis: NG.idJenis, idPenyebab: NG.idPenyebab);

      // Update the state with the new list
      state = state.copyWith(
          updateFrameList:
              state.updateFrameList.copyWith(ngStates: NGItemsList));
    }
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

    // debugger(message
    //: 'called');
  }

  Future<void> saveQueryOK() async {
    Either<LocalFailure, Unit>? FOS;

    if (isValid()) {
      state = state.copyWith(
          isProcessing: true, showErrorMessages: false, FOSOUpdateCSU: none());

      // debugger(message: 'called');

      final stateCSU = state.updateFrameList;

      // NG
      final NG = state.updateFrameList.isNG;

      final isNG = NG.firstWhere(
        (element) => element == true,
        orElse: () => false,
      );

      final queryId = _repository.getOKSavableQuery(
          idUnit: state.idUnit,
          frameName: state.frameName,
          gate: stateCSU.gate,
          posisi: stateCSU.deck,
          // supir1: stateCSU.supir1,
          // supir2: stateCSU.supir2,
          supirSDR: stateCSU.supirSDR,
          tglKirim: stateCSU.tglKirim,
          tglTerima: stateCSU.tglTerima,
          noDefect: isNG == true ? 1 : 0,
          inOut: stateCSU.inOut == false ? 0 : 1);

      FOS = await _repository.saveCSUQueryOK(queryId: queryId, isNG: isNG);

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

      final List<UpdateCSUNGState> queryNgs = [];

      for (int index = 0; index < state.updateFrameList.isNG.length; index++) {
        if (NG[index] == true) {
          // GET NG ITEM, JENIS, PENYEBAB
          final NGItem = state.updateFrameList.ngStates[index];
          queryNgs.add(NGItem);
        }
      }

      final queryId = _repository.getNGSavableQuery(
          idUnit: state.idUnit, frameName: state.frameName, ngStates: queryNgs);

      FOS = await _repository.saveCSUQueryNG(queryId: queryId);

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

  void changeNGId({required int id, required int index}) {
    final list = [
      ...state.updateFrameList.ngStates
    ]; // Create a copy of the list

    final elementAt = list.elementAt(index).copyWith(idCs: id);

    // Update the element at the given index
    list[index] = elementAt;

    // Update the state with the new list
    state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(ngStates: list));
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

  void changeIdUnit(int idUnit) {
    state = state.copyWith(
      idUnit: idUnit,
      FOSOUpdateCSU: none(),
    );
  }

  void changeIdCS(int idCS) {
    state = state.copyWith(
      idCS: idCS,
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

  bool isTappable(
      {required CSUResult csuResult, required List<CSUResult> csuResultItems}) {
    Map<bool, List<CSUResult>> listGroupByGate = csuResultItems
        .groupListsBy((element) => element.gate == csuResult.gate);

    // USE FIRST, SINCE ONLY 1 LIST
    List<CSUResult> listCSUResult = listGroupByGate.values.first;

    if (listCSUResult.length == 2) {
      bool isOut =
          listCSUResult.firstWhere((element) => element.inout == true).inout ??
              false;

      return isOut ? false : true;
    }

    return true;
  }

  bool isValid() {
    final frame = state.updateFrameList;

    // HERE
    final values = [
      frame.gate,
      frame.deck,
      // frame.supir1,
      // frame.supir2,
      // frame.supirSDR,
      // frame.tglTerima,
      // frame.tglKirim,
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
