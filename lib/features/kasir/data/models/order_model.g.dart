// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      id: (_readOrderId(json, 'id') as num).toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      totalAmount: const FlexibleDoubleConverter().fromJson(
        _readTotalAmount(json, 'totalAmount'),
      ),
      status: json['status'] as String? ?? 'pending',
      paymentMethod: json['payment_method'] as String?,
      createdAt: json['created_at'] as String,
      itemCount: (_readItemCount(json, 'itemCount') as num?)?.toInt(),
      details:
          (json['details'] as List<dynamic>?)
              ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <OrderItemModel>[],
    );

Map<String, dynamic> _$$OrderModelImplToJson(
  _$OrderModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'totalAmount': const FlexibleDoubleConverter().toJson(instance.totalAmount),
  'status': instance.status,
  'payment_method': instance.paymentMethod,
  'created_at': instance.createdAt,
  'itemCount': instance.itemCount,
  'details': instance.details,
};

_$OrderItemModelImpl _$$OrderItemModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemModelImpl(
      id: (json['id'] as num).toInt(),
      transactionId: (json['transaction_id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      quantity: const FlexibleIntConverter().fromJson(json['quantity']),
      subtotal: const FlexibleDoubleConverter().fromJson(json['subtotal']),
      product: json['product'] == null
          ? null
          : OrderItemProductModel.fromJson(
              json['product'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$$OrderItemModelImplToJson(
  _$OrderItemModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'transaction_id': instance.transactionId,
  'product_id': instance.productId,
  'quantity': const FlexibleIntConverter().toJson(instance.quantity),
  'subtotal': const FlexibleDoubleConverter().toJson(instance.subtotal),
  'product': instance.product,
};

_$OrderItemProductModelImpl _$$OrderItemProductModelImplFromJson(
  Map<String, dynamic> json,
) => _$OrderItemProductModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  category: json['category'] as String?,
  price: const FlexibleNullableDoubleConverter().fromJson(json['price']),
  stock: const FlexibleNullableIntConverter().fromJson(json['stock']),
);

Map<String, dynamic> _$$OrderItemProductModelImplToJson(
  _$OrderItemProductModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'price': const FlexibleNullableDoubleConverter().toJson(instance.price),
  'stock': const FlexibleNullableIntConverter().toJson(instance.stock),
};
