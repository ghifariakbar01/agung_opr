import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';

part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  const factory Customer({
    required int id,
    required String? nama,
  }) = _Customer;

  factory Customer.initial() => Customer(id: 0, nama: '');

  factory Customer.fromJson(Map<String, Object?> json) =>
      _$CustomerFromJson(json);

  static List<Customer> CustomerListFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => Customer.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String CustomerListToJson(List<Customer> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
