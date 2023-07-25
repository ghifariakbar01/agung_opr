import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/remote_failure.dart';
import 'spk.dart';

part 'spk_state.freezed.dart';

@freezed
class SPKState with _$SPKState {
  const factory SPKState({
    required List<SPK> spkList,
    required int page,
    required bool hasMore,
    required bool isProcessing,
    required Option<Either<RemoteFailure, List<SPK>>> FOSOSPK,
  }) = _SPKState;

  factory SPKState.initial() => SPKState(
      spkList: [],
      page: 0,
      hasMore: true,
      isProcessing: false,
      FOSOSPK: none());
}
