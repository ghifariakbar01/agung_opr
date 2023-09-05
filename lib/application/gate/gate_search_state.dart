import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gate_search_state.freezed.dart';

@freezed
class GateSearchState with _$GateSearchState {
  const factory GateSearchState(
      {required bool isSearching,
      required String searchText,
      required FocusNode focusNode}) = _SPKSearchState;

  factory GateSearchState.initial() => GateSearchState(
      isSearching: false, searchText: '', focusNode: FocusNode());
}
