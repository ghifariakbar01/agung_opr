import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/remote_failure.dart';

part 'sort_data_state.freezed.dart';

@freezed
class SortDataState with _$SortDataState {
  const factory SortDataState({
    required bool isGetting,
    required Option<Either<RemoteFailure, Unit>> FOSOSPKSortData,
  }) = _SortDataState;

  factory SortDataState.initial() =>
      SortDataState(isGetting: false, FOSOSPKSortData: none());
}
