// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csu_trips.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CSUTrips _$CSUTripsFromJson(Map<String, dynamic> json) {
  return _CSUTrips.fromJson(json);
}

/// @nodoc
mixin _$CSUTrips {
  String? get costanalis => throw _privateConstructorUsedError;
  String? get custnm => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CSUTripsCopyWith<CSUTrips> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSUTripsCopyWith<$Res> {
  factory $CSUTripsCopyWith(CSUTrips value, $Res Function(CSUTrips) then) =
      _$CSUTripsCopyWithImpl<$Res, CSUTrips>;
  @useResult
  $Res call({String? costanalis, String? custnm});
}

/// @nodoc
class _$CSUTripsCopyWithImpl<$Res, $Val extends CSUTrips>
    implements $CSUTripsCopyWith<$Res> {
  _$CSUTripsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? costanalis = freezed,
    Object? custnm = freezed,
  }) {
    return _then(_value.copyWith(
      costanalis: freezed == costanalis
          ? _value.costanalis
          : costanalis // ignore: cast_nullable_to_non_nullable
              as String?,
      custnm: freezed == custnm
          ? _value.custnm
          : custnm // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSUTripsCopyWith<$Res> implements $CSUTripsCopyWith<$Res> {
  factory _$$_CSUTripsCopyWith(
          _$_CSUTrips value, $Res Function(_$_CSUTrips) then) =
      __$$_CSUTripsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? costanalis, String? custnm});
}

/// @nodoc
class __$$_CSUTripsCopyWithImpl<$Res>
    extends _$CSUTripsCopyWithImpl<$Res, _$_CSUTrips>
    implements _$$_CSUTripsCopyWith<$Res> {
  __$$_CSUTripsCopyWithImpl(
      _$_CSUTrips _value, $Res Function(_$_CSUTrips) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? costanalis = freezed,
    Object? custnm = freezed,
  }) {
    return _then(_$_CSUTrips(
      costanalis: freezed == costanalis
          ? _value.costanalis
          : costanalis // ignore: cast_nullable_to_non_nullable
              as String?,
      custnm: freezed == custnm
          ? _value.custnm
          : custnm // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CSUTrips implements _CSUTrips {
  const _$_CSUTrips({required this.costanalis, required this.custnm});

  factory _$_CSUTrips.fromJson(Map<String, dynamic> json) =>
      _$$_CSUTripsFromJson(json);

  @override
  final String? costanalis;
  @override
  final String? custnm;

  @override
  String toString() {
    return 'CSUTrips(costanalis: $costanalis, custnm: $custnm)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSUTrips &&
            (identical(other.costanalis, costanalis) ||
                other.costanalis == costanalis) &&
            (identical(other.custnm, custnm) || other.custnm == custnm));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, costanalis, custnm);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSUTripsCopyWith<_$_CSUTrips> get copyWith =>
      __$$_CSUTripsCopyWithImpl<_$_CSUTrips>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CSUTripsToJson(
      this,
    );
  }
}

abstract class _CSUTrips implements CSUTrips {
  const factory _CSUTrips(
      {required final String? costanalis,
      required final String? custnm}) = _$_CSUTrips;

  factory _CSUTrips.fromJson(Map<String, dynamic> json) = _$_CSUTrips.fromJson;

  @override
  String? get costanalis;
  @override
  String? get custnm;
  @override
  @JsonKey(ignore: true)
  _$$_CSUTripsCopyWith<_$_CSUTrips> get copyWith =>
      throw _privateConstructorUsedError;
}
