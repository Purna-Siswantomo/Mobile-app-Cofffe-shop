// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionModelImpl(
  id: (json['id'] as num).toInt(),
  userId: (json['user_id'] as num?)?.toInt(),
  orderType: json['order_type'] as String?,
  paymentMethod: json['payment_method'] as String?,
  paymentStatus: json['payment_status'] as String?,
  total: const FlexibleDoubleConverter().fromJson(json['total']),
  grandTotal: const FlexibleNullableDoubleConverter().fromJson(
    json['grand_total'],
  ),
  status: json['status'] as String,
  tableNumber: json['table_number'] as String?,
  notes: json['notes'] as String?,
  createdAt: json['created_at'] as String,
  details:
      (json['details'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OrderItemModel>[],
);

Map<String, dynamic> _$$TransactionModelImplToJson(
  _$TransactionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'order_type': instance.orderType,
  'payment_method': instance.paymentMethod,
  'payment_status': instance.paymentStatus,
  'total': const FlexibleDoubleConverter().toJson(instance.total),
  'grand_total': const FlexibleNullableDoubleConverter().toJson(
    instance.grandTotal,
  ),
  'status': instance.status,
  'table_number': instance.tableNumber,
  'notes': instance.notes,
  'created_at': instance.createdAt,
  'details': instance.details,
};
