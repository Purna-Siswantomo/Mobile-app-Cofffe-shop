import 'dart:async';

import 'package:arpul_mobile/features/kasir/data/models/order_model.dart';
import 'package:arpul_mobile/features/kasir/data/repositories/order_repository.dart';
import 'package:arpul_mobile/features/kasir/presentation/providers/order_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fetch pending orders berhasil', () async {
    final repository = FakeOrderRepository(
      orders: [_order(id: 1), _order(id: 2)],
    );
    final container = _container(repository);
    addTearDown(container.dispose);

    final orders = await container.read(pendingOrdersProvider.future);

    expect(orders, hasLength(2));
    expect(orders.first.id, 1);
  });

  test('confirmOrder update state optimistically', () async {
    final confirmCompleter = Completer<OrderModel>();
    final repository = FakeOrderRepository(
      orders: [_order(id: 1), _order(id: 2)],
      onConfirm: (_) => confirmCompleter.future,
    );
    final container = _container(repository);
    addTearDown(container.dispose);
    await container.read(pendingOrdersProvider.future);

    final operation = container
        .read(pendingOrdersProvider.notifier)
        .confirmOrder(1);

    final optimisticState = container.read(pendingOrdersProvider).value!;
    expect(optimisticState.map((order) => order.id), [2]);

    confirmCompleter.complete(_order(id: 1, status: 'confirmed'));
    await operation;
  });

  test('addNewOrder menambah item ke list', () async {
    final repository = FakeOrderRepository(orders: [_order(id: 1)]);
    final container = _container(repository);
    addTearDown(container.dispose);
    await container.read(pendingOrdersProvider.future);

    container.read(pendingOrdersProvider.notifier).addNewOrder(_order(id: 2));

    final orders = container.read(pendingOrdersProvider).value!;
    expect(orders.map((order) => order.id), containsAll([1, 2]));
  });
}

ProviderContainer _container(FakeOrderRepository repository) {
  return ProviderContainer(
    overrides: [orderRepositoryProvider.overrideWithValue(repository)],
  );
}

OrderModel _order({required int id, String status = 'pending'}) {
  return OrderModel(
    id: id,
    userId: 1,
    totalAmount: 25000,
    status: status,
    paymentMethod: 'cash',
    createdAt: DateTime(2026, 1, 1, 12, id).toIso8601String(),
    itemCount: 2,
  );
}

class FakeOrderRepository extends OrderRepository {
  FakeOrderRepository({
    required List<OrderModel> orders,
    Future<OrderModel> Function(int id)? onConfirm,
  }) : _orders = orders,
       _onConfirm = onConfirm,
       super(dio: Dio());

  final List<OrderModel> _orders;
  final Future<OrderModel> Function(int id)? _onConfirm;

  @override
  Future<List<OrderModel>> getPendingOrders() async {
    return List<OrderModel>.from(_orders);
  }

  @override
  Future<OrderModel> confirmOrder(int id) async {
    return _onConfirm?.call(id) ?? _order(id: id, status: 'confirmed');
  }
}
