// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'double.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SPKDouble _$SPKDoubleFromJson(Map<String, dynamic> json) {
  return _Double.fromJson(json);
}

/// @nodoc
mixin _$SPKDouble {
  int get idSpk => throw _privateConstructorUsedError;
  UpdateCsDisable get disable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SPKDoubleCopyWith<SPKDouble> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SPKDoubleCopyWith<$Res> {
  factory $SPKDoubleCopyWith(SPKDouble value, $Res Function(SPKDouble) then) =
      _$SPKDoubleCopyWithImpl<$Res, SPKDouble>;
  @useResult
  $Res call({int idSpk, UpdateCsDisable disable});

  $UpdateCsDisableCopyWith<$Res> get disable;
}

/// @nodoc
class _$SPKDoubleCopyWithImpl<$Res, $Val extends SPKDouble>
    implements $SPKDoubleCopyWith<$Res> {
  _$SPKDoubleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idSpk = null,
    Object? disable = null,
  }) {
    return _then(_value.copyWith(
      idSpk: null == idSpk
          ? _value.idSpk
          : idSpk // ignore: cast_nullable_to_non_nullable
              as int,
      disable: null == disable
          ? _value.disable
          : disable // ignore: cast_nullable_to_non_nullable
              as UpdateCsDisable,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UpdateCsDisableCopyWith<$Res> get disable {
    return $UpdateCsDisableCopyWith<$Res>(_value.disable, (value) {
      return _then(_value.copyWith(disable: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DoubleCopyWith<$Res> implements $SPKDoubleCopyWith<$Res> {
  factory _$$_DoubleCopyWith(_$_Double value, $Res Function(_$_Double) then) =
      __$$_DoubleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int idSpk, UpdateCsDisable disable});

  @override
  $UpdateCsDisableCopyWith<$Res> get disable;
}

/// @nodoc
class __$$_DoubleCopyWithImpl<$Res>
    extends _$SPKDoubleCopyWithImpl<$Res, _$_Double>
    implements _$$_DoubleCopyWith<$Res> {
  __$$_DoubleCopyWithImpl(_$_Double _value, $Res Function(_$_Double) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idSpk = null,
    Object? disable = null,
  }) {
    return _then(_$_Double(
      idSpk: null == idSpk
          ? _value.idSpk
          : idSpk // ignore: cast_nullable_to_non_nullable
              as int,
      disable: null == disable
          ? _value.disable
          : disable // ignore: cast_nullable_to_non_nullable
              as UpdateCsDisable,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Double implements _Double {
  _$_Double({required this.idSpk, required this.disable});

  factory _$_Double.fromJson(Map<String, dynamic> json) =>
      _$$_DoubleFromJson(json);

  @override
  final int idSpk;
  @override
  final UpdateCsDisable disable;

  @override
  String toString() {
    return 'SPKDouble(idSpk: $idSpk, disable: $disable)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Double &&
            (identical(other.idSpk, idSpk) || other.idSpk == idSpk) &&
            (identical(other.disable, disable) || other.disable == disable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idSpk, disable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DoubleCopyWith<_$_Double> get copyWith =>
      __$$_DoubleCopyWithImpl<_$_Double>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DoubleToJson(
      this,
    );
  }
}

abstract class _Double implements SPKDouble {
  factory _Double(
      {required final int idSpk,
      required final UpdateCsDisable disable}) = _$_Double;

  factory _Double.fromJson(Map<String, dynamic> json) = _$_Double.fromJson;

  @override
  int get idSpk;
  @override
  UpdateCsDisable get disable;
  @override
  @JsonKey(ignore: true)
  _$$_DoubleCopyWith<_$_Double> get copyWith =>
      throw _privateConstructorUsedError;
}
