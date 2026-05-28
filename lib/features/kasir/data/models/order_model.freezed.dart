// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return _OrderModel.fromJson(json);
}

/// @nodoc
mixin _$OrderModel {
  @JsonKey(readValue: _readOrderId)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int? get userId => throw _privateConstructorUsedError;
  @JsonKey(readValue: _readTotalAmount)
  @FlexibleDoubleConverter()
  double get totalAmount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_type')
  String? get orderType => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String? get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_status')
  String? get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_proof')
  String? get paymentProof => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_proof_url')
  String? get paymentProofUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_number')
  String? get tableNumber => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  UserSummaryModel? get user => throw _privateConstructorUsedError;
  DeliveryModel? get delivery => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(readValue: _readItemCount)
  int? get itemCount => throw _privateConstructorUsedError;
  List<OrderItemModel> get details => throw _privateConstructorUsedError;

  /// Serializes this OrderModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderModelCopyWith<OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderModelCopyWith<$Res> {
  factory $OrderModelCopyWith(
    OrderModel value,
    $Res Function(OrderModel) then,
  ) = _$OrderModelCopyWithImpl<$Res, OrderModel>;
  @useResult
  $Res call({
    @JsonKey(readValue: _readOrderId) int id,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(readValue: _readTotalAmount)
    @FlexibleDoubleConverter()
    double totalAmount,
    String status,
    @JsonKey(name: 'order_type') String? orderType,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'payment_status') String? paymentStatus,
    @JsonKey(name: 'payment_proof') String? paymentProof,
    @JsonKey(name: 'payment_proof_url') String? paymentProofUrl,
    @JsonKey(name: 'table_number') String? tableNumber,
    String? notes,
    UserSummaryModel? user,
    DeliveryModel? delivery,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(readValue: _readItemCount) int? itemCount,
    List<OrderItemModel> details,
  });

  $UserSummaryModelCopyWith<$Res>? get user;
  $DeliveryModelCopyWith<$Res>? get delivery;
}

