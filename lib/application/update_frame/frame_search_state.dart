import 'package:freezed_annotation/freezed_annotation.dart';

part 'frame_search_state.freezed.dart';

@freezed
class FrameSearchState with _$FrameSearchState {
  const factory FrameSearchState(
      {required bool isSearching,
      required String searchText}) = _SPKSearchState;

  factory FrameSearchState.initial() =>
      FrameSearchState(isSearching: false, searchText: '');
}
