import 'package:freezed_annotation/freezed_annotation.dart';

part 'supir.freezed.dart';

part 'supir.g.dart';

@freezed
class Supir with _$Supir {
  const factory Supir(
      {required int id,
      required String? nama,
      required String? phone,
      required String? alamat,
      required String? kategori}) = _Supir;

  factory Supir.fromJson(Map<String, Object?> json) => _$SupirFromJson(json);
}