/// @nodoc
class _$OrderModelCopyWithImpl<$Res, $Val extends OrderModel>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? totalAmount = null,
    Object? status = null,
    Object? orderType = freezed,
    Object? paymentMethod = freezed,
    Object? paymentStatus = freezed,
    Object? paymentProof = freezed,
    Object? paymentProofUrl = freezed,
    Object? tableNumber = freezed,
    Object? notes = freezed,
    Object? user = freezed,
    Object? delivery = freezed,
    Object? createdAt = null,
    Object? itemCount = freezed,
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
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
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
            paymentProof: freezed == paymentProof
                ? _value.paymentProof
                : paymentProof // ignore: cast_nullable_to_non_nullable
                      as String?,
            paymentProofUrl: freezed == paymentProofUrl
                ? _value.paymentProofUrl
                : paymentProofUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            delivery: freezed == delivery
                ? _value.delivery
                : delivery // ignore: cast_nullable_to_non_nullable
                      as DeliveryModel?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            itemCount: freezed == itemCount
                ? _value.itemCount
                : itemCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            details: null == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as List<OrderItemModel>,
          )
          as $Val,
    );
  }

  /// Create a copy of OrderModel
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

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeliveryModelCopyWith<$Res>? get delivery {
    if (_value.delivery == null) {
      return null;
    }

    return $DeliveryModelCopyWith<$Res>(_value.delivery!, (value) {
      return _then(_value.copyWith(delivery: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderModelImplCopyWith<$Res>
    implements $OrderModelCopyWith<$Res> {
  factory _$$OrderModelImplCopyWith(
    _$OrderModelImpl value,
    $Res Function(_$OrderModelImpl) then,
  ) = __$$OrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(readValue: _readOrderId) int id,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(readValue: _readTotalAmount)
    @FlexibleDoubleConverter()
    double totalAmount,
    String status,
    @JsonKey(name: 'order_type') String? orderType,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'payment_status') String? paymentStatus,
    @JsonKey(name: 'payment_proof') String? paymentProof,
    @JsonKey(name: 'payment_proof_url') String? paymentProofUrl,
    @JsonKey(name: 'table_number') String? tableNumber,
    String? notes,
    UserSummaryModel? user,
    DeliveryModel? delivery,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(readValue: _readItemCount) int? itemCount,
    List<OrderItemModel> details,
  });

  @override
  $UserSummaryModelCopyWith<$Res>? get user;
  @override
  $DeliveryModelCopyWith<$Res>? get delivery;
}

/// @nodoc
class __$$OrderModelImplCopyWithImpl<$Res>
    extends _$OrderModelCopyWithImpl<$Res, _$OrderModelImpl>
    implements _$$OrderModelImplCopyWith<$Res> {
  __$$OrderModelImplCopyWithImpl(
    _$OrderModelImpl _value,
    $Res Function(_$OrderModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? totalAmount = null,
    Object? status = null,
    Object? orderType = freezed,
    Object? paymentMethod = freezed,
    Object? paymentStatus = freezed,
    Object? paymentProof = freezed,
    Object? paymentProofUrl = freezed,
    Object? tableNumber = freezed,
    Object? notes = freezed,
    Object? user = freezed,
    Object? delivery = freezed,
    Object? createdAt = null,
    Object? itemCount = freezed,
    Object? details = null,
  }) {
    return _then(
      _$OrderModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
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
        paymentProof: freezed == paymentProof
            ? _value.paymentProof
            : paymentProof // ignore: cast_nullable_to_non_nullable
                  as String?,
        paymentProofUrl: freezed == paymentProofUrl
            ? _value.paymentProofUrl
            : paymentProofUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        delivery: freezed == delivery
            ? _value.delivery
            : delivery // ignore: cast_nullable_to_non_nullable
                  as DeliveryModel?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        itemCount: freezed == itemCount
            ? _value.itemCount
            : itemCount // ignore: cast_nullable_to_non_nullable
                  as int?,
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
class _$OrderModelImpl extends _OrderModel {
  const _$OrderModelImpl({
    @JsonKey(readValue: _readOrderId) required this.id,
    @JsonKey(name: 'user_id') this.userId,
    @JsonKey(readValue: _readTotalAmount)
    @FlexibleDoubleConverter()
    required this.totalAmount,
    this.status = 'pending',
    @JsonKey(name: 'order_type') this.orderType,
    @JsonKey(name: 'payment_method') this.paymentMethod,
    @JsonKey(name: 'payment_status') this.paymentStatus,
    @JsonKey(name: 'payment_proof') this.paymentProof,
    @JsonKey(name: 'payment_proof_url') this.paymentProofUrl,
    @JsonKey(name: 'table_number') this.tableNumber,
    this.notes,
    this.user,
    this.delivery,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(readValue: _readItemCount) this.itemCount,
    final List<OrderItemModel> details = const <OrderItemModel>[],
  }) : _details = details,
       super._();

  factory _$OrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderModelImplFromJson(json);

  @override
  @JsonKey(readValue: _readOrderId)
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  @JsonKey(readValue: _readTotalAmount)
  @FlexibleDoubleConverter()
  final double totalAmount;
  @override
  @JsonKey()
  final String status;
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
  @JsonKey(name: 'payment_proof')
  final String? paymentProof;
  @override
  @JsonKey(name: 'payment_proof_url')
  final String? paymentProofUrl;
  @override
  @JsonKey(name: 'table_number')
  final String? tableNumber;
  @override
  final String? notes;
  @override
  final UserSummaryModel? user;
  @override
  final DeliveryModel? delivery;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(readValue: _readItemCount)
  final int? itemCount;
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
    return 'OrderModel(id: $id, userId: $userId, totalAmount: $totalAmount, status: $status, orderType: $orderType, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, paymentProof: $paymentProof, paymentProofUrl: $paymentProofUrl, tableNumber: $tableNumber, notes: $notes, user: $user, delivery: $delivery, createdAt: $createdAt, itemCount: $itemCount, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.paymentProof, paymentProof) ||
                other.paymentProof == paymentProof) &&
            (identical(other.paymentProofUrl, paymentProofUrl) ||
                other.paymentProofUrl == paymentProofUrl) &&
            (identical(other.tableNumber, tableNumber) ||
                other.tableNumber == tableNumber) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.delivery, delivery) ||
                other.delivery == delivery) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            const DeepCollectionEquality().equals(other._details, _details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    totalAmount,
    status,
    orderType,
    paymentMethod,
    paymentStatus,
    paymentProof,
    paymentProofUrl,
    tableNumber,
    notes,
    user,
    delivery,
    createdAt,
    itemCount,
    const DeepCollectionEquality().hash(_details),
  );

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      __$$OrderModelImplCopyWithImpl<_$OrderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderModelImplToJson(this);
  }
}

abstract class _OrderModel extends OrderModel {
  const factory _OrderModel({
    @JsonKey(readValue: _readOrderId) required final int id,
    @JsonKey(name: 'user_id') final int? userId,
    @JsonKey(readValue: _readTotalAmount)
    @FlexibleDoubleConverter()
    required final double totalAmount,
    final String status,
    @JsonKey(name: 'order_type') final String? orderType,
    @JsonKey(name: 'payment_method') final String? paymentMethod,
    @JsonKey(name: 'payment_status') final String? paymentStatus,
    @JsonKey(name: 'payment_proof') final String? paymentProof,
    @JsonKey(name: 'payment_proof_url') final String? paymentProofUrl,
    @JsonKey(name: 'table_number') final String? tableNumber,
    final String? notes,
    final UserSummaryModel? user,
    final DeliveryModel? delivery,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(readValue: _readItemCount) final int? itemCount,
    final List<OrderItemModel> details,
  }) = _$OrderModelImpl;
  const _OrderModel._() : super._();

  factory _OrderModel.fromJson(Map<String, dynamic> json) =
      _$OrderModelImpl.fromJson;

  @override
  @JsonKey(readValue: _readOrderId)
  int get id;
  @override
  @JsonKey(name: 'user_id')
  int? get userId;
  @override
  @JsonKey(readValue: _readTotalAmount)
  @FlexibleDoubleConverter()
  double get totalAmount;
  @override
  String get status;
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
  @JsonKey(name: 'payment_proof')
  String? get paymentProof;
  @override
  @JsonKey(name: 'payment_proof_url')
  String? get paymentProofUrl;
  @override
  @JsonKey(name: 'table_number')
  String? get tableNumber;
  @override
  String? get notes;
  @override
  UserSummaryModel? get user;
  @override
  DeliveryModel? get delivery;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(readValue: _readItemCount)
  int? get itemCount;
  @override
  List<OrderItemModel> get details;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSummaryModel _$UserSummaryModelFromJson(Map<String, dynamic> json) {
  return _UserSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$UserSummaryModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;

  /// Serializes this UserSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSummaryModelCopyWith<UserSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSummaryModelCopyWith<$Res> {
  factory $UserSummaryModelCopyWith(
    UserSummaryModel value,
    $Res Function(UserSummaryModel) then,
  ) = _$UserSummaryModelCopyWithImpl<$Res, UserSummaryModel>;
  @useResult
  $Res call({int id, String name, String? email, String? role});
}

/// @nodoc
class _$UserSummaryModelCopyWithImpl<$Res, $Val extends UserSummaryModel>
    implements $UserSummaryModelCopyWith<$Res> {
  _$UserSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? role = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSummaryModelImplCopyWith<$Res>
    implements $UserSummaryModelCopyWith<$Res> {
  factory _$$UserSummaryModelImplCopyWith(
    _$UserSummaryModelImpl value,
    $Res Function(_$UserSummaryModelImpl) then,
  ) = __$$UserSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? email, String? role});
}

/// @nodoc
class __$$UserSummaryModelImplCopyWithImpl<$Res>
    extends _$UserSummaryModelCopyWithImpl<$Res, _$UserSummaryModelImpl>
    implements _$$UserSummaryModelImplCopyWith<$Res> {
  __$$UserSummaryModelImplCopyWithImpl(
    _$UserSummaryModelImpl _value,
    $Res Function(_$UserSummaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? role = freezed,
  }) {
    return _then(
      _$UserSummaryModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSummaryModelImpl implements _UserSummaryModel {
  const _$UserSummaryModelImpl({
    required this.id,
    required this.name,
    this.email,
    this.role,
  });

  factory _$UserSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSummaryModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? email;
  @override
  final String? role;

  @override
  String toString() {
    return 'UserSummaryModel(id: $id, name: $name, email: $email, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSummaryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, role);

  /// Create a copy of UserSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSummaryModelImplCopyWith<_$UserSummaryModelImpl> get copyWith =>
      __$$UserSummaryModelImplCopyWithImpl<_$UserSummaryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSummaryModelImplToJson(this);
  }
}

abstract class _UserSummaryModel implements UserSummaryModel {
  const factory _UserSummaryModel({
    required final int id,
    required final String name,
    final String? email,
    final String? role,
  }) = _$UserSummaryModelImpl;

  factory _UserSummaryModel.fromJson(Map<String, dynamic> json) =
      _$UserSummaryModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get email;
  @override
  String? get role;

  /// Create a copy of UserSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSummaryModelImplCopyWith<_$UserSummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeliveryModel _$DeliveryModelFromJson(Map<String, dynamic> json) {
  return _DeliveryModel.fromJson(json);
}

/// @nodoc
mixin _$DeliveryModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_id')
  int? get transactionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'recipient_name')
  String? get recipientName => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @FlexibleNullableDoubleConverter()
  double? get latitude => throw _privateConstructorUsedError;
  @FlexibleNullableDoubleConverter()
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_fee')
  @FlexibleNullableDoubleConverter()
  double? get deliveryFee => throw _privateConstructorUsedError;

  /// Serializes this DeliveryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeliveryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliveryModelCopyWith<DeliveryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryModelCopyWith<$Res> {
  factory $DeliveryModelCopyWith(
    DeliveryModel value,
    $Res Function(DeliveryModel) then,
  ) = _$DeliveryModelCopyWithImpl<$Res, DeliveryModel>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'transaction_id') int? transactionId,
    @JsonKey(name: 'recipient_name') String? recipientName,
    String? address,
    String? phone,
    String? status,
    String? notes,
    @FlexibleNullableDoubleConverter() double? latitude,
    @FlexibleNullableDoubleConverter() double? longitude,
    @JsonKey(name: 'delivery_fee')
    @FlexibleNullableDoubleConverter()
    double? deliveryFee,
  });
}

