// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RemoteFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() storage,
    required TResult Function(int? errorCode, String? message) server,
    required TResult Function(String? message) parse,
    required TResult Function() noConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? storage,
    TResult? Function(int? errorCode, String? message)? server,
    TResult? Function(String? message)? parse,
    TResult? Function()? noConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? storage,
    TResult Function(int? errorCode, String? message)? server,
    TResult Function(String? message)? parse,
    TResult Function()? noConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Storage value) storage,
    required TResult Function(_Server value) server,
    required TResult Function(_Parse value) parse,
    required TResult Function(_NoConnection value) noConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Storage value)? storage,
    TResult? Function(_Server value)? server,
    TResult? Function(_Parse value)? parse,
    TResult? Function(_NoConnection value)? noConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Storage value)? storage,
    TResult Function(_Server value)? server,
    TResult Function(_Parse value)? parse,
    TResult Function(_NoConnection value)? noConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteFailureCopyWith<$Res> {
  factory $RemoteFailureCopyWith(
          RemoteFailure value, $Res Function(RemoteFailure) then) =
      _$RemoteFailureCopyWithImpl<$Res, RemoteFailure>;
}

/// @nodoc
class _$RemoteFailureCopyWithImpl<$Res, $Val extends RemoteFailure>
    implements $RemoteFailureCopyWith<$Res> {
  _$RemoteFailureCopyWithImpl(this._value, this._then);

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
    extends _$RemoteFailureCopyWithImpl<$Res, _$_Storage>
    implements _$$_StorageCopyWith<$Res> {
  __$$_StorageCopyWithImpl(_$_Storage _value, $Res Function(_$_Storage) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Storage implements _Storage {
  const _$_Storage();

  @override
  String toString() {
    return 'RemoteFailure.storage()';
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
    required TResult Function(int? errorCode, String? message) server,
    required TResult Function(String? message) parse,
    required TResult Function() noConnection,
  }) {
    return storage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? storage,
    TResult? Function(int? errorCode, String? message)? server,
    TResult? Function(String? message)? parse,
    TResult? Function()? noConnection,
  }) {
    return storage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? storage,
    TResult Function(int? errorCode, String? message)? server,
    TResult Function(String? message)? parse,
    TResult Function()? noConnection,
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
    required TResult Function(_Server value) server,
    required TResult Function(_Parse value) parse,
    required TResult Function(_NoConnection value) noConnection,
  }) {
    return storage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Storage value)? storage,
    TResult? Function(_Server value)? server,
    TResult? Function(_Parse value)? parse,
    TResult? Function(_NoConnection value)? noConnection,
  }) {
    return storage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Storage value)? storage,
    TResult Function(_Server value)? server,
    TResult Function(_Parse value)? parse,
    TResult Function(_NoConnection value)? noConnection,
    required TResult orElse(),
  }) {
    if (storage != null) {
      return storage(this);
    }
    return orElse();
  }
}

abstract class _Storage implements RemoteFailure {
  const factory _Storage() = _$_Storage;
}

/// @nodoc
abstract class _$$_ServerCopyWith<$Res> {
  factory _$$_ServerCopyWith(_$_Server value, $Res Function(_$_Server) then) =
      __$$_ServerCopyWithImpl<$Res>;
  @useResult
  $Res call({int? errorCode, String? message});
}

