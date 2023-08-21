// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CustomerState {
  List<Customer> get customerList => throw _privateConstructorUsedError;
  int get idSelected => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  Option<Either<RemoteFailure, List<Customer>>> get FOSOCustomer =>
      throw _privateConstructorUsedError;
  Option<Either<LocalFailure, Customer>> get FOSOInsertCustomer =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomerStateCopyWith<CustomerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerStateCopyWith<$Res> {
  factory $CustomerStateCopyWith(
          CustomerState value, $Res Function(CustomerState) then) =
      _$CustomerStateCopyWithImpl<$Res, CustomerState>;
  @useResult
  $Res call(
      {List<Customer> customerList,
      int idSelected,
      int page,
      bool hasMore,
      bool isProcessing,
      Option<Either<RemoteFailure, List<Customer>>> FOSOCustomer,
      Option<Either<LocalFailure, Customer>> FOSOInsertCustomer});
}

/// @nodoc
class _$CustomerStateCopyWithImpl<$Res, $Val extends CustomerState>
    implements $CustomerStateCopyWith<$Res> {
  _$CustomerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerList = null,
    Object? idSelected = null,
    Object? page = null,
    Object? hasMore = null,
    Object? isProcessing = null,
    Object? FOSOCustomer = null,
    Object? FOSOInsertCustomer = null,
  }) {
    return _then(_value.copyWith(
      customerList: null == customerList
          ? _value.customerList
          : customerList // ignore: cast_nullable_to_non_nullable
              as List<Customer>,
      idSelected: null == idSelected
          ? _value.idSelected
          : idSelected // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOCustomer: null == FOSOCustomer
          ? _value.FOSOCustomer
          : FOSOCustomer // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<Customer>>>,
      FOSOInsertCustomer: null == FOSOInsertCustomer
          ? _value.FOSOInsertCustomer
          : FOSOInsertCustomer // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Customer>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CustomerStateCopyWith<$Res>
    implements $CustomerStateCopyWith<$Res> {
  factory _$$_CustomerStateCopyWith(
          _$_CustomerState value, $Res Function(_$_CustomerState) then) =
      __$$_CustomerStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Customer> customerList,
      int idSelected,
      int page,
      bool hasMore,
      bool isProcessing,
      Option<Either<RemoteFailure, List<Customer>>> FOSOCustomer,
      Option<Either<LocalFailure, Customer>> FOSOInsertCustomer});
}

/// @nodoc
class __$$_CustomerStateCopyWithImpl<$Res>
    extends _$CustomerStateCopyWithImpl<$Res, _$_CustomerState>
    implements _$$_CustomerStateCopyWith<$Res> {
  __$$_CustomerStateCopyWithImpl(
      _$_CustomerState _value, $Res Function(_$_CustomerState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerList = null,
    Object? idSelected = null,
    Object? page = null,
    Object? hasMore = null,
    Object? isProcessing = null,
    Object? FOSOCustomer = null,
    Object? FOSOInsertCustomer = null,
  }) {
    return _then(_$_CustomerState(
      customerList: null == customerList
          ? _value._customerList
          : customerList // ignore: cast_nullable_to_non_nullable
              as List<Customer>,
      idSelected: null == idSelected
          ? _value.idSelected
          : idSelected // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      FOSOCustomer: null == FOSOCustomer
          ? _value.FOSOCustomer
          : FOSOCustomer // ignore: cast_nullable_to_non_nullable
              as Option<Either<RemoteFailure, List<Customer>>>,
      FOSOInsertCustomer: null == FOSOInsertCustomer
          ? _value.FOSOInsertCustomer
          : FOSOInsertCustomer // ignore: cast_nullable_to_non_nullable
              as Option<Either<LocalFailure, Customer>>,
    ));
  }
}

/// @nodoc

class _$_CustomerState implements _CustomerState {
  const _$_CustomerState(
      {required final List<Customer> customerList,
      required this.idSelected,
      required this.page,
      required this.hasMore,
      required this.isProcessing,
      required this.FOSOCustomer,
      required this.FOSOInsertCustomer})
      : _customerList = customerList;

  final List<Customer> _customerList;
  @override
  List<Customer> get customerList {
    if (_customerList is EqualUnmodifiableListView) return _customerList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customerList);
  }

  @override
  final int idSelected;
  @override
  final int page;
  @override
  final bool hasMore;
  @override
  final bool isProcessing;
  @override
  final Option<Either<RemoteFailure, List<Customer>>> FOSOCustomer;
  @override
  final Option<Either<LocalFailure, Customer>> FOSOInsertCustomer;

  @override
  String toString() {
    return 'CustomerState(customerList: $customerList, idSelected: $idSelected, page: $page, hasMore: $hasMore, isProcessing: $isProcessing, FOSOCustomer: $FOSOCustomer, FOSOInsertCustomer: $FOSOInsertCustomer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CustomerState &&
            const DeepCollectionEquality()
                .equals(other._customerList, _customerList) &&
            (identical(other.idSelected, idSelected) ||
                other.idSelected == idSelected) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.FOSOCustomer, FOSOCustomer) ||
                other.FOSOCustomer == FOSOCustomer) &&
            (identical(other.FOSOInsertCustomer, FOSOInsertCustomer) ||
                other.FOSOInsertCustomer == FOSOInsertCustomer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_customerList),
      idSelected,
      page,
      hasMore,
      isProcessing,
      FOSOCustomer,
      FOSOInsertCustomer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CustomerStateCopyWith<_$_CustomerState> get copyWith =>
      __$$_CustomerStateCopyWithImpl<_$_CustomerState>(this, _$identity);
}

abstract class _CustomerState implements CustomerState {
  const factory _CustomerState(
      {required final List<Customer> customerList,
      required final int idSelected,
      required final int page,
      required final bool hasMore,
      required final bool isProcessing,
      required final Option<Either<RemoteFailure, List<Customer>>> FOSOCustomer,
      required final Option<Either<LocalFailure, Customer>>
          FOSOInsertCustomer}) = _$_CustomerState;

  @override
  List<Customer> get customerList;
  @override
  int get idSelected;
  @override
  int get page;
  @override
  bool get hasMore;
  @override
  bool get isProcessing;
  @override
  Option<Either<RemoteFailure, List<Customer>>> get FOSOCustomer;
  @override
  Option<Either<LocalFailure, Customer>> get FOSOInsertCustomer;
  @override
  @JsonKey(ignore: true)
  _$$_CustomerStateCopyWith<_$_CustomerState> get copyWith =>
      throw _privateConstructorUsedError;
}
