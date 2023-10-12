import 'dart:developer';

import 'package:agung_opr/infrastructure/sort_data/sort_data_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/remote_failure.dart';
import 'sort_data_state.dart';

class SortDataNotifier extends StateNotifier<SortDataState> {
  SortDataNotifier(this._repository) : super(SortDataState.initial());

  final SortDataRepository _repository;

  Future<void> sortData() async {
    Either<RemoteFailure, Unit>? FOS;

    state = state.copyWith(
      isGetting: true,
    );

    FOS = await _repository.sortDataSPK();

    state = state.copyWith(isGetting: false, FOSOSPKSortData: optionOf(FOS));
  }
}
