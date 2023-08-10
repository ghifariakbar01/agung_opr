import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/state/csu_items.dart';
import 'package:agung_opr/application/update_csu/state/update_csu_form_state.dart';
import 'package:agung_opr/application/update_csu/state/update_csu_state.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:agung_opr/infrastructure/update_frame/update_frame_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/update_csu/update_csu_repository.dart';
import '../../utils/validator.dart';
import '../supir/supir.dart';

class UpdateCSUNotifier extends StateNotifier<UpdateCSUState> {
  UpdateCSUNotifier(
    this._repository,
  ) : super(UpdateCSUState.initial());

  final UpdateCSUFrameRepository _repository;

  Future<void> updateCheckSheet() async {
    Either<LocalFailure, Unit>? FOS;

    final item = state.updateFrameList;

    if (isValid()) {
      state = state.copyWith(isProcessing: true, FOSOUpdateCSU: none());

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

      state = state.copyWith(isProcessing: false, FOSOUpdateCSU: none());
    } else {
      state = state.copyWith(isProcessing: false, FOSOUpdateCSU: optionOf(FOS));
    }
  }

  Future<void> getCSUItems() async {
    Either<RemoteFailure, List<CSUItems>>? FOS;

    if (isValid()) {
      state = state.copyWith(isProcessing: true, FOSOUpdateCSUItems: none());

      debugger(message: 'called');

      FOS = await _repository.getCSUItems();

      state = state.copyWith(
          isProcessing: false, FOSOUpdateCSUItems: optionOf(FOS));
    } else {
      state = state.copyWith(
          isProcessing: false, FOSOUpdateCSUItems: optionOf(FOS));
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

  void changeCSUItems(List<CSUItems> csuItems) {
    state = state.copyWith(
      csuItems: csuItems,
      FOSOUpdateCSUItems: none(),
    );
  }

  void changeFillEmptyList({required int length}) {
    final generateIsNG = List.generate(length, (index) => false);

    state = state.copyWith(
        updateFrameList: state.updateFrameList.copyWith(isNG: generateIsNG));

    debugger(message: 'called');
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
}