/// @nodoc
class _$DeliveryModelCopyWithImpl<$Res, $Val extends DeliveryModel>
    implements $DeliveryModelCopyWith<$Res> {
  _$DeliveryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeliveryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? transactionId = freezed,
    Object? recipientName = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? status = freezed,
    Object? notes = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? deliveryFee = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            transactionId: freezed == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as int?,
            recipientName: freezed == recipientName
                ? _value.recipientName
                : recipientName // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            deliveryFee: freezed == deliveryFee
                ? _value.deliveryFee
                : deliveryFee // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeliveryModelImplCopyWith<$Res>
    implements $DeliveryModelCopyWith<$Res> {
  factory _$$DeliveryModelImplCopyWith(
    _$DeliveryModelImpl value,
    $Res Function(_$DeliveryModelImpl) then,
  ) = __$$DeliveryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'transaction_id') int? transactionId,
    @JsonKey(name: 'recipient_name') String? recipientName,
    String? address,
    String? phone,
    String? status,
    String? notes,
    @FlexibleNullableDoubleConverter() double? latitude,
    @FlexibleNullableDoubleConverter() double? longitude,
    @JsonKey(name: 'delivery_fee')
    @FlexibleNullableDoubleConverter()
    double? deliveryFee,
  });
}

/// @nodoc
class __$$DeliveryModelImplCopyWithImpl<$Res>
    extends _$DeliveryModelCopyWithImpl<$Res, _$DeliveryModelImpl>
    implements _$$DeliveryModelImplCopyWith<$Res> {
  __$$DeliveryModelImplCopyWithImpl(
    _$DeliveryModelImpl _value,
    $Res Function(_$DeliveryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeliveryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? transactionId = freezed,
    Object? recipientName = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? status = freezed,
    Object? notes = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? deliveryFee = freezed,
  }) {
    return _then(
      _$DeliveryModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        transactionId: freezed == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as int?,
        recipientName: freezed == recipientName
            ? _value.recipientName
            : recipientName // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        deliveryFee: freezed == deliveryFee
            ? _value.deliveryFee
            : deliveryFee // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeliveryModelImpl implements _DeliveryModel {
  const _$DeliveryModelImpl({
    required this.id,
    @JsonKey(name: 'transaction_id') this.transactionId,
    @JsonKey(name: 'recipient_name') this.recipientName,
    this.address,
    this.phone,
    this.status,
    this.notes,
    @FlexibleNullableDoubleConverter() this.latitude,
    @FlexibleNullableDoubleConverter() this.longitude,
    @JsonKey(name: 'delivery_fee')
    @FlexibleNullableDoubleConverter()
    this.deliveryFee,
  });

  factory _$DeliveryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliveryModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'transaction_id')
  final int? transactionId;
  @override
  @JsonKey(name: 'recipient_name')
  final String? recipientName;
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final String? status;
  @override
  final String? notes;
  @override
  @FlexibleNullableDoubleConverter()
  final double? latitude;
  @override
  @FlexibleNullableDoubleConverter()
  final double? longitude;
  @override
  @JsonKey(name: 'delivery_fee')
  @FlexibleNullableDoubleConverter()
  final double? deliveryFee;

  @override
  String toString() {
    return 'DeliveryModel(id: $id, transactionId: $transactionId, recipientName: $recipientName, address: $address, phone: $phone, status: $status, notes: $notes, latitude: $latitude, longitude: $longitude, deliveryFee: $deliveryFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.deliveryFee, deliveryFee) ||
                other.deliveryFee == deliveryFee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    transactionId,
    recipientName,
    address,
    phone,
    status,
    notes,
    latitude,
    longitude,
    deliveryFee,
  );

  /// Create a copy of DeliveryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryModelImplCopyWith<_$DeliveryModelImpl> get copyWith =>
      __$$DeliveryModelImplCopyWithImpl<_$DeliveryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliveryModelImplToJson(this);
  }
}

