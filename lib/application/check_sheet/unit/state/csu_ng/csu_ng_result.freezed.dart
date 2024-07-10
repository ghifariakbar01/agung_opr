// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csu_ng_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CSUNGResult _$CSUNGResultFromJson(Map<String, dynamic> json) {
  return _CSUNGResult.fromJson(json);
}

/// @nodoc
mixin _$CSUNGResult {
  String get ket => throw _privateConstructorUsedError;
  int get idItem => throw _privateConstructorUsedError;
  int get idJenis => throw _privateConstructorUsedError;
  int get idPosisi => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CSUNGResultCopyWith<CSUNGResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSUNGResultCopyWith<$Res> {
  factory $CSUNGResultCopyWith(
          CSUNGResult value, $Res Function(CSUNGResult) then) =
      _$CSUNGResultCopyWithImpl<$Res, CSUNGResult>;
  @useResult
  $Res call({String ket, int idItem, int idJenis, int idPosisi});
}

/// @nodoc
class _$CSUNGResultCopyWithImpl<$Res, $Val extends CSUNGResult>
    implements $CSUNGResultCopyWith<$Res> {
  _$CSUNGResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ket = null,
    Object? idItem = null,
    Object? idJenis = null,
    Object? idPosisi = null,
  }) {
    return _then(_value.copyWith(
      ket: null == ket
          ? _value.ket
          : ket // ignore: cast_nullable_to_non_nullable
              as String,
      idItem: null == idItem
          ? _value.idItem
          : idItem // ignore: cast_nullable_to_non_nullable
              as int,
      idJenis: null == idJenis
          ? _value.idJenis
          : idJenis // ignore: cast_nullable_to_non_nullable
              as int,
      idPosisi: null == idPosisi
          ? _value.idPosisi
          : idPosisi // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSUNGResultCopyWith<$Res>
    implements $CSUNGResultCopyWith<$Res> {
  factory _$$_CSUNGResultCopyWith(
          _$_CSUNGResult value, $Res Function(_$_CSUNGResult) then) =
      __$$_CSUNGResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String ket, int idItem, int idJenis, int idPosisi});
}

/// @nodoc
class __$$_CSUNGResultCopyWithImpl<$Res>
    extends _$CSUNGResultCopyWithImpl<$Res, _$_CSUNGResult>
    implements _$$_CSUNGResultCopyWith<$Res> {
  __$$_CSUNGResultCopyWithImpl(
      _$_CSUNGResult _value, $Res Function(_$_CSUNGResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ket = null,
    Object? idItem = null,
    Object? idJenis = null,
    Object? idPosisi = null,
  }) {
    return _then(_$_CSUNGResult(
      ket: null == ket
          ? _value.ket
          : ket // ignore: cast_nullable_to_non_nullable
              as String,
      idItem: null == idItem
          ? _value.idItem
          : idItem // ignore: cast_nullable_to_non_nullable
              as int,
      idJenis: null == idJenis
          ? _value.idJenis
          : idJenis // ignore: cast_nullable_to_non_nullable
              as int,
      idPosisi: null == idPosisi
          ? _value.idPosisi
          : idPosisi // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CSUNGResult implements _CSUNGResult {
  const _$_CSUNGResult(
      {required this.ket,
      required this.idItem,
      required this.idJenis,
      required this.idPosisi});

  factory _$_CSUNGResult.fromJson(Map<String, dynamic> json) =>
      _$$_CSUNGResultFromJson(json);

  @override
  final String ket;
  @override
  final int idItem;
  @override
  final int idJenis;
  @override
  final int idPosisi;

  @override
  String toString() {
    return 'CSUNGResult(ket: $ket, idItem: $idItem, idJenis: $idJenis, idPosisi: $idPosisi)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSUNGResult &&
            (identical(other.ket, ket) || other.ket == ket) &&
            (identical(other.idItem, idItem) || other.idItem == idItem) &&
            (identical(other.idJenis, idJenis) || other.idJenis == idJenis) &&
            (identical(other.idPosisi, idPosisi) ||
                other.idPosisi == idPosisi));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ket, idItem, idJenis, idPosisi);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSUNGResultCopyWith<_$_CSUNGResult> get copyWith =>
      __$$_CSUNGResultCopyWithImpl<_$_CSUNGResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CSUNGResultToJson(
      this,
    );
  }
}

abstract class _CSUNGResult implements CSUNGResult {
  const factory _CSUNGResult(
      {required final String ket,
      required final int idItem,
      required final int idJenis,
      required final int idPosisi}) = _$_CSUNGResult;

  factory _CSUNGResult.fromJson(Map<String, dynamic> json) =
      _$_CSUNGResult.fromJson;

  @override
  String get ket;
  @override
  int get idItem;
  @override
  int get idJenis;
  @override
  int get idPosisi;
  @override
  @JsonKey(ignore: true)
  _$$_CSUNGResultCopyWith<_$_CSUNGResult> get copyWith =>
      throw _privateConstructorUsedError;
}
