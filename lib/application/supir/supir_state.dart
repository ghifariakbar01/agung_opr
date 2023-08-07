import 'package:agung_opr/application/supir/supir.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/remote_failure.dart';

part 'supir_state.freezed.dart';

@freezed
class SupirState with _$SupirState {
  const factory SupirState({
    required List<Supir> supirList,
    required int idSelected,
    required int page,
    required bool hasMore,
    required bool isProcessing,
    required Option<Either<RemoteFailure, List<Supir>>> FOSOSupir,
  }) = _SupirState;

  factory SupirState.initial() => SupirState(
      supirList: [],
      idSelected: 0,
      page: 0,
      hasMore: true,
      isProcessing: false,
      FOSOSupir: none());
}
