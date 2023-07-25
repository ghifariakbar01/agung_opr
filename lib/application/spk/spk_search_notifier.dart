import 'package:agung_opr/application/spk/spk_search_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SPKSearchNotifier extends StateNotifier<SPKSearchState> {
  SPKSearchNotifier() : super(SPKSearchState.initial());

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
