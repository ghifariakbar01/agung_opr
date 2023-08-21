import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

part 'model.g.dart';

@freezed
class Model with _$Model {
  const factory Model(
      {required int id,
      required String? merk,
      required String? nama,
      required String? category,
      required double? grossweight,
      required double? measurement}) = _Model;

  factory Model.initial() => Model(
      id: 0, merk: '', nama: '', category: '', grossweight: 0, measurement: 0);

  factory Model.fromJson(Map<String, Object?> json) => _$ModelFromJson(json);
}
