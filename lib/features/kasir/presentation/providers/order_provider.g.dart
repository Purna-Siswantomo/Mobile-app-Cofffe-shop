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
String _$orderDetailHash() => r'e5dc8ed25cd73db220ca66a6851768f095dd4113';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [orderDetail].
@ProviderFor(orderDetail)
const orderDetailProvider = OrderDetailFamily();

/// See also [orderDetail].
class OrderDetailFamily extends Family<AsyncValue<OrderModel>> {
  /// See also [orderDetail].
  const OrderDetailFamily();

  /// See also [orderDetail].
  OrderDetailProvider call(int id) {
    return OrderDetailProvider(id);
  }

  @override
  OrderDetailProvider getProviderOverride(
    covariant OrderDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'orderDetailProvider';
}

/// See also [orderDetail].
class OrderDetailProvider extends AutoDisposeFutureProvider<OrderModel> {
  /// See also [orderDetail].
  OrderDetailProvider(int id)
    : this._internal(
        (ref) => orderDetail(ref as OrderDetailRef, id),
        from: orderDetailProvider,
        name: r'orderDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$orderDetailHash,
        dependencies: OrderDetailFamily._dependencies,
        allTransitiveDependencies: OrderDetailFamily._allTransitiveDependencies,
        id: id,
      );

  OrderDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<OrderModel> Function(OrderDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrderDetailProvider._internal(
        (ref) => create(ref as OrderDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OrderModel> createElement() {
    return _OrderDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrderDetailRef on AutoDisposeFutureProviderRef<OrderModel> {
  /// The parameter `id` of this provider.
  int get id;
}

class _OrderDetailProviderElement
    extends AutoDisposeFutureProviderElement<OrderModel>
    with OrderDetailRef {
  _OrderDetailProviderElement(super.provider);

  @override
  int get id => (origin as OrderDetailProvider).id;
}

String _$posProductsHash() => r'78a97dea4311a1ead5f5f8b2c29f9080ba00fc23';

/// See also [posProducts].
@ProviderFor(posProducts)
final posProductsProvider =
    AutoDisposeFutureProvider<List<ProductModel>>.internal(
      posProducts,
      name: r'posProductsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$posProductsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PosProductsRef = AutoDisposeFutureProviderRef<List<ProductModel>>;
String _$pendingOrdersHash() => r'fd2300b8ca5641c0f7dcefd2c748f28f4f8b71e7';

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
String _$pendingReviewOrdersHash() =>
    r'5f92611de559c651429b68dea7407e4ca0654fdd';

/// See also [PendingReviewOrders].
@ProviderFor(PendingReviewOrders)
final pendingReviewOrdersProvider =
    AutoDisposeAsyncNotifierProvider<
      PendingReviewOrders,
      List<OrderModel>
    >.internal(
      PendingReviewOrders.new,
      name: r'pendingReviewOrdersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pendingReviewOrdersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PendingReviewOrders = AutoDisposeAsyncNotifier<List<OrderModel>>;
String _$readyToConfirmOrdersHash() =>
    r'39c123ed40335a23d39ed87ebb6af26c099c4856';

/// See also [ReadyToConfirmOrders].
@ProviderFor(ReadyToConfirmOrders)
final readyToConfirmOrdersProvider =
    AutoDisposeAsyncNotifierProvider<
      ReadyToConfirmOrders,
      List<OrderModel>
    >.internal(
      ReadyToConfirmOrders.new,
      name: r'readyToConfirmOrdersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$readyToConfirmOrdersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ReadyToConfirmOrders = AutoDisposeAsyncNotifier<List<OrderModel>>;
String _$inProgressOrdersHash() => r'f2f9b10832198b82f853953369071685edd7efd7';

/// See also [InProgressOrders].
@ProviderFor(InProgressOrders)
final inProgressOrdersProvider =
    AutoDisposeAsyncNotifierProvider<
      InProgressOrders,
      List<OrderModel>
    >.internal(
      InProgressOrders.new,
      name: r'inProgressOrdersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$inProgressOrdersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$InProgressOrders = AutoDisposeAsyncNotifier<List<OrderModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
