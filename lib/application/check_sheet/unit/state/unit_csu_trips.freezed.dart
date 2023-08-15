// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unit_csu_trips.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UnitCSUTrips _$UnitCSUTripsFromJson(Map<String, dynamic> json) {
  return _UnitCSUTrips.fromJson(json);
}

/// @nodoc
mixin _$UnitCSUTrips {
  int get idUnit => throw _privateConstructorUsedError;
  @JsonKey(toJson: UnitCSUTrips.listToJson)
  List<CSUTrips> get csuResult => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnitCSUTripsCopyWith<UnitCSUTrips> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitCSUTripsCopyWith<$Res> {
  factory $UnitCSUTripsCopyWith(
          UnitCSUTrips value, $Res Function(UnitCSUTrips) then) =
      _$UnitCSUTripsCopyWithImpl<$Res, UnitCSUTrips>;
  @useResult
  $Res call(
      {int idUnit,
      @JsonKey(toJson: UnitCSUTrips.listToJson) List<CSUTrips> csuResult});
}

/// @nodoc
class _$UnitCSUTripsCopyWithImpl<$Res, $Val extends UnitCSUTrips>
    implements $UnitCSUTripsCopyWith<$Res> {
  _$UnitCSUTripsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUnit = null,
    Object? csuResult = null,
  }) {
    return _then(_value.copyWith(
      idUnit: null == idUnit
          ? _value.idUnit
          : idUnit // ignore: cast_nullable_to_non_nullable
              as int,
      csuResult: null == csuResult
          ? _value.csuResult
          : csuResult // ignore: cast_nullable_to_non_nullable
              as List<CSUTrips>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UnitCSUTripsCopyWith<$Res>
    implements $UnitCSUTripsCopyWith<$Res> {
  factory _$$_UnitCSUTripsCopyWith(
          _$_UnitCSUTrips value, $Res Function(_$_UnitCSUTrips) then) =
      __$$_UnitCSUTripsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int idUnit,
      @JsonKey(toJson: UnitCSUTrips.listToJson) List<CSUTrips> csuResult});
}

/// @nodoc
class __$$_UnitCSUTripsCopyWithImpl<$Res>
    extends _$UnitCSUTripsCopyWithImpl<$Res, _$_UnitCSUTrips>
    implements _$$_UnitCSUTripsCopyWith<$Res> {
  __$$_UnitCSUTripsCopyWithImpl(
      _$_UnitCSUTrips _value, $Res Function(_$_UnitCSUTrips) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idUnit = null,
    Object? csuResult = null,
  }) {
    return _then(_$_UnitCSUTrips(
      idUnit: null == idUnit
          ? _value.idUnit
          : idUnit // ignore: cast_nullable_to_non_nullable
              as int,
      csuResult: null == csuResult
          ? _value._csuResult
          : csuResult // ignore: cast_nullable_to_non_nullable
              as List<CSUTrips>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UnitCSUTrips implements _UnitCSUTrips {
  const _$_UnitCSUTrips(
      {required this.idUnit,
      @JsonKey(toJson: UnitCSUTrips.listToJson)
      required final List<CSUTrips> csuResult})
      : _csuResult = csuResult;

  factory _$_UnitCSUTrips.fromJson(Map<String, dynamic> json) =>
      _$$_UnitCSUTripsFromJson(json);

  @override
  final int idUnit;
  final List<CSUTrips> _csuResult;
  @override
  @JsonKey(toJson: UnitCSUTrips.listToJson)
  List<CSUTrips> get csuResult {
    if (_csuResult is EqualUnmodifiableListView) return _csuResult;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_csuResult);
  }

  @override
  String toString() {
    return 'UnitCSUTrips(idUnit: $idUnit, csuResult: $csuResult)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnitCSUTrips &&
            (identical(other.idUnit, idUnit) || other.idUnit == idUnit) &&
            const DeepCollectionEquality()
                .equals(other._csuResult, _csuResult));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, idUnit, const DeepCollectionEquality().hash(_csuResult));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnitCSUTripsCopyWith<_$_UnitCSUTrips> get copyWith =>
      __$$_UnitCSUTripsCopyWithImpl<_$_UnitCSUTrips>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnitCSUTripsToJson(
      this,
    );
  }
}

abstract class _UnitCSUTrips implements UnitCSUTrips {
  const factory _UnitCSUTrips(
      {required final int idUnit,
      @JsonKey(toJson: UnitCSUTrips.listToJson)
      required final List<CSUTrips> csuResult}) = _$_UnitCSUTrips;

  factory _UnitCSUTrips.fromJson(Map<String, dynamic> json) =
      _$_UnitCSUTrips.fromJson;

  @override
  int get idUnit;
  @override
  @JsonKey(toJson: UnitCSUTrips.listToJson)
  List<CSUTrips> get csuResult;
  @override
  @JsonKey(ignore: true)
  _$$_UnitCSUTripsCopyWith<_$_UnitCSUTrips> get copyWith =>
      throw _privateConstructorUsedError;
}
