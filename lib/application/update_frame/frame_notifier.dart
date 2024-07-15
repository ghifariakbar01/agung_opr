import 'package:agung_opr/application/update_frame/frame.dart';
import 'package:agung_opr/application/update_frame/frame_state.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/frame/frame_repository.dart';

class FrameNotifier extends StateNotifier<FrameState> {
  FrameNotifier(this._repository) : super(FrameState.initial());

  final FrameRepository _repository;

  void changeFillInitial() {
    state = FrameState.initial();
  }

  Future<void> getFrameList({required int idSPK}) async {
    final Either<RemoteFailure, List<Frame>> FOS;

    state = state.copyWith(isProcessing: true, FOSOFrame: none());

    FOS = await _repository.getFrameList(idSPK: idSPK);

    state = state.copyWith(isProcessing: false, FOSOFrame: optionOf(FOS));
  }

  Future<void> getFrameListByPage({required int page}) async {
    final Either<RemoteFailure, List<Frame>> FOS;

    state = state.copyWith(isProcessing: true, FOSOFrame: none());

    FOS = await _repository.getFrameListByPage(page: page);

    state = state.copyWith(isProcessing: false, FOSOFrame: optionOf(FOS));
  }

  Future<Frame> getFrameByName({required String frame}) async {
    state = state.copyWith(isProcessing: true);

    final _frame = await _repository.getFrameByName(frame: frame);

    state = state.copyWith(isProcessing: false);

    return _frame;
  }

  Future<void> searchFrameListWithoutSPK({required String frame}) async {
    final Either<RemoteFailure, List<Frame>> FOS;

    state = state.copyWith(
      isProcessing: true,
      FOSOFrame: none(),
    );

    FOS = await _repository.searchFrameListWithoutSPK(search: frame);

    state = state.copyWith(
      isProcessing: false,
      FOSOFrame: optionOf(FOS),
    );
  }

  Future<void> searchFrameListOFFLINE(
      {required String idSPK, required String frame}) async {
    final Either<RemoteFailure, List<Frame>> FOS;

    state = state.copyWith(isProcessing: true, FOSOFrame: none());

    FOS = await _repository.searchFrameListOFFLINE(idSPK: idSPK, search: frame);

    state = state.copyWith(isProcessing: false, FOSOFrame: optionOf(FOS));
  }

  Future<void> getFrameListOFFLINE({required int idSPK}) async {
    final Either<RemoteFailure, List<Frame>> FOS;

    state = state.copyWith(isProcessing: true, FOSOFrame: none());

    FOS = await _repository.getFrameListOFFLINE(idSPK: idSPK);

    state = state.copyWith(isProcessing: false, FOSOFrame: optionOf(FOS));
  }

  Future<void> getFrameListOFFLINEByPage({required int page}) async {
    final Either<RemoteFailure, List<Frame>> FOS;

    state = state.copyWith(isProcessing: true, FOSOFrame: none());

    FOS = await _repository.getFrameListOFFLINEByPage(page: page);

    state = state.copyWith(isProcessing: false, FOSOFrame: optionOf(FOS));
  }

  void changeFrameList(List<Frame> frameList) {
    state = state.copyWith(frameList: [...frameList]);
  }

  void addFrameList(List<Frame> frameList) {
    state = state.copyWith(frameList: [
      ...state.frameList,
      ...frameList,
    ]);
  }

  void changeFillEmptyFOSOSaveFrameList({required int length}) {
    Either<LocalFailure, Unit>? FOS;

    final generateList = List.generate(length, (index) => optionOf(FOS));

    state = state.copyWith(FOSOSaveFrame: generateList);
  }

  void resetFOSOSaveFrame() {
    state = state.copyWith(FOSOSaveFrame: []);
  }

  List<Option<Either<LocalFailure, Unit>>> isFOSONotOK() {
    List<Option<Either<LocalFailure, Unit>>> list = [...state.FOSOSaveFrame];

    List<Option<Either<LocalFailure, Unit>>> NotOKFOSO = [];

    list.forEach((element) {
      element.fold(
          () => NotOKFOSO.add(element),
          (either) => either.fold(
                (_) => NotOKFOSO.add(element),
                (_) {},
              ));
    });

    return NotOKFOSO;
  }

  bool isLastFOSO({required int index}) {
    List<Option<Either<LocalFailure, Unit>>> list = [...state.FOSOSaveFrame];

    int lastIndex = list.length - 1;

    if (index == lastIndex) return true;

    return false;
  }
}
