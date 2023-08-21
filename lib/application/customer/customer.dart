import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';

part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  const factory Customer({
    required int id,
    required String? title,
    required String? nama,
  }) = _Customer;

  factory Customer.initial() => Customer(id: 0, title: '', nama: '');

  factory Customer.fromJson(Map<String, Object?> json) =>
      _$CustomerFromJson(json);
}
