// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/json_converters.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const OrderModel._();

  const factory OrderModel({
    @JsonKey(readValue: _readOrderId) required int id,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(readValue: _readTotalAmount)
    @FlexibleDoubleConverter()
    required double totalAmount,
    @Default('pending') String status,
    @JsonKey(name: 'order_type') String? orderType,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'payment_status') String? paymentStatus,
    @JsonKey(name: 'payment_proof') String? paymentProof,
    @JsonKey(name: 'payment_proof_url') String? paymentProofUrl,
    @JsonKey(name: 'table_number') String? tableNumber,
    String? notes,
    UserSummaryModel? user,
    DeliveryModel? delivery,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(readValue: _readItemCount) int? itemCount,
    @Default(<OrderItemModel>[]) List<OrderItemModel> details,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  bool get isCanceled => status == 'cancelled' || status == 'canceled';

  bool get canBeCanceledByKasir =>
      status == 'pending_payment' ||
      status == 'pending' ||
      status == 'in_progress' ||
      status == 'delivering';

  bool get canBeConfirmedByKasir =>
      status == 'pending' && paymentStatus == 'verified';

  int get resolvedItemCount => itemCount ?? details.length;

  String get statusLabel => switch (status) {
    'pending' => 'Menunggu',
    'confirmed' => 'Dikonfirmasi',
    'in_progress' => 'Diproses',
    'delivering' => 'Diantar',
    'completed' => 'Selesai',
    'paid' => 'Dibayar',
    'cancelled' || 'canceled' => 'Dibatalkan',
    'pending_payment' => 'Menunggu Bayar',
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

@freezed
class UserSummaryModel with _$UserSummaryModel {
  const factory UserSummaryModel({
    required int id,
    required String name,
    String? email,
    String? role,
  }) = _UserSummaryModel;

  factory UserSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryModelFromJson(json);
}

@freezed
class DeliveryModel with _$DeliveryModel {
  const factory DeliveryModel({
    required int id,
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
  }) = _DeliveryModel;

  factory DeliveryModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryModelFromJson(json);
}

@freezed
class OrderItemModel with _$OrderItemModel {
  const OrderItemModel._();

  const factory OrderItemModel({
    required int id,
    @JsonKey(name: 'transaction_id') int? transactionId,
    @JsonKey(name: 'product_id') int? productId,
    @FlexibleIntConverter() required int quantity,
    @FlexibleDoubleConverter() required double subtotal,
    OrderItemProductModel? product,
  }) = _OrderItemModel;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  String get productName => product?.name ?? 'Produk #${productId ?? '-'}';

  double get unitPrice {
    final productPrice = product?.price;
    if (productPrice != null && productPrice > 0) {
      return productPrice;
    }
    if (quantity <= 0) {
      return subtotal;
    }

    return subtotal / quantity;
  }
}

@freezed
class OrderItemProductModel with _$OrderItemProductModel {
  const factory OrderItemProductModel({
    required int id,
    required String name,
    String? category,
    @FlexibleNullableDoubleConverter() double? price,
    @FlexibleNullableIntConverter() int? stock,
  }) = _OrderItemProductModel;

  factory OrderItemProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemProductModelFromJson(json);
}

Object? _readOrderId(Map json, String key) {
  return json[key] ?? json['transaction_id'];
}

Object? _readTotalAmount(Map json, String key) {
  return json[key] ??
      json['total_amount'] ??
      json['grand_total'] ??
      json['total'];
}

Object? _readItemCount(Map json, String key) {
  final explicit = json[key] ?? json['item_count'];
  if (explicit != null) {
    return explicit;
  }

  final details = json['details'];
  if (details is List) {
    return details.length;
  }

  return null;
}
