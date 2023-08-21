import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/local_failure.dart';
import '../../domain/remote_failure.dart';
import 'customer.dart';

part 'customer_state.freezed.dart';

@freezed
class CustomerState with _$CustomerState {
  const factory CustomerState({
    required List<Customer> customerList,
    required int idSelected,
    required int page,
    required bool hasMore,
    required bool isProcessing,
    required Option<Either<RemoteFailure, List<Customer>>> FOSOCustomer,
    required Option<Either<LocalFailure, Customer>> FOSOInsertCustomer,
  }) = _CustomerState;

  factory CustomerState.initial() => CustomerState(
      customerList: [],
      idSelected: 0,
      page: 0,
      hasMore: true,
      isProcessing: false,
      FOSOCustomer: none(),
      FOSOInsertCustomer: none());
}
