import 'dart:developer';

import 'package:agung_opr/application/model/model.dart';
import 'package:agung_opr/domain/remote_failure.dart';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/model/model_repository.dart';
import 'model_state.dart';

class ModelNotifier extends StateNotifier<ModelState> {
  ModelNotifier(this._repository) : super(ModelState.initial());

  final ModelRepository _repository;

  Future<List<Model>> initModelListOFFLINE({required int limit}) async {
    final List<Model> list = [];

    state = state.copyWith(isProcessing: true);

    for (int i = 0; i < limit; i++) {
      final Either<RemoteFailure, List<Model>> FOS;

      FOS = await _repository.getModelListOFFLINE(page: i);

      optionOf(FOS).fold(
          () {},
          (FOSE) => FOSE.fold(
              (error) => log('ERROR initModelListOFFLINE: $error'),
              (response) => list.addAll(response)));
    }

    state = state.copyWith(isProcessing: false);

    return list;
  }

  Future<void> getModelList({required int page}) async {
    final Either<RemoteFailure, List<Model>> FOS;

    state = state.copyWith(isProcessing: true, FOSOModel: none());

    FOS = await _repository.getModelList(page: page);

    state = state.copyWith(isProcessing: false, FOSOModel: optionOf(FOS));
  }

  Future<void> searchModelList(
      {required String search, required bool includeParts}) async {
    final Either<RemoteFailure, List<Model>> FOS;

    state = state.copyWith(isProcessing: true, FOSOModel: none());

    FOS = await _repository.searchModelList(
        search: search, includeParts: includeParts);

    state = state.copyWith(isProcessing: false, FOSOModel: optionOf(FOS));
  }

  Future<void> getAndChangeModelListOFFLINE() async {
    state = state.copyWith(isProcessing: true);

    final list = await _repository
        .getModelListOFFLINE(allModel: true)
        .then((value) => value.fold((_) => [] as List<Model>, (r) => r));

    state = state.copyWith(isProcessing: false, modelListSaved: list);
  }

  Future<void> getModelListOFFLINE({required int page}) async {
    final Either<RemoteFailure, List<Model>> FOS;

    state = state.copyWith(isProcessing: true, FOSOModel: none());

    FOS = await _repository.getModelListOFFLINE(page: page);

    state = state.copyWith(isProcessing: false, FOSOModel: optionOf(FOS));
  }

  Future<void> searchModelListOFFLINE(
      {required String search, required bool includeParts}) async {
    final Either<RemoteFailure, List<Model>> FOS;

    state = state.copyWith(isProcessing: true, FOSOModel: none());

    FOS = await _repository.searchModelListOFFLINE(
        search: search, includeParts: includeParts);

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

  void changeModelListOffline({required List<Model> model}) {
    state = state.copyWith(modelListSaved: [...model]);
  }

  void processModelList(
      {required List<Model> newModel,
      required Function changeModel,
      required Function replaceModel,
      required Function changeIsMore,
      required int page}) {
    final pageIsZero = page == 0;
    final modelEmpty = newModel.isEmpty;

    if (!pageIsZero) {
      changeModel();
    } else if (!pageIsZero && modelEmpty) {
      changeIsMore();
    } else if (pageIsZero) {
      replaceModel();
    } else if (pageIsZero && modelEmpty) {
      return;
    }
  }
}
