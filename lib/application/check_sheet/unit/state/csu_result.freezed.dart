// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csu_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CSUResult _$CSUResultFromJson(Map<String, dynamic> json) {
  return _CSUResult.fromJson(json);
}

/// @nodoc
mixin _$CSUResult {
  int get id => throw _privateConstructorUsedError;
  int? get defectAmount => throw _privateConstructorUsedError;
  String? get gate => throw _privateConstructorUsedError;
  String? get frame => throw _privateConstructorUsedError;
  bool? get inOut => throw _privateConstructorUsedError;
  int? get isDefect => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;
  String? get updatedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CSUResultCopyWith<CSUResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CSUResultCopyWith<$Res> {
  factory $CSUResultCopyWith(CSUResult value, $Res Function(CSUResult) then) =
      _$CSUResultCopyWithImpl<$Res, CSUResult>;
  @useResult
  $Res call(
      {int id,
      int? defectAmount,
      String? gate,
      String? frame,
      bool? inOut,
      int? isDefect,
      String? updatedAt,
      String? updatedBy});
}

/// @nodoc
class _$CSUResultCopyWithImpl<$Res, $Val extends CSUResult>
    implements $CSUResultCopyWith<$Res> {
  _$CSUResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? defectAmount = freezed,
    Object? gate = freezed,
    Object? frame = freezed,
    Object? inOut = freezed,
    Object? isDefect = freezed,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      defectAmount: freezed == defectAmount
          ? _value.defectAmount
          : defectAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      gate: freezed == gate
          ? _value.gate
          : gate // ignore: cast_nullable_to_non_nullable
              as String?,
      frame: freezed == frame
          ? _value.frame
          : frame // ignore: cast_nullable_to_non_nullable
              as String?,
      inOut: freezed == inOut
          ? _value.inOut
          : inOut // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDefect: freezed == isDefect
          ? _value.isDefect
          : isDefect // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CSUResultCopyWith<$Res> implements $CSUResultCopyWith<$Res> {
  factory _$$_CSUResultCopyWith(
          _$_CSUResult value, $Res Function(_$_CSUResult) then) =
      __$$_CSUResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? defectAmount,
      String? gate,
      String? frame,
      bool? inOut,
      int? isDefect,
      String? updatedAt,
      String? updatedBy});
}

/// @nodoc
class __$$_CSUResultCopyWithImpl<$Res>
    extends _$CSUResultCopyWithImpl<$Res, _$_CSUResult>
    implements _$$_CSUResultCopyWith<$Res> {
  __$$_CSUResultCopyWithImpl(
      _$_CSUResult _value, $Res Function(_$_CSUResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? defectAmount = freezed,
    Object? gate = freezed,
    Object? frame = freezed,
    Object? inOut = freezed,
    Object? isDefect = freezed,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
  }) {
    return _then(_$_CSUResult(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      defectAmount: freezed == defectAmount
          ? _value.defectAmount
          : defectAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      gate: freezed == gate
          ? _value.gate
          : gate // ignore: cast_nullable_to_non_nullable
              as String?,
      frame: freezed == frame
          ? _value.frame
          : frame // ignore: cast_nullable_to_non_nullable
              as String?,
      inOut: freezed == inOut
          ? _value.inOut
          : inOut // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDefect: freezed == isDefect
          ? _value.isDefect
          : isDefect // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CSUResult implements _CSUResult {
  const _$_CSUResult(
      {required this.id,
      required this.defectAmount,
      required this.gate,
      required this.frame,
      required this.inOut,
      required this.isDefect,
      required this.updatedAt,
      required this.updatedBy});

  factory _$_CSUResult.fromJson(Map<String, dynamic> json) =>
      _$$_CSUResultFromJson(json);

  @override
  final int id;
  @override
  final int? defectAmount;
  @override
  final String? gate;
  @override
  final String? frame;
  @override
  final bool? inOut;
  @override
  final int? isDefect;
  @override
  final String? updatedAt;
  @override
  final String? updatedBy;

  @override
  String toString() {
    return 'CSUResult(id: $id, defectAmount: $defectAmount, gate: $gate, frame: $frame, inOut: $inOut, isDefect: $isDefect, updatedAt: $updatedAt, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CSUResult &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.defectAmount, defectAmount) ||
                other.defectAmount == defectAmount) &&
            (identical(other.gate, gate) || other.gate == gate) &&
            (identical(other.frame, frame) || other.frame == frame) &&
            (identical(other.inOut, inOut) || other.inOut == inOut) &&
            (identical(other.isDefect, isDefect) ||
                other.isDefect == isDefect) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, defectAmount, gate, frame,
      inOut, isDefect, updatedAt, updatedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CSUResultCopyWith<_$_CSUResult> get copyWith =>
      __$$_CSUResultCopyWithImpl<_$_CSUResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CSUResultToJson(
      this,
    );
  }
}

abstract class _CSUResult implements CSUResult {
  const factory _CSUResult(
      {required final int id,
      required final int? defectAmount,
      required final String? gate,
      required final String? frame,
      required final bool? inOut,
      required final int? isDefect,
      required final String? updatedAt,
      required final String? updatedBy}) = _$_CSUResult;

  factory _CSUResult.fromJson(Map<String, dynamic> json) =
      _$_CSUResult.fromJson;

  @override
  int get id;
  @override
  int? get defectAmount;
  @override
  String? get gate;
  @override
  String? get frame;
  @override
  bool? get inOut;
  @override
  int? get isDefect;
  @override
  String? get updatedAt;
  @override
  String? get updatedBy;
  @override
  @JsonKey(ignore: true)
  _$$_CSUResultCopyWith<_$_CSUResult> get copyWith =>
      throw _privateConstructorUsedError;
}
