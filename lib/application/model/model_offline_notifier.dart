import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/model/model_repository.dart';
import 'model_offline_state.dart';

class ModelOfflineNotifier extends StateNotifier<ModelOfflineState> {
  ModelOfflineNotifier(this._repository) : super(ModelOfflineState.initial());

  final ModelRepository _repository;

  Future<void> checkAndUpdateModelOFFLINEStatus() async {
    final isOfffline = await _repository.hasOfflineData();

    if (isOfffline) {
      state = const ModelOfflineState.hasOfflineStorage();
    } else {
      state = const ModelOfflineState.empty();
    }
  }
}
