import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/remote_failure.dart';
import '../spk/spk.dart';

part 'auto_data_state.freezed.dart';

@freezed
class AutoDataState with _$AutoDataState {
  const factory AutoDataState({
    required bool isGetting,
    required Option<Either<RemoteFailure, List<SPK>>> FOSOSPKAutoData,
  }) = _AutoDataState;

  factory AutoDataState.initial() =>
      AutoDataState(isGetting: false, FOSOSPKAutoData: none());
}
