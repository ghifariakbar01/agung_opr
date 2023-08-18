import 'package:agung_opr/application/update_frame/frame_search_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FrameSearchNotifier extends StateNotifier<FrameSearchState> {
  FrameSearchNotifier() : super(FrameSearchState.initial());

  void changeIsSearch(bool isSearching) {
    state = state.copyWith(isSearching: isSearching);
  }

  void changeSearchText(String searchText) {
    state = state.copyWith(searchText: searchText);
  }
}
