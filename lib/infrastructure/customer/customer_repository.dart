import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/infrastructure/customer/customer_remote_service.dart';
import 'package:collection/collection.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/customer/customer.dart';
import '../../domain/local_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';

class CustomerRepository {
  CustomerRepository(
    this._remoteService,
    this._storage,
  );

  final CustomerRemoteService _remoteService;
  final CredentialsStorage _storage;

  Future<bool> hasOfflineData() => getStorageCondition()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<Customer>>> searchCustomerList(
      {required String search}) async {
    try {
      final customerList =
          await _remoteService.searchCustomerList(search: search);

      await _add(item: customerList);

      return right(customerList);
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException {
      return left(RemoteFailure.parse());
    } on PlatformException {
      return left(RemoteFailure.storage());
    }
  }

  /// ADD [Customer] FROM SEARCH
  ///
  Future<Unit> _add({required List<Customer> item}) async {
    final itemStorage = await _storage.read();

    if (itemStorage != null) {
      final response = jsonDecode(itemStorage) as List<dynamic>;

      final responseItem = Customer.CustomerListFromJson(response);

      if (responseItem.isNotEmpty) {
        final responseItemTosave = [...responseItem, ...item].toSet().toList();

        final listResponseItemToSave =
            Customer.CustomerListToJson(responseItemTosave);

        await _storage.save(listResponseItemToSave);
      }
    }

    return unit;
  }

  Future<Either<RemoteFailure, List<Customer>>> getCustomerList(
      {required int page}) async {
    try {
      final customerList = await _remoteService.getCustomerList(page: page);

      await _storage.save(jsonEncode(customerList));

      return right(customerList);
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException {
      return left(RemoteFailure.parse());
    } on PlatformException {
      return left(RemoteFailure.storage());
    }
  }

  /// PAGINATE DATA LIST OF [Customer] FROM STORAGE
  ///
  /// process [page] and divide LIST OF [Customer]
  Future<Either<RemoteFailure, List<Customer>>> getCustomerListOFFLINE(
      {required int page}) async {
    try {
      final customerStorage = await _storage.read();

      log('CUSTOMER STORAGE: $customerStorage');

      // HAS LIST
      if (customerStorage != null) {
        // final _getTotalPages = (modelList.length / itemsPerPage).ceil();

        final response = jsonDecode(customerStorage);

        // START PAGINATION

        final int itemsPerPage = 20;

        int _startIndex = page * itemsPerPage;

        List<Customer> modelList =
            (response as List).map((data) => Customer.fromJson(data)).toList();

        final _endIndex = (_startIndex + itemsPerPage) <= modelList.length
            ? (_startIndex + itemsPerPage)
            : modelList.length;

        List<Customer> customerPage = modelList.sublist(_startIndex, _endIndex);

        // END PAGINATION

        log('customerPage $customerPage');

        return right(customerPage);
      } else {
        log('customerPage empty ');

        return right([]);
      }
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException {
      return left(RemoteFailure.parse());
    }
  }

  /// INSERT customer
  ///
  ///
  Future<Either<LocalFailure, Customer>> insertCustomerOFFLINE(
      {required Customer customer}) async {
    try {
      final customerStorage = await _storage.read();

      log('CUSTOMER STORAGE: $customerStorage');

      // HAS LIST
      if (customerStorage != null) {
        final response = jsonDecode(customerStorage);

        List<Customer> customerList =
            (response as List).map((data) => Customer.fromJson(data)).toList();

        final customerInList = customerList.firstWhere(
          (element) => element == customer,
          orElse: () => customer,
        );

        final list = [
          ...customerList.whereNot((element) => element == customerInList),
          customerInList
        ];

        await _storage.save(jsonEncode(list));

        return right(customer);
      } else {
        log('customerPage empty ');

        return right(customer);
      }
    } on PlatformException {
      return left(LocalFailure.storage());
    } on FormatException {
      return left(LocalFailure.format());
    }
  }

  /// SEARCH BY [ID] , [TITLE], [NAMA]
  Future<Either<RemoteFailure, List<Customer>>> searchCustomerListOFFLINE(
      {required String search}) async {
    try {
      final customerStorage = await _storage.read();

      final searchLowerCase = search.toLowerCase();

      log('CUSTOMER STORAGE: $customerStorage');

      // HAS LIST
      if (customerStorage != null) {
        final response = jsonDecode(customerStorage);

        List<Customer> customerList =
            (response as List).map((data) => Customer.fromJson(data)).toList();

        final searchedList = customerList.where((customer) {
          return customer.id.toString() == searchLowerCase ||
              customer.nama?.toLowerCase() == searchLowerCase;
        }).toList();

        return right(searchedList);
      } else {
        return right([]);
      }
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException {
      return left(RemoteFailure.parse());
    }
  }

  Future<Either<LocalFailure, String?>> getStorageCondition() async {
    try {
      final storedCredentials = await _storage.read();

      if (storedCredentials == null) {
        return left(LocalFailure.empty());
      }

      return right(storedCredentials);
    } on FormatException {
      return left(LocalFailure.format('Error while parsing'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  Future<Unit> clearCustomerStorage() async {
    final storedCredentials = await _storage.read();

    if (storedCredentials == null) {
      return unit;
    }

    await _storage.clear();

    return unit;
  }
}
