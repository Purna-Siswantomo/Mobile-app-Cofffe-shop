import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/order_model.dart';
import '../../data/repositories/order_repository.dart';

part 'order_provider.g.dart';

@riverpod
OrderRepository orderRepository(Ref ref) {
  return OrderRepository();
}

@riverpod
class PendingOrders extends _$PendingOrders {
  OrderRepository get _repository => ref.read(orderRepositoryProvider);

  @override
  Future<List<OrderModel>> build() {
    final timer = Timer.periodic(const Duration(seconds: 5), (_) {
      refreshSilently();
    });
    ref.onDispose(timer.cancel);

    return _repository.getPendingOrders();
  }

  Future<void> fetchPending() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_repository.getPendingOrders);
  }

  Future<void> refreshSilently() async {
    final previousOrders = state.value;

    try {
      final orders = await _repository.getPendingOrders();
      state = AsyncValue.data(orders);
    } catch (error, stackTrace) {
      if (previousOrders != null) {
        state = AsyncValue.data(previousOrders);
        return;
      }

      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> confirmOrder(int id) async {
    final previousState = state;
    final currentOrders = state.value ?? <OrderModel>[];

    state = AsyncValue.data(
      currentOrders.where((order) => order.id != id).toList(),
    );

    try {
      await _repository.confirmOrder(id);
    } catch (error, stackTrace) {
      state = previousState;
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> cancelOrder(int id, String reason) async {
    final previousState = state;
    final currentOrders = state.value ?? <OrderModel>[];

    state = AsyncValue.data(
      currentOrders.where((order) => order.id != id).toList(),
    );

    try {
      await _repository.cancelOrder(id, reason);
    } catch (error, stackTrace) {
      state = previousState;
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void addNewOrder(OrderModel order) {
    final currentOrders = state.value ?? <OrderModel>[];
    final updatedOrders = [
      ...currentOrders.where((item) => item.id != order.id),
      order,
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    state = AsyncValue.data(updatedOrders);
  }
}
