// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supir.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Supir _$SupirFromJson(Map<String, dynamic> json) {
  return _Supir.fromJson(json);
}

/// @nodoc
mixin _$Supir {
  int get id => throw _privateConstructorUsedError;
  String? get nama => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get alamat => throw _privateConstructorUsedError;
  String? get kategori => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupirCopyWith<Supir> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupirCopyWith<$Res> {
  factory $SupirCopyWith(Supir value, $Res Function(Supir) then) =
      _$SupirCopyWithImpl<$Res, Supir>;
  @useResult
  $Res call(
      {int id, String? nama, String? phone, String? alamat, String? kategori});
}

/// @nodoc
class _$SupirCopyWithImpl<$Res, $Val extends Supir>
    implements $SupirCopyWith<$Res> {
  _$SupirCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nama = freezed,
    Object? phone = freezed,
    Object? alamat = freezed,
    Object? kategori = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nama: freezed == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      alamat: freezed == alamat
          ? _value.alamat
          : alamat // ignore: cast_nullable_to_non_nullable
              as String?,
      kategori: freezed == kategori
          ? _value.kategori
          : kategori // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SupirCopyWith<$Res> implements $SupirCopyWith<$Res> {
  factory _$$_SupirCopyWith(_$_Supir value, $Res Function(_$_Supir) then) =
      __$$_SupirCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, String? nama, String? phone, String? alamat, String? kategori});
}

/// @nodoc
class __$$_SupirCopyWithImpl<$Res> extends _$SupirCopyWithImpl<$Res, _$_Supir>
    implements _$$_SupirCopyWith<$Res> {
  __$$_SupirCopyWithImpl(_$_Supir _value, $Res Function(_$_Supir) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nama = freezed,
    Object? phone = freezed,
    Object? alamat = freezed,
    Object? kategori = freezed,
  }) {
    return _then(_$_Supir(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nama: freezed == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      alamat: freezed == alamat
          ? _value.alamat
          : alamat // ignore: cast_nullable_to_non_nullable
              as String?,
      kategori: freezed == kategori
          ? _value.kategori
          : kategori // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Supir implements _Supir {
  const _$_Supir(
      {required this.id,
      required this.nama,
      required this.phone,
      required this.alamat,
      required this.kategori});

  factory _$_Supir.fromJson(Map<String, dynamic> json) =>
      _$$_SupirFromJson(json);

  @override
  final int id;
  @override
  final String? nama;
  @override
  final String? phone;
  @override
  final String? alamat;
  @override
  final String? kategori;

  @override
  String toString() {
    return 'Supir(id: $id, nama: $nama, phone: $phone, alamat: $alamat, kategori: $kategori)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Supir &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.alamat, alamat) || other.alamat == alamat) &&
            (identical(other.kategori, kategori) ||
                other.kategori == kategori));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, nama, phone, alamat, kategori);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SupirCopyWith<_$_Supir> get copyWith =>
      __$$_SupirCopyWithImpl<_$_Supir>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SupirToJson(
      this,
    );
  }
}

abstract class _Supir implements Supir {
  const factory _Supir(
      {required final int id,
      required final String? nama,
      required final String? phone,
      required final String? alamat,
      required final String? kategori}) = _$_Supir;

  factory _Supir.fromJson(Map<String, dynamic> json) = _$_Supir.fromJson;

  @override
  int get id;
  @override
  String? get nama;
  @override
  String? get phone;
  @override
  String? get alamat;
  @override
  String? get kategori;
  @override
  @JsonKey(ignore: true)
  _$$_SupirCopyWith<_$_Supir> get copyWith =>
      throw _privateConstructorUsedError;
}