abstract class _DeliveryModel implements DeliveryModel {
  const factory _DeliveryModel({
    required final int id,
    @JsonKey(name: 'transaction_id') final int? transactionId,
    @JsonKey(name: 'recipient_name') final String? recipientName,
    final String? address,
    final String? phone,
    final String? status,
    final String? notes,
    @FlexibleNullableDoubleConverter() final double? latitude,
    @FlexibleNullableDoubleConverter() final double? longitude,
    @JsonKey(name: 'delivery_fee')
    @FlexibleNullableDoubleConverter()
    final double? deliveryFee,
  }) = _$DeliveryModelImpl;

  factory _DeliveryModel.fromJson(Map<String, dynamic> json) =
      _$DeliveryModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'transaction_id')
  int? get transactionId;
  @override
  @JsonKey(name: 'recipient_name')
  String? get recipientName;
  @override
  String? get address;
  @override
  String? get phone;
  @override
  String? get status;
  @override
  String? get notes;
  @override
  @FlexibleNullableDoubleConverter()
  double? get latitude;
  @override
  @FlexibleNullableDoubleConverter()
  double? get longitude;
  @override
  @JsonKey(name: 'delivery_fee')
  @FlexibleNullableDoubleConverter()
  double? get deliveryFee;

  /// Create a copy of DeliveryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryModelImplCopyWith<_$DeliveryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) {
  return _OrderItemModel.fromJson(json);
}

