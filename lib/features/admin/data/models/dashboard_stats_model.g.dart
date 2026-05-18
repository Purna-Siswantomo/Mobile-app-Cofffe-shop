// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardStatsModelImpl _$$DashboardStatsModelImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardStatsModelImpl(
  totalTransaksiHariIni: (json['total_transactions_today'] as num).toInt(),
  totalRevenueHariIni: (json['total_revenue_today'] as num).toDouble(),
  totalProduk: (json['total_products'] as num).toInt(),
  orderPending: (json['pending_orders'] as num).toInt(),
);

Map<String, dynamic> _$$DashboardStatsModelImplToJson(
  _$DashboardStatsModelImpl instance,
) => <String, dynamic>{
  'total_transactions_today': instance.totalTransaksiHariIni,
  'total_revenue_today': instance.totalRevenueHariIni,
  'total_products': instance.totalProduk,
  'pending_orders': instance.orderPending,
};
