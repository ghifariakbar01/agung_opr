import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure/cs/cs_repository.dart';
import 'state/cs_jenis.dart';
import 'state/cs_jenis_state.dart';

class CheckSheetJenisNotifier extends StateNotifier<CSJenisState> {
  CheckSheetJenisNotifier(this._repository) : super(CSJenisState.initial());

  final CSRepository _repository;

  Future<void> getCSJenis() async {
    final Either<RemoteFailure, List<CSJenis>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCSJenis: none());

    FOS = await _repository.getCSJenis();

    state = state.copyWith(isProcessing: false, FOSOCSJenis: optionOf(FOS));
  }

  Future<void> getCSJenisOFFLINE() async {
    final Either<RemoteFailure, List<CSJenis>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCSJenis: none());

    FOS = await _repository.getCSJenisOFFLINE();

    state = state.copyWith(isProcessing: false, FOSOCSJenis: optionOf(FOS));
  }

  void changeCSJenisList(List<CSJenis> csJenisList) {
    state = state.copyWith(csJenisList: [...csJenisList]);
  }
}
