// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csu_trips_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CSUTripsState {
  bool get isProcessing => throw _privateConstructorUsedError;
  List<CSUTrips> get csuTripsList => throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<CSUTrips>>> get FOSOCSUTrips =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CSUTripsStateCopyWith<CSUTripsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSUTripsStateCopyWith<$Res> {
  factory $CSUTripsStateCopyWith(
          CSUTripsState value, $Res Function(CSUTripsState) then) =
      _$CSUTripsStateCopyWithImpl<$Res, CSUTripsState>;
  @useResult
  $Res call(
      {bool isProcessing,
      List<CSUTrips> csuTripsList,
      Option<Either<RemoteFailure, List<CSUTrips>>> FOSOCSUTrips});
}

/// @nodoc
class _$CSUTripsStateCopyWithImpl<$Res, $Val extends CSUTripsState>
    implements $CSUTripsStateCopyWith<$Res> {
  _$CSUTripsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProcessing = null,
    Object? csuTripsList = null,
    Object? FOSOCSUTrips = null,
  }) {
    return _then(_value.copyWith(
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      csuTripsList: null == csuTripsList
          ? _value.csuTripsList
          : csuTripsList // ignore: cast_nullable_to_non_nullable
              as List<CSUTrips>,
      FOSOCSUTrips: null == FOSOCSUTrips
          ? _value.FOSOCSUTrips
          : FOSOCSUTrips // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSUTrips>>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSUTripsStateCopyWith<$Res>
    implements $CSUTripsStateCopyWith<$Res> {
  factory _$$_CSUTripsStateCopyWith(
          _$_CSUTripsState value, $Res Function(_$_CSUTripsState) then) =
      __$$_CSUTripsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isProcessing,
      List<CSUTrips> csuTripsList,
      Option<Either<RemoteFailure, List<CSUTrips>>> FOSOCSUTrips});
}

/// @nodoc
class __$$_CSUTripsStateCopyWithImpl<$Res>
    extends _$CSUTripsStateCopyWithImpl<$Res, _$_CSUTripsState>
    implements _$$_CSUTripsStateCopyWith<$Res> {
  __$$_CSUTripsStateCopyWithImpl(
      _$_CSUTripsState _value, $Res Function(_$_CSUTripsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProcessing = null,
    Object? csuTripsList = null,
    Object? FOSOCSUTrips = null,
  }) {
    return _then(_$_CSUTripsState(
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      csuTripsList: null == csuTripsList
          ? _value._csuTripsList
          : csuTripsList // ignore: cast_nullable_to_non_nullable
              as List<CSUTrips>,
      FOSOCSUTrips: null == FOSOCSUTrips
          ? _value.FOSOCSUTrips
          : FOSOCSUTrips // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<CSUTrips>>>,
    ));
  }
}

/// @nodoc

class _$_CSUTripsState implements _CSUTripsState {
  const _$_CSUTripsState(
      {required this.isProcessing,
      required final List<CSUTrips> csuTripsList,
      required this.FOSOCSUTrips})
      : _csuTripsList = csuTripsList;

  @override
  final bool isProcessing;
  final List<CSUTrips> _csuTripsList;
  @override
  List<CSUTrips> get csuTripsList {
    if (_csuTripsList is EqualUnmodifiableListView) return _csuTripsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_csuTripsList);
  }

  @override
  final Option<Either<RemoteFailure, List<CSUTrips>>> FOSOCSUTrips;

  @override
  String toString() {
    return 'CSUTripsState(isProcessing: $isProcessing, csuTripsList: $csuTripsList, FOSOCSUTrips: $FOSOCSUTrips)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSUTripsState &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            const DeepCollectionEquality()
                .equals(other._csuTripsList, _csuTripsList) &&
            (identical(other.FOSOCSUTrips, FOSOCSUTrips) ||
                other.FOSOCSUTrips == FOSOCSUTrips));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isProcessing,
      const DeepCollectionEquality().hash(_csuTripsList), FOSOCSUTrips);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSUTripsStateCopyWith<_$_CSUTripsState> get copyWith =>
      __$$_CSUTripsStateCopyWithImpl<_$_CSUTripsState>(this, _$identity);
}

abstract class _CSUTripsState implements CSUTripsState {
  const factory _CSUTripsState(
      {required final bool isProcessing,
      required final List<CSUTrips> csuTripsList,
      required final Option<Either<RemoteFailure, List<CSUTrips>>>
          FOSOCSUTrips}) = _$_CSUTripsState;

  @override
  bool get isProcessing;
  @override
  List<CSUTrips> get csuTripsList;
  @override
  Option<Either<RemoteFailure, List<CSUTrips>>> get FOSOCSUTrips;
  @override
  @JsonKey(ignore: true)
  _$$_CSUTripsStateCopyWith<_$_CSUTripsState> get copyWith =>
      throw _privateConstructorUsedError;
}
