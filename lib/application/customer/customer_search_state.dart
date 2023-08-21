import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_search_state.freezed.dart';

@freezed
class CustomerSearchState with _$CustomerSearchState {
  const factory CustomerSearchState(
      {required bool isSearching,
      required String searchText}) = _CustomerSearchState;

  factory CustomerSearchState.initial() =>
      CustomerSearchState(isSearching: false, searchText: '');
}
