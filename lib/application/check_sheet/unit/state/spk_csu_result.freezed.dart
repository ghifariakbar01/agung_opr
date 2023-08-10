// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spk_csu_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FrameNameCSUResult _$FrameNameCSUResultFromJson(Map<String, dynamic> json) {
  return _FrameNameCSUResult.fromJson(json);
}

/// @nodoc
mixin _$FrameNameCSUResult {
  String get frameName => throw _privateConstructorUsedError;
  @JsonKey(toJson: listToJson)
  List<CSUResult> get csuResult => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FrameNameCSUResultCopyWith<FrameNameCSUResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrameNameCSUResultCopyWith<$Res> {
  factory $FrameNameCSUResultCopyWith(
          FrameNameCSUResult value, $Res Function(FrameNameCSUResult) then) =
      _$FrameNameCSUResultCopyWithImpl<$Res, FrameNameCSUResult>;
  @useResult
  $Res call(
      {String frameName,
      @JsonKey(toJson: listToJson) List<CSUResult> csuResult});
}

/// @nodoc
class _$FrameNameCSUResultCopyWithImpl<$Res, $Val extends FrameNameCSUResult>
    implements $FrameNameCSUResultCopyWith<$Res> {
  _$FrameNameCSUResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frameName = null,
    Object? csuResult = null,
  }) {
    return _then(_value.copyWith(
      frameName: null == frameName
          ? _value.frameName
          : frameName // ignore: cast_nullable_to_non_nullable
              as String,
      csuResult: null == csuResult
          ? _value.csuResult
          : csuResult // ignore: cast_nullable_to_non_nullable
              as List<CSUResult>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FrameNameCSUResultCopyWith<$Res>
    implements $FrameNameCSUResultCopyWith<$Res> {
  factory _$$_FrameNameCSUResultCopyWith(_$_FrameNameCSUResult value,
          $Res Function(_$_FrameNameCSUResult) then) =
      __$$_FrameNameCSUResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String frameName,
      @JsonKey(toJson: listToJson) List<CSUResult> csuResult});
}

/// @nodoc
class __$$_FrameNameCSUResultCopyWithImpl<$Res>
    extends _$FrameNameCSUResultCopyWithImpl<$Res, _$_FrameNameCSUResult>
    implements _$$_FrameNameCSUResultCopyWith<$Res> {
  __$$_FrameNameCSUResultCopyWithImpl(
      _$_FrameNameCSUResult _value, $Res Function(_$_FrameNameCSUResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frameName = null,
    Object? csuResult = null,
  }) {
    return _then(_$_FrameNameCSUResult(
      frameName: null == frameName
          ? _value.frameName
          : frameName // ignore: cast_nullable_to_non_nullable
              as String,
      csuResult: null == csuResult
          ? _value._csuResult
          : csuResult // ignore: cast_nullable_to_non_nullable
              as List<CSUResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FrameNameCSUResult implements _FrameNameCSUResult {
  const _$_FrameNameCSUResult(
      {required this.frameName,
      @JsonKey(toJson: listToJson) required final List<CSUResult> csuResult})
      : _csuResult = csuResult;

  factory _$_FrameNameCSUResult.fromJson(Map<String, dynamic> json) =>
      _$$_FrameNameCSUResultFromJson(json);

  @override
  final String frameName;
  final List<CSUResult> _csuResult;
  @override
  @JsonKey(toJson: listToJson)
  List<CSUResult> get csuResult {
    if (_csuResult is EqualUnmodifiableListView) return _csuResult;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_csuResult);
  }

  @override
  String toString() {
    return 'FrameNameCSUResult(frameName: $frameName, csuResult: $csuResult)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FrameNameCSUResult &&
            (identical(other.frameName, frameName) ||
                other.frameName == frameName) &&
            const DeepCollectionEquality()
                .equals(other._csuResult, _csuResult));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, frameName, const DeepCollectionEquality().hash(_csuResult));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FrameNameCSUResultCopyWith<_$_FrameNameCSUResult> get copyWith =>
      __$$_FrameNameCSUResultCopyWithImpl<_$_FrameNameCSUResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FrameNameCSUResultToJson(
      this,
    );
  }
}

abstract class _FrameNameCSUResult implements FrameNameCSUResult {
  const factory _FrameNameCSUResult(
      {required final String frameName,
      @JsonKey(toJson: listToJson)
      required final List<CSUResult> csuResult}) = _$_FrameNameCSUResult;

  factory _FrameNameCSUResult.fromJson(Map<String, dynamic> json) =
      _$_FrameNameCSUResult.fromJson;

  @override
  String get frameName;
  @override
  @JsonKey(toJson: listToJson)
  List<CSUResult> get csuResult;
  @override
  @JsonKey(ignore: true)
  _$$_FrameNameCSUResultCopyWith<_$_FrameNameCSUResult> get copyWith =>
      throw _privateConstructorUsedError;
}
