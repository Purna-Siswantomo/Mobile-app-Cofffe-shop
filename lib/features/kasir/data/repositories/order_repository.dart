import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../admin/data/models/product_model.dart';
import '../models/order_model.dart';

class OrderRepository {
  OrderRepository({Dio? dio, DioClient? dioClient})
    : _dio = dio ?? (dioClient ?? DioClient.instance).dio;

  final Dio _dio;

  Future<List<OrderModel>> getPendingOrders() async {
    return _getOrders(ApiEndpoints.kOrdersPending);
  }

  Future<List<OrderModel>> getPendingReviewOrders() async {
    return _getOrders(ApiEndpoints.kOrdersPendingReview);
  }

  Future<List<OrderModel>> getReadyToConfirmOrders() async {
    return _getOrders(ApiEndpoints.kOrdersReadyToConfirm);
  }

  Future<List<OrderModel>> getInProgressOrders() async {
    return _getOrders(ApiEndpoints.kOrdersInProgress);
  }

  Future<OrderModel> getOrder(int id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        _withId(ApiEndpoints.kOrderDetail, id),
      );

      return OrderModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<List<OrderModel>> _getOrders(String endpoint) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(endpoint);
      final data = _readList(response.data);

      return data.map(OrderModel.fromJson).toList();
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<OrderModel> verifyPayment(int id) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _withId(ApiEndpoints.kOrderVerifyPayment, id),
      );

      return OrderModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<OrderModel> rejectPayment(int id, String reason) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _withId(ApiEndpoints.kOrderRejectPayment, id),
        data: {'reason': reason},
      );

      return OrderModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<OrderModel> confirmOrder(int id) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _withId(ApiEndpoints.kOrderConfirm, id),
      );

      return OrderModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<OrderModel> deliverOrder(int id) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _withId(ApiEndpoints.kOrderDeliver, id),
      );

      return OrderModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<OrderModel> completeOrder(int id) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _withId(ApiEndpoints.kOrderComplete, id),
      );

      return OrderModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<OrderModel> cancelOrder(int id, String reason) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _withId(ApiEndpoints.kOrderCancel, id),
        data: {'reason': reason},
      );

      return OrderModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<OrderModel> updateOrderStatus(int id, String status) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        _withId(ApiEndpoints.kOrderUpdateStatus, id),
        data: {'status': status},
      );

      return OrderModel.fromJson(_readMap(response.data));
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<List<ProductModel>> getPosProducts() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.kPosProducts,
      );
      final data = _readList(response.data);

      return data.map(ProductModel.fromJson).toList();
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  Future<PosTransactionResult> createPosTransaction({
    required List<PosItemPayload> items,
    required double paidAmount,
    String? tableNumber,
    String? notes,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.kPosTransactions,
        data: {
          'items': items.map((item) => item.toJson()).toList(),
          'paid_amount': paidAmount,
          if (tableNumber != null && tableNumber.isNotEmpty)
            'table_number': tableNumber,
          if (notes != null && notes.isNotEmpty) 'notes': notes,
        },
      );
      final data = _readMap(response.data);

      return PosTransactionResult(
        transaction: OrderModel.fromJson(_asMap(data['transaction'])),
        change: (data['change'] as num?)?.toDouble() ?? 0,
        receiptUrl: data['receipt_url']?.toString(),
      );
    } on DioException catch (error) {
      throw _toAppException(error);
    }
  }

  String _withId(String endpoint, int id) {
    return endpoint.replaceFirst('{id}', id.toString());
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
      return _normalizeOrderAssetUrls(value);
    }
    if (value is Map) {
      return _normalizeOrderAssetUrls(
        value.map((key, value) => MapEntry(key.toString(), value)),
      );
    }

    return <String, dynamic>{};
  }

  Map<String, dynamic> _normalizeOrderAssetUrls(Map<String, dynamic> order) {
    final proofPath = order['payment_proof'];
    final proofUrl = order['payment_proof_url'];

    if ((proofUrl == null || proofUrl == '') &&
        proofPath is String &&
        proofPath.isNotEmpty) {
      return {
        ...order,
        'payment_proof_url': proofPath.startsWith('/')
            ? proofPath
            : '/storage/$proofPath',
      };
    }

    return order;
  }

  AppException _toAppException(DioException error) {
    final appException = error.error;
    if (appException is AppException) {
      return appException;
    }

    return UnknownException(error.message ?? 'Terjadi kesalahan order');
  }
}

class PosItemPayload {
  const PosItemPayload({required this.productId, required this.quantity});

  final int productId;
  final int quantity;

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'quantity': quantity,
  };
}

class PosTransactionResult {
  const PosTransactionResult({
    required this.transaction,
    required this.change,
    this.receiptUrl,
  });

  final OrderModel transaction;
  final double change;
  final String? receiptUrl;
}
