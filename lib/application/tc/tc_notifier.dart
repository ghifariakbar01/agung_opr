import 'package:agung_opr/application/tc/tc_repository.dart';
import 'package:agung_opr/application/tc/tc_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TCNotifier extends StateNotifier<TCState> {
  TCNotifier(this._repository) : super(TCState.initial());

  final TCRepository _repository;

  Future<void> checkAndUpdateStatusTC() async {
    final tcStatus = await _repository.getSaved();

    if (tcStatus == null) {
      state = TCState.initial();
    } else {
      state = TCState.visited();
    }
  }

  Future<void> saveVisitedTC(String visited) async {
    await _repository.save(visited);
  }
}
