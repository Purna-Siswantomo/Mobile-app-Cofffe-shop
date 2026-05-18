// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/json_converters.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required int id,
    required String name,
    required String category,
    String? description,
    @FlexibleDoubleConverter() required double price,
    required int stock,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