/// @nodoc
mixin _$OrderItemModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_id')
  int? get transactionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int? get productId => throw _privateConstructorUsedError;
  @FlexibleIntConverter()
  int get quantity => throw _privateConstructorUsedError;
  @FlexibleDoubleConverter()
  double get subtotal => throw _privateConstructorUsedError;
  OrderItemProductModel? get product => throw _privateConstructorUsedError;

  /// Serializes this OrderItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemModelCopyWith<OrderItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemModelCopyWith<$Res> {
  factory $OrderItemModelCopyWith(
    OrderItemModel value,
    $Res Function(OrderItemModel) then,
  ) = _$OrderItemModelCopyWithImpl<$Res, OrderItemModel>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'transaction_id') int? transactionId,
    @JsonKey(name: 'product_id') int? productId,
    @FlexibleIntConverter() int quantity,
    @FlexibleDoubleConverter() double subtotal,
    OrderItemProductModel? product,
  });

  $OrderItemProductModelCopyWith<$Res>? get product;
}

/// @nodoc
class _$OrderItemModelCopyWithImpl<$Res, $Val extends OrderItemModel>
    implements $OrderItemModelCopyWith<$Res> {
  _$OrderItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? transactionId = freezed,
    Object? productId = freezed,
    Object? quantity = null,
    Object? subtotal = null,
    Object? product = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            transactionId: freezed == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as int?,
            productId: freezed == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as int?,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            subtotal: null == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                      as double,
            product: freezed == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                      as OrderItemProductModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of OrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderItemProductModelCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $OrderItemProductModelCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderItemModelImplCopyWith<$Res>
    implements $OrderItemModelCopyWith<$Res> {
  factory _$$OrderItemModelImplCopyWith(
    _$OrderItemModelImpl value,
    $Res Function(_$OrderItemModelImpl) then,
  ) = __$$OrderItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'transaction_id') int? transactionId,
    @JsonKey(name: 'product_id') int? productId,
    @FlexibleIntConverter() int quantity,
    @FlexibleDoubleConverter() double subtotal,
    OrderItemProductModel? product,
  });

  @override
  $OrderItemProductModelCopyWith<$Res>? get product;
}

