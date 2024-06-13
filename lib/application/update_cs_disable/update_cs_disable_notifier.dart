import 'package:agung_opr/application/update_cs_disable/disable.dart';
import 'package:agung_opr/infrastructure/exceptions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../check_sheet/shared/providers/cs_providers.dart';

part 'update_cs_disable_notifier.g.dart';

@riverpod
class UpdateCsDisableNotifier extends _$UpdateCsDisableNotifier {
  @override
  FutureOr<UpdateCsDisable> build() async {
    return UpdateCsDisable.inital();
  }

  Future<void> getDisabled({
    required int idSPK,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () async {
        try {
          return ref.read(csJenisRepositoryProvider).getCsDone(idSPK: idSPK);
        } on NoConnectionException {
          return UpdateCsDisable.offline();
        }
      },
    );
  }
}
