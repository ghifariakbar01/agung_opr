import 'package:agung_opr/application/customer/customer_search_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure/cache_storage/customer_storage.dart';
import '../../../infrastructure/credentials_storage.dart';
import '../../../infrastructure/customer/customer_remote_service.dart';
import '../../../infrastructure/customer/customer_repository.dart';
import '../../../shared/providers.dart';
import '../customer_notifier.dart';
import '../customer_offline_notifier.dart';
import '../customer_offline_state.dart';
import '../customer_search_notifier.dart';
import '../customer_state.dart';

final customerStorage = Provider<CredentialsStorage>(
  (ref) => CustomerStorage(ref.watch(flutterSecureStorageProvider)),
);

final customerRemoteServiceProvider = Provider(
  (ref) => CustomerRemoteService(
      ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final customerRepositoryProvider = Provider((ref) => CustomerRepository(
    ref.watch(customerRemoteServiceProvider), ref.watch(customerStorage)));

final customerNotifierProvider =
    StateNotifierProvider<CustomerNotifier, CustomerState>(
  (ref) => CustomerNotifier(ref.watch(customerRepositoryProvider)),
);

final customerOfflineNotifierProvider =
    StateNotifierProvider<CustomerOfflineNotifier, CustomerOfflineState>(
        (ref) =>
            CustomerOfflineNotifier(ref.watch(customerRepositoryProvider)));

final customerSearchNotifierProvider =
    StateNotifierProvider<CustomerSearchNotifier, CustomerSearchState>(
        (ref) => CustomerSearchNotifier());
