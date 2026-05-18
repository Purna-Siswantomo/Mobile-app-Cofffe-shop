// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String?,
      price: const FlexibleDoubleConverter().fromJson(json['price']),
      stock: (json['stock'] as num).toInt(),
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'description': instance.description,
      'price': const FlexibleDoubleConverter().toJson(instance.price),
      'stock': instance.stock,
      'image_url': instance.imageUrl,
      'created_at': instance.createdAt,
    };
