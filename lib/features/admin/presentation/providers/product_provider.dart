import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

part 'product_provider.g.dart';

@riverpod
ProductRepository productRepository(Ref ref) {
  return ProductRepository();
}

@riverpod
Future<List<ProductModel>> products(Ref ref) {
  return ref.read(productRepositoryProvider).getProducts();
}

@riverpod
Future<ProductModel> productDetail(Ref ref, int id) {
  return ref.read(productRepositoryProvider).getProduct(id);
}
