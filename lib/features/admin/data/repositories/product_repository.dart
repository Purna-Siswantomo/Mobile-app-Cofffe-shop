import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../models/product_model.dart';

class ProductRepository {
  ProductRepository({DioClient? dioClient})
    : _dio = (dioClient ?? DioClient.instance).dio;

  final Dio _dio;

  Future<List<ProductModel>> getProducts({
    int page = 1,
    String? search,
    String? category,
    String? stockStatus,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.kProducts,
        queryParameters: {
          'page': page,
          if (search != null && search.isNotEmpty) 'search': search,
          if (category != null && category.isNotEmpty) 'category': category,
          if (stockStatus != null && stockStatus.isNotEmpty)
            'stock_status': stockStatus,
        },
      );
      final data = _readList(response.data);

      return data.map(ProductModel.fromJson).toList();
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<ProductModel> getProduct(int id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiEndpoints.kProducts}/$id',
      );

      return ProductModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.kProductCategories,
      );

      final data = response.data?['data'];
      if (data is! List) {
        return const [];
      }

      return data
          .whereType<Object>()
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .toSet()
          .toList()
        ..sort();
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<ProductModel> createProduct(
    Map<String, dynamic> data, {
    String? imagePath,
  }) async {
    try {
      final requestData = imagePath == null
          ? data
          : FormData.fromMap({
              ...data,
              'image': await MultipartFile.fromFile(imagePath),
            });

      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.kProducts,
        data: requestData,
        options: imagePath == null
            ? null
            : Options(contentType: Headers.multipartFormDataContentType),
      );

      return ProductModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<ProductModel> updateProduct(
    int id,
    Map<String, dynamic> data, {
    String? imagePath,
  }) async {
    try {
      final Response<Map<String, dynamic>> response;
      if (imagePath == null) {
        response = await _dio.put<Map<String, dynamic>>(
          '${ApiEndpoints.kProducts}/$id',
          data: data,
        );
      } else {
        response = await _dio.post<Map<String, dynamic>>(
          '${ApiEndpoints.kProducts}/$id',
          data: FormData.fromMap({
            ...data,
            '_method': 'PUT',
            'image': await MultipartFile.fromFile(imagePath),
          }),
          options: Options(contentType: Headers.multipartFormDataContentType),
        );
      }

      return ProductModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _dio.delete<void>('${ApiEndpoints.kProducts}/$id');
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  List<Map<String, dynamic>> _readList(Map<String, dynamic>? responseData) {
    final data = responseData?['data'];
    final list = data is Map ? data['data'] : data;

    if (list is! List) {
      return const [];
    }

    return list.map(_asMap).toList();
  }

  Map<String, dynamic> _readMap(Map<String, dynamic>? responseData) {
    return _asMap(responseData?['data'] ?? responseData);
  }

  Map<String, dynamic> _asMap(Object? value) {
    if (value is Map<String, dynamic>) {
      return _normalizeProductImageUrl(value);
    }
    if (value is Map) {
      return _normalizeProductImageUrl(
        value.map((key, value) => MapEntry(key.toString(), value)),
      );
    }

    return <String, dynamic>{};
  }

  Map<String, dynamic> _normalizeProductImageUrl(Map<String, dynamic> product) {
    final uploadedImageUrl = product['gambar_url'];
    if ((product['image_url'] == null || product['image_url'] == '') &&
        uploadedImageUrl is String &&
        uploadedImageUrl.isNotEmpty) {
      return {...product, 'image_url': uploadedImageUrl};
    }

    return product;
  }

  AppException _toAppException(DioException error) {
    final appException = error.error;
    if (appException is AppException) {
      return appException;
    }

    return UnknownException(error.message ?? 'Terjadi kesalahan produk');
  }
}
