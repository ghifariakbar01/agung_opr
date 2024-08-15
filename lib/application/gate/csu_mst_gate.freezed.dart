// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csu_mst_gate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CSUMSTGate _$CSUMSTGateFromJson(Map<String, dynamic> json) {
  return _CSUMSTGate.fromJson(json);
}

/// @nodoc
mixin _$CSUMSTGate {
  int get id => throw _privateConstructorUsedError;
  String? get nama => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_csu')
  bool? get isCsu => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CSUMSTGateCopyWith<CSUMSTGate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSUMSTGateCopyWith<$Res> {
  factory $CSUMSTGateCopyWith(
          CSUMSTGate value, $Res Function(CSUMSTGate) then) =
      _$CSUMSTGateCopyWithImpl<$Res, CSUMSTGate>;
  @useResult
  $Res call({int id, String? nama, @JsonKey(name: 'is_csu') bool? isCsu});
}

/// @nodoc
class _$CSUMSTGateCopyWithImpl<$Res, $Val extends CSUMSTGate>
    implements $CSUMSTGateCopyWith<$Res> {
  _$CSUMSTGateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nama = freezed,
    Object? isCsu = freezed,
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
      isCsu: freezed == isCsu
          ? _value.isCsu
          : isCsu // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSUMSTGateCopyWith<$Res>
    implements $CSUMSTGateCopyWith<$Res> {
  factory _$$_CSUMSTGateCopyWith(
          _$_CSUMSTGate value, $Res Function(_$_CSUMSTGate) then) =
      __$$_CSUMSTGateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? nama, @JsonKey(name: 'is_csu') bool? isCsu});
}

/// @nodoc
class __$$_CSUMSTGateCopyWithImpl<$Res>
    extends _$CSUMSTGateCopyWithImpl<$Res, _$_CSUMSTGate>
    implements _$$_CSUMSTGateCopyWith<$Res> {
  __$$_CSUMSTGateCopyWithImpl(
      _$_CSUMSTGate _value, $Res Function(_$_CSUMSTGate) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nama = freezed,
    Object? isCsu = freezed,
  }) {
    return _then(_$_CSUMSTGate(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nama: freezed == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String?,
      isCsu: freezed == isCsu
          ? _value.isCsu
          : isCsu // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CSUMSTGate implements _CSUMSTGate {
  const _$_CSUMSTGate(
      {required this.id,
      required this.nama,
      @JsonKey(name: 'is_csu') required this.isCsu});

  factory _$_CSUMSTGate.fromJson(Map<String, dynamic> json) =>
      _$$_CSUMSTGateFromJson(json);

  @override
  final int id;
  @override
  final String? nama;
  @override
  @JsonKey(name: 'is_csu')
  final bool? isCsu;

  @override
  String toString() {
    return 'CSUMSTGate(id: $id, nama: $nama, isCsu: $isCsu)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSUMSTGate &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.isCsu, isCsu) || other.isCsu == isCsu));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, nama, isCsu);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSUMSTGateCopyWith<_$_CSUMSTGate> get copyWith =>
      __$$_CSUMSTGateCopyWithImpl<_$_CSUMSTGate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CSUMSTGateToJson(
      this,
    );
  }
}

abstract class _CSUMSTGate implements CSUMSTGate {
  const factory _CSUMSTGate(
      {required final int id,
      required final String? nama,
      @JsonKey(name: 'is_csu') required final bool? isCsu}) = _$_CSUMSTGate;

  factory _CSUMSTGate.fromJson(Map<String, dynamic> json) =
      _$_CSUMSTGate.fromJson;

  @override
  int get id;
  @override
  String? get nama;
  @override
  @JsonKey(name: 'is_csu')
  bool? get isCsu;
  @override
  @JsonKey(ignore: true)
  _$$_CSUMSTGateCopyWith<_$_CSUMSTGate> get copyWith =>
      throw _privateConstructorUsedError;
}
