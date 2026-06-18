import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../admin/data/models/product_model.dart';
import '../../data/models/order_model.dart';
import '../../data/repositories/order_repository.dart';

part 'order_provider.g.dart';

@riverpod
OrderRepository orderRepository(Ref ref) {
  return OrderRepository();
}

@riverpod
Future<OrderModel> orderDetail(Ref ref, int id) {
  return ref.read(orderRepositoryProvider).getOrder(id);
}

@riverpod
Future<List<ProductModel>> posProducts(Ref ref) {
  return ref.read(orderRepositoryProvider).getPosProducts();
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

@riverpod
class PendingReviewOrders extends _$PendingReviewOrders {
  OrderRepository get _repository => ref.read(orderRepositoryProvider);

  @override
  Future<List<OrderModel>> build() {
    final timer = Timer.periodic(const Duration(seconds: 5), (_) {
      refreshSilently();
    });
    ref.onDispose(timer.cancel);

    return _repository.getPendingReviewOrders();
  }

  Future<void> fetch() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_repository.getPendingReviewOrders);
  }

  Future<void> refreshSilently() async {
    final previousOrders = state.value;
    try {
      state = AsyncValue.data(await _repository.getPendingReviewOrders());
    } catch (error, stackTrace) {
      state = previousOrders != null
          ? AsyncValue.data(previousOrders)
          : AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> verifyPayment(int id) async {
    final verifiedOrder = await _runAndRemove(
      id,
      () => _repository.verifyPayment(id),
    );
    ref
        .read(readyToConfirmOrdersProvider.notifier)
        .addReadyOrder(verifiedOrder);
    ref.invalidate(orderDetailProvider(id));
  }

  Future<void> rejectPayment(int id, String reason) async {
    await _runAndRemove(id, () => _repository.rejectPayment(id, reason));
    ref.invalidate(orderDetailProvider(id));
  }

  void addNewOrder(OrderModel order) {
    if (order.paymentStatus != 'awaiting_review') {
      return;
    }

    final currentOrders = state.value ?? <OrderModel>[];
    state = AsyncValue.data(
      [...currentOrders.where((item) => item.id != order.id), order]
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
    );
  }

  Future<OrderModel> _runAndRemove(
    int id,
    Future<OrderModel> Function() action,
  ) async {
    final previousState = state;
    final currentOrders = state.value ?? <OrderModel>[];
    state = AsyncValue.data(
      currentOrders.where((order) => order.id != id).toList(),
    );

    try {
      return await action();
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
      ref.invalidate(orderDetailProvider(id));
    } catch (error, stackTrace) {
      state = previousState;
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}

@riverpod
class ReadyToConfirmOrders extends _$ReadyToConfirmOrders {
  OrderRepository get _repository => ref.read(orderRepositoryProvider);

  @override
  Future<List<OrderModel>> build() {
    final timer = Timer.periodic(const Duration(seconds: 5), (_) {
      refreshSilently();
    });
    ref.onDispose(timer.cancel);

    return _repository.getReadyToConfirmOrders();
  }

  Future<void> fetch() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_repository.getReadyToConfirmOrders);
  }

  Future<void> refreshSilently() async {
    final previousOrders = state.value;
    try {
      state = AsyncValue.data(await _repository.getReadyToConfirmOrders());
    } catch (error, stackTrace) {
      state = previousOrders != null
          ? AsyncValue.data(previousOrders)
          : AsyncValue.error(error, stackTrace);
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
      ref.invalidate(inProgressOrdersProvider);
      ref.invalidate(orderDetailProvider(id));
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
      ref.invalidate(orderDetailProvider(id));
    } catch (error, stackTrace) {
      state = previousState;
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void addReadyOrder(OrderModel order) {
    if (order.status != 'pending' || order.paymentStatus != 'verified') {
      return;
    }

    final currentOrders = state.value ?? <OrderModel>[];
    state = AsyncValue.data(
      [...currentOrders.where((item) => item.id != order.id), order]
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
    );
  }
}

@riverpod
class InProgressOrders extends _$InProgressOrders {
  OrderRepository get _repository => ref.read(orderRepositoryProvider);

  @override
  Future<List<OrderModel>> build() {
    final timer = Timer.periodic(const Duration(seconds: 5), (_) {
      refreshSilently();
    });
    ref.onDispose(timer.cancel);

    return _repository.getInProgressOrders();
  }

  Future<void> fetch() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_repository.getInProgressOrders);
  }

  Future<void> refreshSilently() async {
    final previousOrders = state.value;
    try {
      state = AsyncValue.data(await _repository.getInProgressOrders());
    } catch (error, stackTrace) {
      state = previousOrders != null
          ? AsyncValue.data(previousOrders)
          : AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deliverOrder(int id) async {
    await _runAndRefresh(id, () => _repository.deliverOrder(id));
  }

  Future<void> completeOrder(int id) async {
    await _runAndRefresh(id, () => _repository.completeOrder(id));
  }

  Future<void> cancelOrder(int id, String reason) async {
    await _runAndRefresh(id, () => _repository.cancelOrder(id, reason));
  }

  Future<void> _runAndRefresh(
    int id,
    Future<OrderModel> Function() action,
  ) async {
    try {
      await action();
      await refreshSilently();
      ref.invalidate(orderDetailProvider(id));
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
