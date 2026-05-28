// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _TransactionModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_type')
  String? get orderType => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String? get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_status')
  String? get paymentStatus => throw _privateConstructorUsedError;
  @FlexibleDoubleConverter()
  double get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_amount')
  @FlexibleNullableDoubleConverter()
  double? get paidAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total')
  @FlexibleNullableDoubleConverter()
  double? get grandTotal => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_number')
  String? get tableNumber => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  UserSummaryModel? get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  List<OrderItemModel> get details => throw _privateConstructorUsedError;

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
    TransactionModel value,
    $Res Function(TransactionModel) then,
  ) = _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'order_type') String? orderType,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'payment_status') String? paymentStatus,
    @FlexibleDoubleConverter() double total,
    @JsonKey(name: 'paid_amount')
    @FlexibleNullableDoubleConverter()
    double? paidAmount,
    @JsonKey(name: 'grand_total')
    @FlexibleNullableDoubleConverter()
    double? grandTotal,
    String status,
    @JsonKey(name: 'table_number') String? tableNumber,
    String? notes,
    UserSummaryModel? user,
    @JsonKey(name: 'created_at') String createdAt,
    List<OrderItemModel> details,
  });

  $UserSummaryModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? orderType = freezed,
    Object? paymentMethod = freezed,
    Object? paymentStatus = freezed,
    Object? total = null,
    Object? paidAmount = freezed,
    Object? grandTotal = freezed,
    Object? status = null,
    Object? tableNumber = freezed,
    Object? notes = freezed,
    Object? user = freezed,
    Object? createdAt = null,
    Object? details = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int?,
            orderType: freezed == orderType
                ? _value.orderType
                : orderType // ignore: cast_nullable_to_non_nullable
                      as String?,
            paymentMethod: freezed == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String?,
            paymentStatus: freezed == paymentStatus
                ? _value.paymentStatus
                : paymentStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
            paidAmount: freezed == paidAmount
                ? _value.paidAmount
                : paidAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            grandTotal: freezed == grandTotal
                ? _value.grandTotal
                : grandTotal // ignore: cast_nullable_to_non_nullable
                      as double?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            tableNumber: freezed == tableNumber
                ? _value.tableNumber
                : tableNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as UserSummaryModel?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            details: null == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as List<OrderItemModel>,
          )
          as $Val,
    );
  }

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserSummaryModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransactionModelImplCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$TransactionModelImplCopyWith(
    _$TransactionModelImpl value,
    $Res Function(_$TransactionModelImpl) then,
  ) = __$$TransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'order_type') String? orderType,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'payment_status') String? paymentStatus,
    @FlexibleDoubleConverter() double total,
    @JsonKey(name: 'paid_amount')
    @FlexibleNullableDoubleConverter()
    double? paidAmount,
    @JsonKey(name: 'grand_total')
    @FlexibleNullableDoubleConverter()
    double? grandTotal,
    String status,
    @JsonKey(name: 'table_number') String? tableNumber,
    String? notes,
    UserSummaryModel? user,
    @JsonKey(name: 'created_at') String createdAt,
    List<OrderItemModel> details,
  });

  @override
  $UserSummaryModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$TransactionModelImplCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$TransactionModelImpl>
    implements _$$TransactionModelImplCopyWith<$Res> {
  __$$TransactionModelImplCopyWithImpl(
    _$TransactionModelImpl _value,
    $Res Function(_$TransactionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? orderType = freezed,
    Object? paymentMethod = freezed,
    Object? paymentStatus = freezed,
    Object? total = null,
    Object? paidAmount = freezed,
    Object? grandTotal = freezed,
    Object? status = null,
    Object? tableNumber = freezed,
    Object? notes = freezed,
    Object? user = freezed,
    Object? createdAt = null,
    Object? details = null,
  }) {
    return _then(
      _$TransactionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int?,
        orderType: freezed == orderType
            ? _value.orderType
            : orderType // ignore: cast_nullable_to_non_nullable
                  as String?,
        paymentMethod: freezed == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String?,
        paymentStatus: freezed == paymentStatus
            ? _value.paymentStatus
            : paymentStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
        paidAmount: freezed == paidAmount
            ? _value.paidAmount
            : paidAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        grandTotal: freezed == grandTotal
            ? _value.grandTotal
            : grandTotal // ignore: cast_nullable_to_non_nullable
                  as double?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        tableNumber: freezed == tableNumber
            ? _value.tableNumber
            : tableNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as UserSummaryModel?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        details: null == details
            ? _value._details
            : details // ignore: cast_nullable_to_non_nullable
                  as List<OrderItemModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionModelImpl extends _TransactionModel {
  const _$TransactionModelImpl({
    required this.id,
    @JsonKey(name: 'user_id') this.userId,
    @JsonKey(name: 'order_type') this.orderType,
    @JsonKey(name: 'payment_method') this.paymentMethod,
    @JsonKey(name: 'payment_status') this.paymentStatus,
    @FlexibleDoubleConverter() required this.total,
    @JsonKey(name: 'paid_amount')
    @FlexibleNullableDoubleConverter()
    this.paidAmount,
    @JsonKey(name: 'grand_total')
    @FlexibleNullableDoubleConverter()
    this.grandTotal,
    required this.status,
    @JsonKey(name: 'table_number') this.tableNumber,
    this.notes,
    this.user,
    @JsonKey(name: 'created_at') required this.createdAt,
    final List<OrderItemModel> details = const <OrderItemModel>[],
  }) : _details = details,
       super._();

  factory _$TransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  @JsonKey(name: 'order_type')
  final String? orderType;
  @override
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @override
  @JsonKey(name: 'payment_status')
  final String? paymentStatus;
  @override
  @FlexibleDoubleConverter()
  final double total;
  @override
  @JsonKey(name: 'paid_amount')
  @FlexibleNullableDoubleConverter()
  final double? paidAmount;
  @override
  @JsonKey(name: 'grand_total')
  @FlexibleNullableDoubleConverter()
  final double? grandTotal;
  @override
  final String status;
  @override
  @JsonKey(name: 'table_number')
  final String? tableNumber;
  @override
  final String? notes;
  @override
  final UserSummaryModel? user;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  final List<OrderItemModel> _details;
  @override
  @JsonKey()
  List<OrderItemModel> get details {
    if (_details is EqualUnmodifiableListView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_details);
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, userId: $userId, orderType: $orderType, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, total: $total, paidAmount: $paidAmount, grandTotal: $grandTotal, status: $status, tableNumber: $tableNumber, notes: $notes, user: $user, createdAt: $createdAt, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tableNumber, tableNumber) ||
                other.tableNumber == tableNumber) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._details, _details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    orderType,
    paymentMethod,
    paymentStatus,
    total,
    paidAmount,
    grandTotal,
    status,
    tableNumber,
    notes,
    user,
    createdAt,
    const DeepCollectionEquality().hash(_details),
  );

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      __$$TransactionModelImplCopyWithImpl<_$TransactionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionModelImplToJson(this);
  }
}

