// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DashboardStatsModel _$DashboardStatsModelFromJson(Map<String, dynamic> json) {
  return _DashboardStatsModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardStatsModel {
  @JsonKey(name: 'total_transactions_today')
  int get totalTransaksiHariIni => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_revenue_today')
  double get totalRevenueHariIni => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_products')
  int get totalProduk => throw _privateConstructorUsedError;
  @JsonKey(name: 'pending_orders')
  int get orderPending => throw _privateConstructorUsedError;

  /// Serializes this DashboardStatsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardStatsModelCopyWith<DashboardStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStatsModelCopyWith<$Res> {
  factory $DashboardStatsModelCopyWith(
    DashboardStatsModel value,
    $Res Function(DashboardStatsModel) then,
  ) = _$DashboardStatsModelCopyWithImpl<$Res, DashboardStatsModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'total_transactions_today') int totalTransaksiHariIni,
    @JsonKey(name: 'total_revenue_today') double totalRevenueHariIni,
    @JsonKey(name: 'total_products') int totalProduk,
    @JsonKey(name: 'pending_orders') int orderPending,
  });
}

/// @nodoc
class _$DashboardStatsModelCopyWithImpl<$Res, $Val extends DashboardStatsModel>
    implements $DashboardStatsModelCopyWith<$Res> {
  _$DashboardStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTransaksiHariIni = null,
    Object? totalRevenueHariIni = null,
    Object? totalProduk = null,
    Object? orderPending = null,
  }) {
    return _then(
      _value.copyWith(
            totalTransaksiHariIni: null == totalTransaksiHariIni
                ? _value.totalTransaksiHariIni
                : totalTransaksiHariIni // ignore: cast_nullable_to_non_nullable
                      as int,
            totalRevenueHariIni: null == totalRevenueHariIni
                ? _value.totalRevenueHariIni
                : totalRevenueHariIni // ignore: cast_nullable_to_non_nullable
                      as double,
            totalProduk: null == totalProduk
                ? _value.totalProduk
                : totalProduk // ignore: cast_nullable_to_non_nullable
                      as int,
            orderPending: null == orderPending
                ? _value.orderPending
                : orderPending // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardStatsModelImplCopyWith<$Res>
    implements $DashboardStatsModelCopyWith<$Res> {
  factory _$$DashboardStatsModelImplCopyWith(
    _$DashboardStatsModelImpl value,
    $Res Function(_$DashboardStatsModelImpl) then,
  ) = __$$DashboardStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'total_transactions_today') int totalTransaksiHariIni,
    @JsonKey(name: 'total_revenue_today') double totalRevenueHariIni,
    @JsonKey(name: 'total_products') int totalProduk,
    @JsonKey(name: 'pending_orders') int orderPending,
  });
}

/// @nodoc
class __$$DashboardStatsModelImplCopyWithImpl<$Res>
    extends _$DashboardStatsModelCopyWithImpl<$Res, _$DashboardStatsModelImpl>
    implements _$$DashboardStatsModelImplCopyWith<$Res> {
  __$$DashboardStatsModelImplCopyWithImpl(
    _$DashboardStatsModelImpl _value,
    $Res Function(_$DashboardStatsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTransaksiHariIni = null,
    Object? totalRevenueHariIni = null,
    Object? totalProduk = null,
    Object? orderPending = null,
  }) {
    return _then(
      _$DashboardStatsModelImpl(
        totalTransaksiHariIni: null == totalTransaksiHariIni
            ? _value.totalTransaksiHariIni
            : totalTransaksiHariIni // ignore: cast_nullable_to_non_nullable
                  as int,
        totalRevenueHariIni: null == totalRevenueHariIni
            ? _value.totalRevenueHariIni
            : totalRevenueHariIni // ignore: cast_nullable_to_non_nullable
                  as double,
        totalProduk: null == totalProduk
            ? _value.totalProduk
            : totalProduk // ignore: cast_nullable_to_non_nullable
                  as int,
        orderPending: null == orderPending
            ? _value.orderPending
            : orderPending // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardStatsModelImpl implements _DashboardStatsModel {
  const _$DashboardStatsModelImpl({
    @JsonKey(name: 'total_transactions_today')
    required this.totalTransaksiHariIni,
    @JsonKey(name: 'total_revenue_today') required this.totalRevenueHariIni,
    @JsonKey(name: 'total_products') required this.totalProduk,
    @JsonKey(name: 'pending_orders') required this.orderPending,
  });

  factory _$DashboardStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardStatsModelImplFromJson(json);

  @override
  @JsonKey(name: 'total_transactions_today')
  final int totalTransaksiHariIni;
  @override
  @JsonKey(name: 'total_revenue_today')
  final double totalRevenueHariIni;
  @override
  @JsonKey(name: 'total_products')
  final int totalProduk;
  @override
  @JsonKey(name: 'pending_orders')
  final int orderPending;

  @override
  String toString() {
    return 'DashboardStatsModel(totalTransaksiHariIni: $totalTransaksiHariIni, totalRevenueHariIni: $totalRevenueHariIni, totalProduk: $totalProduk, orderPending: $orderPending)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStatsModelImpl &&
            (identical(other.totalTransaksiHariIni, totalTransaksiHariIni) ||
                other.totalTransaksiHariIni == totalTransaksiHariIni) &&
            (identical(other.totalRevenueHariIni, totalRevenueHariIni) ||
                other.totalRevenueHariIni == totalRevenueHariIni) &&
            (identical(other.totalProduk, totalProduk) ||
                other.totalProduk == totalProduk) &&
            (identical(other.orderPending, orderPending) ||
                other.orderPending == orderPending));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalTransaksiHariIni,
    totalRevenueHariIni,
    totalProduk,
    orderPending,
  );

  /// Create a copy of DashboardStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStatsModelImplCopyWith<_$DashboardStatsModelImpl> get copyWith =>
      __$$DashboardStatsModelImplCopyWithImpl<_$DashboardStatsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardStatsModelImplToJson(this);
  }
}

abstract class _DashboardStatsModel implements DashboardStatsModel {
  const factory _DashboardStatsModel({
    @JsonKey(name: 'total_transactions_today')
    required final int totalTransaksiHariIni,
    @JsonKey(name: 'total_revenue_today')
    required final double totalRevenueHariIni,
    @JsonKey(name: 'total_products') required final int totalProduk,
    @JsonKey(name: 'pending_orders') required final int orderPending,
  }) = _$DashboardStatsModelImpl;

  factory _DashboardStatsModel.fromJson(Map<String, dynamic> json) =
      _$DashboardStatsModelImpl.fromJson;

  @override
  @JsonKey(name: 'total_transactions_today')
  int get totalTransaksiHariIni;
  @override
  @JsonKey(name: 'total_revenue_today')
  double get totalRevenueHariIni;
  @override
  @JsonKey(name: 'total_products')
  int get totalProduk;
  @override
  @JsonKey(name: 'pending_orders')
  int get orderPending;

  /// Create a copy of DashboardStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStatsModelImplCopyWith<_$DashboardStatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
