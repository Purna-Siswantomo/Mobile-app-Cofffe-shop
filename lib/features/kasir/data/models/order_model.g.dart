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
      orderType: json['order_type'] as String?,
      paymentMethod: json['payment_method'] as String?,
      paymentStatus: json['payment_status'] as String?,
      paymentProof: json['payment_proof'] as String?,
      paymentProofUrl: json['payment_proof_url'] as String?,
      tableNumber: json['table_number'] as String?,
      notes: json['notes'] as String?,
      user: json['user'] == null
          ? null
          : UserSummaryModel.fromJson(json['user'] as Map<String, dynamic>),
      delivery: json['delivery'] == null
          ? null
          : DeliveryModel.fromJson(json['delivery'] as Map<String, dynamic>),
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
  'order_type': instance.orderType,
  'payment_method': instance.paymentMethod,
  'payment_status': instance.paymentStatus,
  'payment_proof': instance.paymentProof,
  'payment_proof_url': instance.paymentProofUrl,
  'table_number': instance.tableNumber,
  'notes': instance.notes,
  'user': instance.user,
  'delivery': instance.delivery,
  'created_at': instance.createdAt,
  'itemCount': instance.itemCount,
  'details': instance.details,
};

_$UserSummaryModelImpl _$$UserSummaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserSummaryModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String?,
  role: json['role'] as String?,
);

Map<String, dynamic> _$$UserSummaryModelImplToJson(
  _$UserSummaryModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'role': instance.role,
};

_$DeliveryModelImpl _$$DeliveryModelImplFromJson(Map<String, dynamic> json) =>
    _$DeliveryModelImpl(
      id: (json['id'] as num).toInt(),
      transactionId: (json['transaction_id'] as num?)?.toInt(),
      recipientName: json['recipient_name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      status: json['status'] as String?,
      notes: json['notes'] as String?,
      latitude: const FlexibleNullableDoubleConverter().fromJson(
        json['latitude'],
      ),
      longitude: const FlexibleNullableDoubleConverter().fromJson(
        json['longitude'],
      ),
      deliveryFee: const FlexibleNullableDoubleConverter().fromJson(
        json['delivery_fee'],
      ),
    );

Map<String, dynamic> _$$DeliveryModelImplToJson(
  _$DeliveryModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'transaction_id': instance.transactionId,
  'recipient_name': instance.recipientName,
  'address': instance.address,
  'phone': instance.phone,
  'status': instance.status,
  'notes': instance.notes,
  'latitude': const FlexibleNullableDoubleConverter().toJson(instance.latitude),
  'longitude': const FlexibleNullableDoubleConverter().toJson(
    instance.longitude,
  ),
  'delivery_fee': const FlexibleNullableDoubleConverter().toJson(
    instance.deliveryFee,
  ),
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