/// @nodoc
class __$$OrderItemModelImplCopyWithImpl<$Res>
    extends _$OrderItemModelCopyWithImpl<$Res, _$OrderItemModelImpl>
    implements _$$OrderItemModelImplCopyWith<$Res> {
  __$$OrderItemModelImplCopyWithImpl(
    _$OrderItemModelImpl _value,
    $Res Function(_$OrderItemModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? transactionId = freezed,
    Object? productId = freezed,
    Object? quantity = null,
    Object? subtotal = null,
    Object? product = freezed,
  }) {
    return _then(
      _$OrderItemModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        transactionId: freezed == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as int?,
        productId: freezed == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as int?,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        subtotal: null == subtotal
            ? _value.subtotal
            : subtotal // ignore: cast_nullable_to_non_nullable
                  as double,
        product: freezed == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as OrderItemProductModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderItemModelImpl extends _OrderItemModel {
  const _$OrderItemModelImpl({
    required this.id,
    @JsonKey(name: 'transaction_id') this.transactionId,
    @JsonKey(name: 'product_id') this.productId,
    @FlexibleIntConverter() required this.quantity,
    @FlexibleDoubleConverter() required this.subtotal,
    this.product,
  }) : super._();

  factory _$OrderItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'transaction_id')
  final int? transactionId;
  @override
  @JsonKey(name: 'product_id')
  final int? productId;
  @override
  @FlexibleIntConverter()
  final int quantity;
  @override
  @FlexibleDoubleConverter()
  final double subtotal;
  @override
  final OrderItemProductModel? product;

  @override
  String toString() {
    return 'OrderItemModel(id: $id, transactionId: $transactionId, productId: $productId, quantity: $quantity, subtotal: $subtotal, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    transactionId,
    productId,
    quantity,
    subtotal,
    product,
  );

  /// Create a copy of OrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemModelImplCopyWith<_$OrderItemModelImpl> get copyWith =>
      __$$OrderItemModelImplCopyWithImpl<_$OrderItemModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemModelImplToJson(this);
  }
}

abstract class _OrderItemModel extends OrderItemModel {
  const factory _OrderItemModel({
    required final int id,
    @JsonKey(name: 'transaction_id') final int? transactionId,
    @JsonKey(name: 'product_id') final int? productId,
    @FlexibleIntConverter() required final int quantity,
    @FlexibleDoubleConverter() required final double subtotal,
    final OrderItemProductModel? product,
  }) = _$OrderItemModelImpl;
  const _OrderItemModel._() : super._();

  factory _OrderItemModel.fromJson(Map<String, dynamic> json) =
      _$OrderItemModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'transaction_id')
  int? get transactionId;
  @override
  @JsonKey(name: 'product_id')
  int? get productId;
  @override
  @FlexibleIntConverter()
  int get quantity;
  @override
  @FlexibleDoubleConverter()
  double get subtotal;
  @override
  OrderItemProductModel? get product;

  /// Create a copy of OrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemModelImplCopyWith<_$OrderItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderItemProductModel _$OrderItemProductModelFromJson(
  Map<String, dynamic> json,
) {
  return _OrderItemProductModel.fromJson(json);
}

