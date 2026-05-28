// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/json_converters.dart';
import '../../../kasir/data/models/order_model.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const TransactionModel._();

  const factory TransactionModel({
    required int id,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'order_type') String? orderType,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'payment_status') String? paymentStatus,
    @FlexibleDoubleConverter() required double total,
    @JsonKey(name: 'paid_amount')
    @FlexibleNullableDoubleConverter()
    double? paidAmount,
    @JsonKey(name: 'grand_total')
    @FlexibleNullableDoubleConverter()
    double? grandTotal,
    required String status,
    @JsonKey(name: 'table_number') String? tableNumber,
    String? notes,
    UserSummaryModel? user,
    @JsonKey(name: 'created_at') required String createdAt,
    @Default(<OrderItemModel>[]) List<OrderItemModel> details,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  double get displayTotal => grandTotal ?? total;

  double get displayPaidAmount => paidAmount ?? 0;

  int get itemCount => details.length;

  String get statusLabel => switch (status) {
    'pending' => 'Menunggu',
    'in_progress' => 'Diproses',
    'delivering' => 'Diantar',
    'confirmed' => 'Dikonfirmasi',
    'completed' => 'Selesai',
    'paid' => 'Dibayar',
    'cancelled' || 'canceled' => 'Dibatalkan',
    _ => status,
  };

  String get paymentStatusLabel => switch (paymentStatus) {
    'pending_payment' => 'Belum Bayar',
    'awaiting_review' => 'Cek Bukti',
    'verified' => 'Terverifikasi',
    'rejected' => 'Ditolak',
    _ => paymentStatus ?? '-',
  };

  String get orderTypeLabel => switch (orderType) {
    'delivery' => 'Delivery',
    'dinein' => 'Dine-in',
    _ => orderType ?? '-',
  };
}
