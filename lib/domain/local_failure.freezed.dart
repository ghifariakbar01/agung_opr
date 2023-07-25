// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LocalFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() storage,
    required TResult Function(String? message) format,
    required TResult Function() empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? storage,
    TResult? Function(String? message)? format,
    TResult? Function()? empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? storage,
    TResult Function(String? message)? format,
    TResult Function()? empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Storage value) storage,
    required TResult Function(_Format value) format,
    required TResult Function(_Empty value) empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Storage value)? storage,
    TResult? Function(_Format value)? format,
    TResult? Function(_Empty value)? empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Storage value)? storage,
    TResult Function(_Format value)? format,
    TResult Function(_Empty value)? empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalFailureCopyWith<$Res> {
  factory $LocalFailureCopyWith(
          LocalFailure value, $Res Function(LocalFailure) then) =
      _$LocalFailureCopyWithImpl<$Res, LocalFailure>;
}

/// @nodoc
class _$LocalFailureCopyWithImpl<$Res, $Val extends LocalFailure>
    implements $LocalFailureCopyWith<$Res> {
  _$LocalFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_StorageCopyWith<$Res> {
  factory _$$_StorageCopyWith(
          _$_Storage value, $Res Function(_$_Storage) then) =
      __$$_StorageCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_StorageCopyWithImpl<$Res>
    extends _$LocalFailureCopyWithImpl<$Res, _$_Storage>
    implements _$$_StorageCopyWith<$Res> {
  __$$_StorageCopyWithImpl(_$_Storage _value, $Res Function(_$_Storage) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Storage implements _Storage {
  const _$_Storage();

  @override
  String toString() {
    return 'LocalFailure.storage()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Storage);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() storage,
    required TResult Function(String? message) format,
    required TResult Function() empty,
  }) {
    return storage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? storage,
    TResult? Function(String? message)? format,
    TResult? Function()? empty,
  }) {
    return storage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? storage,
    TResult Function(String? message)? format,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (storage != null) {
      return storage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Storage value) storage,
    required TResult Function(_Format value) format,
    required TResult Function(_Empty value) empty,
  }) {
    return storage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Storage value)? storage,
    TResult? Function(_Format value)? format,
    TResult? Function(_Empty value)? empty,
  }) {
    return storage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Storage value)? storage,
    TResult Function(_Format value)? format,
    TResult Function(_Empty value)? empty,
    required TResult orElse(),
  }) {
    if (storage != null) {
      return storage(this);
    }
    return orElse();
  }
}

abstract class _Storage implements LocalFailure {
  const factory _Storage() = _$_Storage;
}

/// @nodoc
abstract class _$$_FormatCopyWith<$Res> {
  factory _$$_FormatCopyWith(_$_Format value, $Res Function(_$_Format) then) =
      __$$_FormatCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$_FormatCopyWithImpl<$Res>
    extends _$LocalFailureCopyWithImpl<$Res, _$_Format>
    implements _$$_FormatCopyWith<$Res> {
  __$$_FormatCopyWithImpl(_$_Format _value, $Res Function(_$_Format) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_Format(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Format implements _Format {
  const _$_Format([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'LocalFailure.format(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Format &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FormatCopyWith<_$_Format> get copyWith =>
      __$$_FormatCopyWithImpl<_$_Format>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() storage,
    required TResult Function(String? message) format,
    required TResult Function() empty,
  }) {
    return format(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? storage,
    TResult? Function(String? message)? format,
    TResult? Function()? empty,
  }) {
    return format?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? storage,
    TResult Function(String? message)? format,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (format != null) {
      return format(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Storage value) storage,
    required TResult Function(_Format value) format,
    required TResult Function(_Empty value) empty,
  }) {
    return format(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Storage value)? storage,
    TResult? Function(_Format value)? format,
    TResult? Function(_Empty value)? empty,
  }) {
    return format?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Storage value)? storage,
    TResult Function(_Format value)? format,
    TResult Function(_Empty value)? empty,
    required TResult orElse(),
  }) {
    if (format != null) {
      return format(this);
    }
    return orElse();
  }
}

abstract class _Format implements LocalFailure {
  const factory _Format([final String? message]) = _$_Format;

  String? get message;
  @JsonKey(ignore: true)
  _$$_FormatCopyWith<_$_Format> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_EmptyCopyWith<$Res> {
  factory _$$_EmptyCopyWith(_$_Empty value, $Res Function(_$_Empty) then) =
      __$$_EmptyCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_EmptyCopyWithImpl<$Res>
    extends _$LocalFailureCopyWithImpl<$Res, _$_Empty>
    implements _$$_EmptyCopyWith<$Res> {
  __$$_EmptyCopyWithImpl(_$_Empty _value, $Res Function(_$_Empty) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Empty implements _Empty {
  const _$_Empty();

  @override
  String toString() {
    return 'LocalFailure.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Empty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() storage,
    required TResult Function(String? message) format,
    required TResult Function() empty,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? storage,
    TResult? Function(String? message)? format,
    TResult? Function()? empty,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? storage,
    TResult Function(String? message)? format,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Storage value) storage,
    required TResult Function(_Format value) format,
    required TResult Function(_Empty value) empty,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Storage value)? storage,
    TResult? Function(_Format value)? format,
    TResult? Function(_Empty value)? empty,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Storage value)? storage,
    TResult Function(_Format value)? format,
    TResult Function(_Empty value)? empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class _Empty implements LocalFailure {
  const factory _Empty() = _$_Empty;
}