/// @nodoc
class __$$_ServerCopyWithImpl<$Res>
    extends _$RemoteFailureCopyWithImpl<$Res, _$_Server>
    implements _$$_ServerCopyWith<$Res> {
  __$$_ServerCopyWithImpl(_$_Server _value, $Res Function(_$_Server) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorCode = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_Server(
      freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Server implements _Server {
  const _$_Server([this.errorCode, this.message]);

  @override
  final int? errorCode;
  @override
  final String? message;

  @override
  String toString() {
    return 'RemoteFailure.server(errorCode: $errorCode, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Server &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorCode, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ServerCopyWith<_$_Server> get copyWith =>
      __$$_ServerCopyWithImpl<_$_Server>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() storage,
    required TResult Function(int? errorCode, String? message) server,
    required TResult Function(String? message) parse,
    required TResult Function() noConnection,
  }) {
    return server(errorCode, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? storage,
    TResult? Function(int? errorCode, String? message)? server,
    TResult? Function(String? message)? parse,
    TResult? Function()? noConnection,
  }) {
    return server?.call(errorCode, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? storage,
    TResult Function(int? errorCode, String? message)? server,
    TResult Function(String? message)? parse,
    TResult Function()? noConnection,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(errorCode, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Storage value) storage,
    required TResult Function(_Server value) server,
    required TResult Function(_Parse value) parse,
    required TResult Function(_NoConnection value) noConnection,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Storage value)? storage,
    TResult? Function(_Server value)? server,
    TResult? Function(_Parse value)? parse,
    TResult? Function(_NoConnection value)? noConnection,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Storage value)? storage,
    TResult Function(_Server value)? server,
    TResult Function(_Parse value)? parse,
    TResult Function(_NoConnection value)? noConnection,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class _Server implements RemoteFailure {
  const factory _Server([final int? errorCode, final String? message]) =
      _$_Server;

  int? get errorCode;
  String? get message;
  @JsonKey(ignore: true)
  _$$_ServerCopyWith<_$_Server> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ParseCopyWith<$Res> {
  factory _$$_ParseCopyWith(_$_Parse value, $Res Function(_$_Parse) then) =
      __$$_ParseCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$_ParseCopyWithImpl<$Res>
    extends _$RemoteFailureCopyWithImpl<$Res, _$_Parse>
    implements _$$_ParseCopyWith<$Res> {
  __$$_ParseCopyWithImpl(_$_Parse _value, $Res Function(_$_Parse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_Parse(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Parse implements _Parse {
  const _$_Parse({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'RemoteFailure.parse(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Parse &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ParseCopyWith<_$_Parse> get copyWith =>
      __$$_ParseCopyWithImpl<_$_Parse>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() storage,
    required TResult Function(int? errorCode, String? message) server,
    required TResult Function(String? message) parse,
    required TResult Function() noConnection,
  }) {
    return parse(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? storage,
    TResult? Function(int? errorCode, String? message)? server,
    TResult? Function(String? message)? parse,
    TResult? Function()? noConnection,
  }) {
    return parse?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? storage,
    TResult Function(int? errorCode, String? message)? server,
    TResult Function(String? message)? parse,
    TResult Function()? noConnection,
    required TResult orElse(),
  }) {
    if (parse != null) {
      return parse(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Storage value) storage,
    required TResult Function(_Server value) server,
    required TResult Function(_Parse value) parse,
    required TResult Function(_NoConnection value) noConnection,
  }) {
    return parse(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Storage value)? storage,
    TResult? Function(_Server value)? server,
    TResult? Function(_Parse value)? parse,
    TResult? Function(_NoConnection value)? noConnection,
  }) {
    return parse?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Storage value)? storage,
    TResult Function(_Server value)? server,
    TResult Function(_Parse value)? parse,
    TResult Function(_NoConnection value)? noConnection,
    required TResult orElse(),
  }) {
    if (parse != null) {
      return parse(this);
    }
    return orElse();
  }
}

abstract class _Parse implements RemoteFailure {
  const factory _Parse({final String? message}) = _$_Parse;

  String? get message;
  @JsonKey(ignore: true)
  _$$_ParseCopyWith<_$_Parse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_NoConnectionCopyWith<$Res> {
  factory _$$_NoConnectionCopyWith(
          _$_NoConnection value, $Res Function(_$_NoConnection) then) =
      __$$_NoConnectionCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_NoConnectionCopyWithImpl<$Res>
    extends _$RemoteFailureCopyWithImpl<$Res, _$_NoConnection>
    implements _$$_NoConnectionCopyWith<$Res> {
  __$$_NoConnectionCopyWithImpl(
      _$_NoConnection _value, $Res Function(_$_NoConnection) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_NoConnection implements _NoConnection {
  const _$_NoConnection();

  @override
  String toString() {
    return 'RemoteFailure.noConnection()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_NoConnection);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() storage,
    required TResult Function(int? errorCode, String? message) server,
    required TResult Function(String? message) parse,
    required TResult Function() noConnection,
  }) {
    return noConnection();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? storage,
    TResult? Function(int? errorCode, String? message)? server,
    TResult? Function(String? message)? parse,
    TResult? Function()? noConnection,
  }) {
    return noConnection?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? storage,
    TResult Function(int? errorCode, String? message)? server,
    TResult Function(String? message)? parse,
    TResult Function()? noConnection,
    required TResult orElse(),
  }) {
    if (noConnection != null) {
      return noConnection();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Storage value) storage,
    required TResult Function(_Server value) server,
    required TResult Function(_Parse value) parse,
    required TResult Function(_NoConnection value) noConnection,
  }) {
    return noConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Storage value)? storage,
    TResult? Function(_Server value)? server,
    TResult? Function(_Parse value)? parse,
    TResult? Function(_NoConnection value)? noConnection,
  }) {
    return noConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Storage value)? storage,
    TResult Function(_Server value)? server,
    TResult Function(_Parse value)? parse,
    TResult Function(_NoConnection value)? noConnection,
    required TResult orElse(),
  }) {
    if (noConnection != null) {
      return noConnection(this);
    }
    return orElse();
  }
}

abstract class _NoConnection implements RemoteFailure {
  const factory _NoConnection() = _$_NoConnection;
}
