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
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(readValue: _readItemCount) int? itemCount,
    @Default(<OrderItemModel>[]) List<OrderItemModel> details,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  bool get isCanceled => status == 'cancelled' || status == 'canceled';

  int get resolvedItemCount => itemCount ?? details.length;

  String get statusLabel => switch (status) {
    'pending' => 'Menunggu',
    'confirmed' => 'Dikonfirmasi',
    'completed' => 'Selesai',
    'cancelled' || 'canceled' => 'Dibatalkan',
    _ => status,
  };
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
