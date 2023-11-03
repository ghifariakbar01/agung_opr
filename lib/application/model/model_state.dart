import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/remote_failure.dart';
import 'model.dart';

part 'model_state.freezed.dart';

@freezed
class ModelState with _$ModelState {
  const factory ModelState({
    required int page,
    required bool hasMore,
    required int idSelected,
    required bool isProcessing,
    required List<Model> modelList,
    required List<Model> modelListSaved,
    required Option<Either<RemoteFailure, List<Model>>> FOSOModel,
  }) = _ModelState;

  factory ModelState.initial() => ModelState(
        page: 0,
        idSelected: 0,
        hasMore: true,
        modelList: [],
        FOSOModel: none(),
        modelListSaved: [],
        isProcessing: false,
      );
}
