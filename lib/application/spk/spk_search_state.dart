import 'package:freezed_annotation/freezed_annotation.dart';

part 'spk_search_state.freezed.dart';

@freezed
class SPKSearchState with _$SPKSearchState {
  const factory SPKSearchState(
      {required bool isSearching,
      required String searchText}) = _SPKSearchState;

  factory SPKSearchState.initial() =>
      SPKSearchState(isSearching: false, searchText: '');
}
