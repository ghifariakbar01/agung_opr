import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'supir_search_state.freezed.dart';

@freezed
class SupirSearchState with _$SupirSearchState {
  const factory SupirSearchState({
    required bool isSearching,
    required String searchText,
    required FocusNode focusNode,
  }) = _SPKSearchState;

  factory SupirSearchState.initial() => SupirSearchState(
      isSearching: false, searchText: '', focusNode: FocusNode());
}
