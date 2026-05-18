// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderRepositoryHash() => r'ad125924bfd6b4d7ba75c24a542b39f8aba0a469';

/// See also [orderRepository].
@ProviderFor(orderRepository)
final orderRepositoryProvider = AutoDisposeProvider<OrderRepository>.internal(
  orderRepository,
  name: r'orderRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrderRepositoryRef = AutoDisposeProviderRef<OrderRepository>;
String _$pendingOrdersHash() => r'fa69a6697a8d17fd1c693740b7dfdd9892cfaf8d';

/// See also [PendingOrders].
@ProviderFor(PendingOrders)
final pendingOrdersProvider =
    AutoDisposeAsyncNotifierProvider<PendingOrders, List<OrderModel>>.internal(
      PendingOrders.new,
      name: r'pendingOrdersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pendingOrdersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PendingOrders = AutoDisposeAsyncNotifier<List<OrderModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