/// @nodoc
mixin _$OrderItemProductModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  @FlexibleNullableDoubleConverter()
  double? get price => throw _privateConstructorUsedError;
  @FlexibleNullableIntConverter()
  int? get stock => throw _privateConstructorUsedError;

  /// Serializes this OrderItemProductModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderItemProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemProductModelCopyWith<OrderItemProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemProductModelCopyWith<$Res> {
  factory $OrderItemProductModelCopyWith(
    OrderItemProductModel value,
    $Res Function(OrderItemProductModel) then,
  ) = _$OrderItemProductModelCopyWithImpl<$Res, OrderItemProductModel>;
  @useResult
  $Res call({
    int id,
    String name,
    String? category,
    @FlexibleNullableDoubleConverter() double? price,
    @FlexibleNullableIntConverter() int? stock,
  });
}

/// @nodoc
class _$OrderItemProductModelCopyWithImpl<
  $Res,
  $Val extends OrderItemProductModel
>
    implements $OrderItemProductModelCopyWith<$Res> {
  _$OrderItemProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItemProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = freezed,
    Object? price = freezed,
    Object? stock = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double?,
            stock: freezed == stock
                ? _value.stock
                : stock // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderItemProductModelImplCopyWith<$Res>
    implements $OrderItemProductModelCopyWith<$Res> {
  factory _$$OrderItemProductModelImplCopyWith(
    _$OrderItemProductModelImpl value,
    $Res Function(_$OrderItemProductModelImpl) then,
  ) = __$$OrderItemProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? category,
    @FlexibleNullableDoubleConverter() double? price,
    @FlexibleNullableIntConverter() int? stock,
  });
}

/// @nodoc
class __$$OrderItemProductModelImplCopyWithImpl<$Res>
    extends
        _$OrderItemProductModelCopyWithImpl<$Res, _$OrderItemProductModelImpl>
    implements _$$OrderItemProductModelImplCopyWith<$Res> {
  __$$OrderItemProductModelImplCopyWithImpl(
    _$OrderItemProductModelImpl _value,
    $Res Function(_$OrderItemProductModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderItemProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = freezed,
    Object? price = freezed,
    Object? stock = freezed,
  }) {
    return _then(
      _$OrderItemProductModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double?,
        stock: freezed == stock
            ? _value.stock
            : stock // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderItemProductModelImpl implements _OrderItemProductModel {
  const _$OrderItemProductModelImpl({
    required this.id,
    required this.name,
    this.category,
    @FlexibleNullableDoubleConverter() this.price,
    @FlexibleNullableIntConverter() this.stock,
  });

  factory _$OrderItemProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemProductModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? category;
  @override
  @FlexibleNullableDoubleConverter()
  final double? price;
  @override
  @FlexibleNullableIntConverter()
  final int? stock;

  @override
  String toString() {
    return 'OrderItemProductModel(id: $id, name: $name, category: $category, price: $price, stock: $stock)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.stock, stock) || other.stock == stock));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, category, price, stock);

  /// Create a copy of OrderItemProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemProductModelImplCopyWith<_$OrderItemProductModelImpl>
  get copyWith =>
      __$$OrderItemProductModelImplCopyWithImpl<_$OrderItemProductModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemProductModelImplToJson(this);
  }
}

abstract class _OrderItemProductModel implements OrderItemProductModel {
  const factory _OrderItemProductModel({
    required final int id,
    required final String name,
    final String? category,
    @FlexibleNullableDoubleConverter() final double? price,
    @FlexibleNullableIntConverter() final int? stock,
  }) = _$OrderItemProductModelImpl;

  factory _OrderItemProductModel.fromJson(Map<String, dynamic> json) =
      _$OrderItemProductModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get category;
  @override
  @FlexibleNullableDoubleConverter()
  double? get price;
  @override
  @FlexibleNullableIntConverter()
  int? get stock;

  /// Create a copy of OrderItemProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemProductModelImplCopyWith<_$OrderItemProductModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
