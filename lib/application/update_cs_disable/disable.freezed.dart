// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'disable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UpdateCsDisable _$UpdateCsDisableFromJson(Map<String, dynamic> json) {
  return _UpdateCsuDisable.fromJson(json);
}

/// @nodoc
mixin _$UpdateCsDisable {
  bool get loading => throw _privateConstructorUsedError;
  bool get unload => throw _privateConstructorUsedError;
  bool get loadunload => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateCsDisableCopyWith<UpdateCsDisable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateCsDisableCopyWith<$Res> {
  factory $UpdateCsDisableCopyWith(
          UpdateCsDisable value, $Res Function(UpdateCsDisable) then) =
      _$UpdateCsDisableCopyWithImpl<$Res, UpdateCsDisable>;
  @useResult
  $Res call({bool loading, bool unload, bool loadunload});
}

/// @nodoc
class _$UpdateCsDisableCopyWithImpl<$Res, $Val extends UpdateCsDisable>
    implements $UpdateCsDisableCopyWith<$Res> {
  _$UpdateCsDisableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? unload = null,
    Object? loadunload = null,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      unload: null == unload
          ? _value.unload
          : unload // ignore: cast_nullable_to_non_nullable
              as bool,
      loadunload: null == loadunload
          ? _value.loadunload
          : loadunload // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UpdateCsuDisableCopyWith<$Res>
    implements $UpdateCsDisableCopyWith<$Res> {
  factory _$$_UpdateCsuDisableCopyWith(
          _$_UpdateCsuDisable value, $Res Function(_$_UpdateCsuDisable) then) =
      __$$_UpdateCsuDisableCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool loading, bool unload, bool loadunload});
}

/// @nodoc
class __$$_UpdateCsuDisableCopyWithImpl<$Res>
    extends _$UpdateCsDisableCopyWithImpl<$Res, _$_UpdateCsuDisable>
    implements _$$_UpdateCsuDisableCopyWith<$Res> {
  __$$_UpdateCsuDisableCopyWithImpl(
      _$_UpdateCsuDisable _value, $Res Function(_$_UpdateCsuDisable) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? unload = null,
    Object? loadunload = null,
  }) {
    return _then(_$_UpdateCsuDisable(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      unload: null == unload
          ? _value.unload
          : unload // ignore: cast_nullable_to_non_nullable
              as bool,
      loadunload: null == loadunload
          ? _value.loadunload
          : loadunload // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UpdateCsuDisable implements _UpdateCsuDisable {
  _$_UpdateCsuDisable(
      {required this.loading, required this.unload, required this.loadunload});

  factory _$_UpdateCsuDisable.fromJson(Map<String, dynamic> json) =>
      _$$_UpdateCsuDisableFromJson(json);

  @override
  final bool loading;
  @override
  final bool unload;
  @override
  final bool loadunload;

  @override
  String toString() {
    return 'UpdateCsDisable(loading: $loading, unload: $unload, loadunload: $loadunload)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateCsuDisable &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.unload, unload) || other.unload == unload) &&
            (identical(other.loadunload, loadunload) ||
                other.loadunload == loadunload));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, loading, unload, loadunload);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateCsuDisableCopyWith<_$_UpdateCsuDisable> get copyWith =>
      __$$_UpdateCsuDisableCopyWithImpl<_$_UpdateCsuDisable>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UpdateCsuDisableToJson(
      this,
    );
  }
}

abstract class _UpdateCsuDisable implements UpdateCsDisable {
  factory _UpdateCsuDisable(
      {required final bool loading,
      required final bool unload,
      required final bool loadunload}) = _$_UpdateCsuDisable;

  factory _UpdateCsuDisable.fromJson(Map<String, dynamic> json) =
      _$_UpdateCsuDisable.fromJson;

  @override
  bool get loading;
  @override
  bool get unload;
  @override
  bool get loadunload;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateCsuDisableCopyWith<_$_UpdateCsuDisable> get copyWith =>
      throw _privateConstructorUsedError;
}
