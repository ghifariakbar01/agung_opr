import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'gate_search_state.dart';

class GateSearchNotifier extends StateNotifier<GateSearchState> {
  GateSearchNotifier() : super(GateSearchState.initial());

  void changeIsSearch(bool isSearching) {
    state = state.copyWith(isSearching: isSearching);
  }

  void changeSearchText(String searchText) {
    state = state.copyWith(searchText: searchText);
  }
}
