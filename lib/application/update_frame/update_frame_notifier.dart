import 'dart:developer';

import 'package:agung_opr/application/update_frame/update_frame_state.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:agung_opr/infrastructure/update_frame/update_frame_repository.dart';
import 'package:collection/collection.dart';
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

  bool checkIfWarnaExist({
    required int index,
  }) {
    String warnaStr = state.updateFrameList[index].warna.getOrLeave('');

    return state.basicColors.entries
            .firstWhereOrNull((element) => element.key == warnaStr) !=
        null;
  }

  checkIfValid() {
    bool isFrameValid() =>
        List.generate(state.updateFrameList.length, ((index) => isValid(index)))
                    .firstWhereOrNull((element) => element == false) !=
                null
            ? false
            : true;

    state = state.copyWith(isValid: isFrameValid());
  }

  Future<void> updateAllFrame({
    required String idSPK,
    required String userId,
    required String nama,
    required String gate,
    required SPPDC sjkb,
    required List<UpdateFrameStateSingle> updateFrameList,
  }) async {
    Either<LocalFailure, Unit>? FOS;

    // required String idSPK,
    // required IDUnit idUnit,
    // required IDKendType idKendType,
    // required FrameUnit frame,
    // required EngineUnit engine,
    // required WarnaUnit warna,
    // required SPPDC sppdc,

    if (updateFrameList.isNotEmpty) {
      //

      state = state.copyWith(isProcessing: true, FOSOUpdateFrame: none());

      // debugger(message: 'called');

      FOS = await _repository.updateFrameSPK(
        userId: userId,
        nama: nama,
        idSPK: idSPK,
        gate: gate,
        sppdc: sjkb.getOrLeave(''),
        updateFrameList: updateFrameList,
      );

      state =
          state.copyWith(isProcessing: false, FOSOUpdateFrame: optionOf(FOS));
    } else {
      //
      state = state.copyWith(isProcessing: false);

      //
    }
  }

  void changeIndex({required int index}) {
    state = state.copyWith(index: index);
  }

  void changeIdSPK({required int idSPK}) {
    state = state.copyWith(idSPK: idSPK);
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
              isShowError: false,
              frame: FrameUnit(frame[index].frame ?? ''),
              warna: WarnaUnit(frame[index].warna ?? ''),
              engine: EngineUnit(frame[index].engine ?? ''),
              idUnit: IDUnit(frame[index].idUnit.toString()),
              idKendType: IDKendType(frame[index].idKendType != null
                  ? frame[index].idKendType.toString()
                  : ''),
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

    final generateListFrameTextController = List.generate(
        length,
        (index) => TextEditingController(
            text: frame[index].frame != null
                ? frame[index].frame.toString()
                : ''));

    state = state.copyWith(
      frameTextController: generateListFrameTextController,
    );

    final generateListWarnaTextController = List.generate(
        length,
        (index) => TextEditingController(
            text: frame[index].warna != null
                ? frame[index].warna.toString()
                : ''));

    state = state.copyWith(
      warnaTextController: generateListWarnaTextController,
    );

    log('frame list $frame');

    final frameHasSPPDC =
        frame.firstWhereOrNull((element) => element.sppdc != null);

    if (frameHasSPPDC != null && frameHasSPPDC.sppdc != null) {
      final sjkbText =
          TextEditingController(text: frameHasSPPDC.sppdc.toString());

      state = state.copyWith(
          sjkbTextController: sjkbText, sppdc: SPPDC(frameHasSPPDC.sppdc!));
    } else {
      state = state.copyWith(
          sjkbTextController: TextEditingController(text: ''),
          sppdc: SPPDC(''));
    }
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

  void changeWarnaController({required String warnaStr, required int index}) {
    final list = [...state.warnaTextController]; // Create a copy of the list

    final TextEditingController element = TextEditingController(text: warnaStr);

    // Update the element at the given index
    list[index] = element;

    // Update the state with the new list
    state = state.copyWith(warnaTextController: list);
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

  void changeNoSPPDC({required String noSPPDCStr}) {
    state = state.copyWith(sppdc: SPPDC(noSPPDCStr));
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
      frame.frame,
      state.sppdc,
      frame.idUnit,
      // frame.warna,
      // frame.engine,
      // frame.noReff,
      // frame.idKendType,
    ];

    log('values $values');

    return Validator.validate(values);
  }

  // Future<void> updateFrame({
  //   required int index,
  // }) async {
  //   Either<LocalFailure, Unit>? FOS;

  //   final item = state.updateFrameList[index];

  //   if (isValid(index)) {
  //     state = state.copyWith(isProcessing: true);

  //     this.changeFOSOUpdateFrame(index: index, FOS: none());

  //     // debugger(message: 'called');

  //     FOS = await _repository.updateFrameSPK(
  //       idSPK: state.idSPK.toString(),
  //       idUnit: item.idUnit,
  //       idKendType: item.idKendType,
  //       engine: item.engine,
  //       frame: item.frame,
  //       warna: item.warna,
  //       sppdc: item.sppdc,
  //     );

  //     state = state.copyWith(isProcessing: false);

  //     this.changeFOSOUpdateFrame(index: index, FOS: optionOf(FOS));
  //   } else {
  //     this.changeShowErrorMessage(index: index, isShowError: true);

  //     state = state.copyWith(isProcessing: false);

  //     this.changeFOSOUpdateFrame(index: index, FOS: optionOf(FOS));
  //   }
  // }
}
