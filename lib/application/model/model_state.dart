import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/remote_failure.dart';
import 'model.dart';

part 'model_state.freezed.dart';

@freezed
class ModelState with _$ModelState {
  const factory ModelState({
    required List<Model> modelList,
    required int idSelected,
    required int page,
    required bool hasMore,
    required bool isProcessing,
    required Option<Either<RemoteFailure, List<Model>>> FOSOModel,
  }) = _ModelState;

  factory ModelState.initial() => ModelState(
      modelList: [],
      idSelected: 0,
      page: 0,
      hasMore: true,
      isProcessing: false,
      FOSOModel: none());
}
