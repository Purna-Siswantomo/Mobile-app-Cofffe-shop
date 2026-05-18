// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_stats_model.freezed.dart';
part 'dashboard_stats_model.g.dart';

@freezed
class DashboardStatsModel with _$DashboardStatsModel {
  const factory DashboardStatsModel({
    @JsonKey(name: 'total_transactions_today')
    required int totalTransaksiHariIni,
    @JsonKey(name: 'total_revenue_today') required double totalRevenueHariIni,
    @JsonKey(name: 'total_products') required int totalProduk,
    @JsonKey(name: 'pending_orders') required int orderPending,
  }) = _DashboardStatsModel;

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsModelFromJson(json);
}
