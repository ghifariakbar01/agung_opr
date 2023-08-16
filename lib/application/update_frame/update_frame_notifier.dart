import 'dart:developer';

import 'package:agung_opr/application/update_frame/update_frame_state.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:agung_opr/infrastructure/update_frame/update_frame_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/validator.dart';
import 'frame.dart';
import 'update_frame_single_state.dart';

class UpdateFrameNotifier extends StateNotifier<UpdateFrameState> {
  UpdateFrameNotifier(
    this._repository,
  ) : super(UpdateFrameState.initial());

  final UpdateFrameRepository _repository;

  Future<void> updateFrame({
    required int index,
  }) async {
    Either<LocalFailure, Unit>? FOS;

    final item = state.updateFrameList[index];

    if (isValid(index)) {
      state = state.copyWith(isProcessing: true);

      this.changeFOSOUpdateFrame(index: index, FOS: none());

      // debugger(message: 'called');

      FOS = await _repository.updateFrameSPK(
        idSPK: state.idSPK.toString(),
        idUnit: item.idUnit,
        idKendType: item.idKendType,
        engine: item.engine,
        frame: item.frame,
        noReff: item.noReff,
        warna: item.warna,
        sppdc: item.sppdc,
      );

      state = state.copyWith(isProcessing: false);

      this.changeFOSOUpdateFrame(index: index, FOS: optionOf(FOS));
    } else {
      this.changeShowErrorMessage(index: index, isShowError: true);

      state = state.copyWith(isProcessing: false);

      this.changeFOSOUpdateFrame(index: index, FOS: optionOf(FOS));
    }
  }

  void changeIndex({required int index}) {
    state = state.copyWith(index: index);
  }

  void changeIdSPK({required int idSPK}) {
    state = state.copyWith(idSPK: idSPK);
  }

  void changeFOSOUpdateFrame(
      {required Option<Either<LocalFailure, Unit>> FOS, required int index}) {
    final list = [...state.FOSOUpdateFrame]; // Create a copy of the list

    final Option<Either<LocalFailure, Unit>> updatedElement = FOS;

    // Update the element at the given index
    list[index] = updatedElement;

    // Update the state with the new list
    state = state.copyWith(FOSOUpdateFrame: list);
  }

  void changeShowErrorMessage({required bool isShowError, required int index}) {
    final list = [...state.updateFrameList]; // Create a copy of the list

    final UpdateFrameStateSingle updatedElement =
        list.elementAt(index).copyWith(isShowError: isShowError);

    // Update the element at the given index
    list[index] = updatedElement;

    // Update the state with the new list
    state = state.copyWith(updateFrameList: list);
  }

  void changeFillEmptyList({required int length, required List<Frame> frame}) {
    final generateList = List.generate(
        length,
        (index) => UpdateFrameStateSingle(
              idUnit: IDUnit(frame[index].idUnit.toString()),
              frame: FrameUnit(frame[index].frame ?? ''),
              idKendType: IDKendType(frame[index].idKendType != null
                  ? frame[index].idKendType.toString()
                  : ''),
              noReff: NoReffEXP(frame[index].noReffExp ?? ''),
              engine: EngineUnit(frame[index].engine ?? ''),
              warna: WarnaUnit(frame[index].warna ?? ''),
              sppdc: SPPDC(''),
              isShowError: false,
            ));

    state = state.copyWith(
      updateFrameList: generateList,
    );

    final generateListModelTextController = List.generate(
        length,
        (index) => TextEditingController(
            text: frame[index].idKendType != null
                ? frame[index].idKendType.toString()
                : ''));

    state = state.copyWith(
      modelTextController: generateListModelTextController,
    );

    Either<LocalFailure, Unit>? initial;

    final generateListFOSOUpdateFrame =
        List.generate(length, (index) => optionOf(initial));

    // debugger(message: 'called');

    state = state.copyWith(
      FOSOUpdateFrame: generateListFOSOUpdateFrame,
    );
  }

  void changeIdUnit({required String idUnitStr, required int index}) {
    final list = [...state.updateFrameList]; // Create a copy of the list

    final UpdateFrameStateSingle updatedElement =
        list.elementAt(index).copyWith(idUnit: IDUnit(idUnitStr));

    // Update the element at the given index
    list[index] = updatedElement;

    // Update the state with the new list
    state = state.copyWith(updateFrameList: list);
  }

  void changeFrame({required String frameStr, required int index}) {
    final list = [...state.updateFrameList]; // Create a copy of the list

    final UpdateFrameStateSingle updatedElement =
        list.elementAt(index).copyWith(frame: FrameUnit(frameStr));

    // Update the element at the given index
    list[index] = updatedElement;

    // Update the state with the new list
    state = state.copyWith(updateFrameList: list);
  }

  void changeEngine({required String engineStr, required int index}) {
    final list = [...state.updateFrameList]; // Create a copy of the list

    final UpdateFrameStateSingle updatedElement =
        list.elementAt(index).copyWith(engine: EngineUnit(engineStr));

    // Update the element at the given index
    list[index] = updatedElement;

    // Update the state with the new list
    state = state.copyWith(updateFrameList: list);
  }

  void changeWarna({required String warnaStr, required int index}) {
    final list = [...state.updateFrameList]; // Create a copy of the list

    final UpdateFrameStateSingle updatedElement =
        list.elementAt(index).copyWith(warna: WarnaUnit(warnaStr));

    // Update the element at the given index
    list[index] = updatedElement;

    // Update the state with the new list
    state = state.copyWith(updateFrameList: list);
  }

  void changeNoReffEXP({required String noReffStr, required int index}) {
    final list = [...state.updateFrameList]; // Create a copy of the list

    final UpdateFrameStateSingle updatedElement =
        list.elementAt(index).copyWith(noReff: NoReffEXP(noReffStr));

    // Update the element at the given index
    list[index] = updatedElement;

    // Update the state with the new list
    state = state.copyWith(updateFrameList: list);
  }

  void changeNoSPPDC({required String noSPPDCStr, required int index}) {
    final list = [...state.updateFrameList]; // Create a copy of the list

    final UpdateFrameStateSingle updatedElement =
        list.elementAt(index).copyWith(sppdc: SPPDC(noSPPDCStr));

    // Update the element at the given index
    list[index] = updatedElement;

    // Update the state with the new list
    state = state.copyWith(updateFrameList: list);
  }

  void changeIdKendType({required String idKendTypeStr, required int index}) {
    final list = [...state.updateFrameList]; // Create a copy of the list

    final UpdateFrameStateSingle updatedElement =
        list.elementAt(index).copyWith(idKendType: IDKendType(idKendTypeStr));

    // Update the element at the given index
    list[index] = updatedElement;

    // Update the state with the new list
    state = state.copyWith(updateFrameList: list);
  }

  bool isValid(int index) {
    final frame = state.updateFrameList[index];

    // HERE
    final values = [
      frame.engine,
      frame.frame,
      frame.idKendType,
      frame.idUnit,
      frame.noReff,
      // frame.sppdc,
      frame.warna,
    ];

    return Validator.validate(values);
  }
}
