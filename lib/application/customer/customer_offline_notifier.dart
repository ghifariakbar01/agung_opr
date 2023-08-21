import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/customer/customer_repository.dart';
import 'customer_offline_state.dart';

class CustomerOfflineNotifier extends StateNotifier<CustomerOfflineState> {
  CustomerOfflineNotifier(this._repository)
      : super(CustomerOfflineState.initial());

  final CustomerRepository _repository;

  Future<void> checkAndUpdateCustomerOFFLINEStatus() async {
    final isOfffline = await _repository.hasOfflineData();

    if (isOfffline) {
      state = const CustomerOfflineState.hasOfflineStorage();
    } else {
      state = const CustomerOfflineState.empty();
    }
  }
}
