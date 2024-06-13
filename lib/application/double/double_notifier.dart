import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../infrastructure/cache_storage/double_storage.dart';
import '../../infrastructure/double_repository/double_repository.dart';
import '../../shared/providers.dart';
import 'double.dart';

part 'double_notifier.g.dart';

@Riverpod(keepAlive: true)
DoubleStorage doubleStorage(DoubleStorageRef ref) {
  return DoubleStorage(
    ref.watch(flutterSecureStorageProvider),
  );
}

// final doubleStorageProvider = Provider<CredentialsStorage>(
//   (ref) => DoubleStorage(
//     ref.watch(flutterSecureStorageProvider),
//   ),
// );

@Riverpod(keepAlive: true)
DoubleRepository doubleRepository(DoubleRepositoryRef ref) {
  return DoubleRepository(
    ref.watch(doubleStorageProvider),
  );
}

@riverpod
class DoubleNotifier extends _$DoubleNotifier {
  @override
  FutureOr<List<SPKDouble>> build() async {
    return ref.read(doubleRepositoryProvider).get();
  }

  Future<void> refresh(SPKDouble double) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return ref.read(doubleRepositoryProvider).get();
    });
  }

  Future<void> get(SPKDouble double) async {
    ref.read(doubleRepositoryProvider).get();
  }
}

@riverpod
class DoubleController extends _$DoubleController {
  @override
  FutureOr<void> build() async {}

  Future<void> save(SPKDouble double) async {
    state = const AsyncLoading();

    try {
      await ref.read(doubleRepositoryProvider).save(double);
      state = AsyncValue.data('Sukses Save');
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> clear() async {
    state = const AsyncLoading();

    try {
      await ref.read(doubleRepositoryProvider).clear();
      state = AsyncValue.data('Sukses Clear');
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  // Future<void> removeAt(SPKDouble double) async {
  //   state = const AsyncLoading();

  //   try {
  //     await ref.read(doubleRepositoryProvider).removeAt(double);
  //     state = AsyncValue.data('Sukses Delete');
  //   } catch (e) {
  //     state = AsyncError(e, StackTrace.current);
  //   }
  // }
}
