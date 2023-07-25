import 'package:agung_opr/application/model/model.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/model/model_repository.dart';
import 'model_state.dart';

class ModelNotifier extends StateNotifier<ModelState> {
  ModelNotifier(this._repository) : super(ModelState.initial());

  final ModelRepository _repository;

  Future<void> getModelList({required int page}) async {
    final Either<RemoteFailure, List<Model>> FOS;

    state = state.copyWith(isProcessing: true, FOSOModel: none());

    FOS = await _repository.getModelListOFFLINE(page: page);

    state = state.copyWith(isProcessing: false, FOSOModel: optionOf(FOS));
  }

  Future<void> getModelListOFFLINE({required int page}) async {
    final Either<RemoteFailure, List<Model>> FOS;

    state = state.copyWith(isProcessing: true, FOSOModel: none());

    FOS = await _repository.getModelListOFFLINE(page: page);

    state = state.copyWith(isProcessing: false, FOSOModel: optionOf(FOS));
  }

  Future<void> searchModelListOFFLINE({required String search}) async {
    final Either<RemoteFailure, List<Model>> FOS;

    state = state.copyWith(isProcessing: true, FOSOModel: none());

    FOS = await _repository.searchModelListOFFLINE(search: search);

    state = state.copyWith(isProcessing: false, FOSOModel: optionOf(FOS));
  }

  void changeSelectedId(int idSelected) {
    state = state.copyWith(idSelected: idSelected);
  }

  void changeIsMore(bool hasMore) {
    state = state.copyWith(hasMore: hasMore);
  }

  void changePage(int page) {
    state = state.copyWith(page: page);
  }

  void replaceModelList(List<Model> modelList) {
    state = state.copyWith(modelList: [...modelList]);
  }

  void changeModelList(
      {required List<Model> newModel, required List<Model> oldModel}) {
    state = state.copyWith(modelList: [...oldModel, ...newModel]);
  }

  void processModelList(
      {required List<Model> newModel,
      required Function changeModel,
      required Function replaceModel,
      required Function changeIsMore,
      required int page}) {
    final pageIsZero = page == 0;
    final ModelEmpty = newModel.isEmpty;

    if (!pageIsZero && !ModelEmpty) {
      changeModel();
    } else if (!pageIsZero && ModelEmpty) {
      changeIsMore();
    } else if (pageIsZero && !ModelEmpty) {
      replaceModel();
    } else if (pageIsZero && ModelEmpty) {
      return;
    }
  }
}
