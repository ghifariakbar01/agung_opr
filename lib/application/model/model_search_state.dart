import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_search_state.freezed.dart';

@freezed
class ModelSearchState with _$ModelSearchState {
  const factory ModelSearchState(
      {required bool isSearching,
      required String searchText}) = _SPKSearchState;

  factory ModelSearchState.initial() =>
      ModelSearchState(isSearching: false, searchText: '');
}
