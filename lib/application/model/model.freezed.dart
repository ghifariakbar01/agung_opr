// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Model _$ModelFromJson(Map<String, dynamic> json) {
  return _Model.fromJson(json);
}

/// @nodoc
mixin _$Model {
  int get id => throw _privateConstructorUsedError;
  String? get merk => throw _privateConstructorUsedError;
  String? get nama => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  double? get grossweight => throw _privateConstructorUsedError;
  double? get measurement => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ModelCopyWith<Model> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelCopyWith<$Res> {
  factory $ModelCopyWith(Model value, $Res Function(Model) then) =
      _$ModelCopyWithImpl<$Res, Model>;
  @useResult
  $Res call(
      {int id,
      String? merk,
      String? nama,
      String? category,
      double? grossweight,
      double? measurement});
}

/// @nodoc
class _$ModelCopyWithImpl<$Res, $Val extends Model>
    implements $ModelCopyWith<$Res> {
  _$ModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? merk = freezed,
    Object? nama = freezed,
    Object? category = freezed,
    Object? grossweight = freezed,
    Object? measurement = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      merk: freezed == merk
          ? _value.merk
          : merk // ignore: cast_nullable_to_non_nullable
              as String?,
      nama: freezed == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      grossweight: freezed == grossweight
          ? _value.grossweight
          : grossweight // ignore: cast_nullable_to_non_nullable
              as double?,
      measurement: freezed == measurement
          ? _value.measurement
          : measurement // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ModelCopyWith<$Res> implements $ModelCopyWith<$Res> {
  factory _$$_ModelCopyWith(_$_Model value, $Res Function(_$_Model) then) =
      __$$_ModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? merk,
      String? nama,
      String? category,
      double? grossweight,
      double? measurement});
}

/// @nodoc
class __$$_ModelCopyWithImpl<$Res> extends _$ModelCopyWithImpl<$Res, _$_Model>
    implements _$$_ModelCopyWith<$Res> {
  __$$_ModelCopyWithImpl(_$_Model _value, $Res Function(_$_Model) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? merk = freezed,
    Object? nama = freezed,
    Object? category = freezed,
    Object? grossweight = freezed,
    Object? measurement = freezed,
  }) {
    return _then(_$_Model(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      merk: freezed == merk
          ? _value.merk
          : merk // ignore: cast_nullable_to_non_nullable
              as String?,
      nama: freezed == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      grossweight: freezed == grossweight
          ? _value.grossweight
          : grossweight // ignore: cast_nullable_to_non_nullable
              as double?,
      measurement: freezed == measurement
          ? _value.measurement
          : measurement // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Model implements _Model {
  const _$_Model(
      {required this.id,
      required this.merk,
      required this.nama,
      required this.category,
      required this.grossweight,
      required this.measurement});

  factory _$_Model.fromJson(Map<String, dynamic> json) =>
      _$$_ModelFromJson(json);

  @override
  final int id;
  @override
  final String? merk;
  @override
  final String? nama;
  @override
  final String? category;
  @override
  final double? grossweight;
  @override
  final double? measurement;

  @override
  String toString() {
    return 'Model(id: $id, merk: $merk, nama: $nama, category: $category, grossweight: $grossweight, measurement: $measurement)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Model &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.merk, merk) || other.merk == merk) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.grossweight, grossweight) ||
                other.grossweight == grossweight) &&
            (identical(other.measurement, measurement) ||
                other.measurement == measurement));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, merk, nama, category, grossweight, measurement);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ModelCopyWith<_$_Model> get copyWith =>
      __$$_ModelCopyWithImpl<_$_Model>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ModelToJson(
      this,
    );
  }
}

abstract class _Model implements Model {
  const factory _Model(
      {required final int id,
      required final String? merk,
      required final String? nama,
      required final String? category,
      required final double? grossweight,
      required final double? measurement}) = _$_Model;

  factory _Model.fromJson(Map<String, dynamic> json) = _$_Model.fromJson;

  @override
  int get id;
  @override
  String? get merk;
  @override
  String? get nama;
  @override
  String? get category;
  @override
  double? get grossweight;
  @override
  double? get measurement;
  @override
  @JsonKey(ignore: true)
  _$$_ModelCopyWith<_$_Model> get copyWith =>
      throw _privateConstructorUsedError;
}
