import 'package:agung_opr/application/customer/customer.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/infrastructure/customer/customer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'customer_state.dart';

class CustomerNotifier extends StateNotifier<CustomerState> {
  CustomerNotifier(this._repository) : super(CustomerState.initial());

  final CustomerRepository _repository;

  Future<void> insertCustomer({required Customer customer}) async {
    final Either<LocalFailure, Customer> FOS;

    state = state.copyWith(isProcessing: true, FOSOInsertCustomer: none());

    FOS = await _repository.insertCustomerOFFLINE(customer: customer);

    state =
        state.copyWith(isProcessing: false, FOSOInsertCustomer: optionOf(FOS));
  }

  Future<void> getCustomerList({required int page}) async {
    final Either<RemoteFailure, List<Customer>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCustomer: none());

    FOS = await _repository.getCustomerList(page: page);

    state = state.copyWith(isProcessing: false, FOSOCustomer: optionOf(FOS));
  }

  Future<void> getCustomerListOFFLINE({required int page}) async {
    final Either<RemoteFailure, List<Customer>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCustomer: none());

    FOS = await _repository.getCustomerListOFFLINE(page: page);

    state = state.copyWith(isProcessing: false, FOSOCustomer: optionOf(FOS));
  }

  Future<void> searchCustomerList({required String search}) async {
    final Either<RemoteFailure, List<Customer>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCustomer: none());

    FOS = await _repository.searchCustomerList(search: search);

    state = state.copyWith(isProcessing: false, FOSOCustomer: optionOf(FOS));
  }

  Future<void> searchCustomerListOFFLINE({required String search}) async {
    final Either<RemoteFailure, List<Customer>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCustomer: none());

    FOS = await _repository.searchCustomerListOFFLINE(search: search);

    state = state.copyWith(isProcessing: false, FOSOCustomer: optionOf(FOS));
  }

  void changeSelectedId(int idSelected) {
    state = state.copyWith(idSelected: idSelected);
  }

  void changeIsMore(bool hasMore) {
    state = state.copyWith(hasMore: hasMore);
  }

  void changePage(int page) {
    state = state.copyWith(page: page);
  }

  void replaceCustomerList(List<Customer> customerList) {
    state = state.copyWith(customerList: [...customerList]);
  }

  void changeCustomerList(
      {required List<Customer> newCustomer,
      required List<Customer> oldCustomer}) {
    state = state.copyWith(customerList: [...oldCustomer, ...newCustomer]);
  }

  void processModelList(
      {required List<Customer> newCustomer,
      required Function changeModel,
      required Function replaceModel,
      required Function changeIsMore,
      required int page}) {
    final pageIsZero = page == 0;
    final customerIsEmpty = newCustomer.isEmpty;

    if (!pageIsZero && !customerIsEmpty) {
      changeModel();
    } else if (!pageIsZero && customerIsEmpty) {
      changeIsMore();
    } else if (pageIsZero && !customerIsEmpty) {
      replaceModel();
    } else if (pageIsZero && customerIsEmpty) {
      return;
    }
  }
}
