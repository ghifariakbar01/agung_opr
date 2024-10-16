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
    state = state.copyWith(isValid: false);

    List<bool> validOrNot = [];

    for (var i = 0; i < state.updateFrameList.length; i++) {
      // final frame = state.updateFrameList[i];
      final boolean = isValid(i);
      // _changeShowError(isShowError: boolean, index: i);
      validOrNot.add(boolean);
    }

    state = state.copyWith(
        isValid: validOrNot.firstWhere(
      (val) => val == true,
      orElse: () => false,
    ));
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

    if (updateFrameList.isNotEmpty) {
      state = state.copyWith(
        isProcessing: true,
        FOSOUpdateFrame: none(),
      );

      FOS = await _repository.updateFrameSPK(
        userId: userId,
        nama: nama,
        idSPK: idSPK,
        gate: gate,
        sppdc: sjkb.getOrLeave(''),
        updateFrameList: updateFrameList,
      );

      state = state.copyWith(
        isProcessing: false,
        FOSOUpdateFrame: optionOf(FOS),
      );
    } else {
      state = state.copyWith(
        isProcessing: false,
        FOSOUpdateFrame: none(),
      );
    }
  }

  void changeIndex({required int index}) {
    state = state.copyWith(index: index);
  }

  void changeIdSPK({required int idSPK}) {
    state = state.copyWith(idSPK: idSPK);
  }

  void changeFillEmptyList({
    required int length,
    required List<Frame> frame,
  }) {
    final generateList = List.generate(
        length,
        (index) => UpdateFrameStateSingle(
              isShowError: false,
              uDate: frame[index].uDate ?? '',
              uUser: frame[index].uUser ?? '',
              frame: FrameUnit(frame[index].frame ?? ''),
              warna: WarnaUnit(frame[index].warna ?? ''),
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

    final frameHasSPPDC = frame.firstWhereOrNull(
      (element) => element.sppdc != null,
    );

    if (frameHasSPPDC != null && frameHasSPPDC.sppdc != null) {
      final sjkbText = TextEditingController(
        text: frameHasSPPDC.sppdc.toString(),
      );

      state = state.copyWith(
        sjkbTextController: sjkbText,
        sppdc: SPPDC(frameHasSPPDC.sppdc!),
      );
    } else {
      state = state.copyWith(
        sjkbTextController: TextEditingController(text: ''),
        sppdc: SPPDC(''),
      );
    }
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
      frame.idKendType,
      frame.warna,
      // frame.engine,
      // frame.noReff,
    ];

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
  // this._changeShowError(index: index, isShowError: true);

  //     state = state.copyWith(isProcessing: false);

  //     this.changeFOSOUpdateFrame(index: index, FOS: optionOf(FOS));
  //   }
  // }
}
