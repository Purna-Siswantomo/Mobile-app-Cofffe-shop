import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk'),
        actions: [
          IconButton(
            tooltip: 'Tambah produk',
            onPressed: () => context.go('/admin/products/create'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/admin/products/create'),
        icon: const Icon(Icons.add),
        label: const Text('Produk'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(productsProvider),
        child: productsState.when(
          loading: () => GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.64,
            ),
            itemBuilder: (_, __) => const LoadingWidget.card(),
            itemCount: 6,
          ),
          error: (error, _) => AppErrorWidget(
            error: error,
            onRetry: () => ref.invalidate(productsProvider),
          ),
          data: (products) {
            if (products.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 120),
                  EmptyStateWidget(
                    icon: Icons.inventory_2_outlined,
                    title: 'Belum ada produk',
                    subtitle: 'Tambahkan produk pertama untuk mulai berjualan.',
                  ),
                ],
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.64,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductCard(
                  product: product,
                  onEdit: () =>
                      context.go('/admin/products/${product.id}/edit'),
                  onDelete: () => _confirmDelete(context, ref, product.id),
                );
              },
              itemCount: products.length,
            );
          },
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    int productId,
  ) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Hapus produk?'),
            content: const Text('Produk yang dihapus tidak bisa dikembalikan.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
                child: const Text('Hapus'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed || !context.mounted) {
      return;
    }

    try {
      await ref.read(productRepositoryProvider).deleteProduct(productId);
      ref.invalidate(productsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produk berhasil dihapus')),
        );
      }
    } catch (error) {
      if (context.mounted) {
        final message = error is AppException
            ? error.message
            : 'Gagal menghapus produk';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }
}
