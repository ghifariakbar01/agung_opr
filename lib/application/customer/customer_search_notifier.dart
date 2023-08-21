import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'customer_search_state.dart';

class CustomerSearchNotifier extends StateNotifier<CustomerSearchState> {
  CustomerSearchNotifier() : super(CustomerSearchState.initial());

  void changeIsSearch(bool isSearching) {
    state = state.copyWith(isSearching: isSearching);
  }

  void changeSearchText(String searchText) {
    state = state.copyWith(searchText: searchText);
  }
}
