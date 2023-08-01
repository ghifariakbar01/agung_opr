import 'package:agung_opr/application/update_frame/update_frame_state.dart';
import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/validator.dart';
import 'frame.dart';
import 'update_frame_single_state.dart';

class UpdateFrameNotifier extends StateNotifier<UpdateFrameState> {
  UpdateFrameNotifier() : super(UpdateFrameState.initial());

  void changeFillEmptyList({required int length, required List<Frame> frame}) {
    final generateList = List.generate(
        length,
        (index) => UpdateFrameStateSingle(
            idUnit: IDUnit(frame[index].idUnit.toString()),
            engine: EngineUnit(''),
            frame: FrameUnit(frame[index].frame ?? ''),
            idKendType: IDKendType(frame[index].idKendType != null
                ? frame[index].idKendType.toString()
                : ''),
            noReff: NoReffEXP(frame[index].noReffExp ?? ''),
            sppdc: SPPDC(''),
            warna: WarnaUnit(frame[index].warna ?? '')));

    state = state.copyWith(updateFrameList: [...generateList]);
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

  bool get isValid {
    final values = [state.updateFrameList];

    for (final frame in values) {
      for (final frameItem in frame) {
        // HERE
        final values = [
          frameItem.engine,
          frameItem.frame,
          frameItem.idKendType,
          frameItem.idUnit,
          frameItem.noReff,
          // frameItem.sppdc,
          frameItem.warna,
        ];

        return Validator.validate(values);
      }
    }

    return false;
  }
}
