import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'supir_search_state.dart';

class SupirSearchNotifier extends StateNotifier<SupirSearchState> {
  SupirSearchNotifier() : super(SupirSearchState.initial());

  void changeIsSearch(bool isSearching) {
    state = state.copyWith(isSearching: isSearching);
  }

  void changeSearchText(String searchText) {
    state = state.copyWith(searchText: searchText);
  }

  String extractNumbers(String input) {
    // Regular expression to extract the numbers before and after the hyphen
    RegExp regex = RegExp(r'\d+(?=-)|(?<=-)\d+');
    return regex.allMatches(input).map((match) => match.group(0)).join();
  }
}