abstract class _TransactionModel extends TransactionModel {
  const factory _TransactionModel({
    required final int id,
    @JsonKey(name: 'user_id') final int? userId,
    @JsonKey(name: 'order_type') final String? orderType,
    @JsonKey(name: 'payment_method') final String? paymentMethod,
    @JsonKey(name: 'payment_status') final String? paymentStatus,
    @FlexibleDoubleConverter() required final double total,
    @JsonKey(name: 'paid_amount')
    @FlexibleNullableDoubleConverter()
    final double? paidAmount,
    @JsonKey(name: 'grand_total')
    @FlexibleNullableDoubleConverter()
    final double? grandTotal,
    required final String status,
    @JsonKey(name: 'table_number') final String? tableNumber,
    final String? notes,
    final UserSummaryModel? user,
    @JsonKey(name: 'created_at') required final String createdAt,
    final List<OrderItemModel> details,
  }) = _$TransactionModelImpl;
  const _TransactionModel._() : super._();

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$TransactionModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  int? get userId;
  @override
  @JsonKey(name: 'order_type')
  String? get orderType;
  @override
  @JsonKey(name: 'payment_method')
  String? get paymentMethod;
  @override
  @JsonKey(name: 'payment_status')
  String? get paymentStatus;
  @override
  @FlexibleDoubleConverter()
  double get total;
  @override
  @JsonKey(name: 'paid_amount')
  @FlexibleNullableDoubleConverter()
  double? get paidAmount;
  @override
  @JsonKey(name: 'grand_total')
  @FlexibleNullableDoubleConverter()
  double? get grandTotal;
  @override
  String get status;
  @override
  @JsonKey(name: 'table_number')
  String? get tableNumber;
  @override
  String? get notes;
  @override
  UserSummaryModel? get user;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  List<OrderItemModel> get details;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
