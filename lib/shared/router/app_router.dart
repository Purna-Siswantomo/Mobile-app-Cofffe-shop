import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../../features/admin/presentation/screens/product_form_screen.dart';
import '../../features/admin/presentation/screens/product_list_screen.dart';
import '../../features/admin/presentation/screens/report_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/kasir/presentation/screens/kasir_dashboard_screen.dart';
import '../../features/kasir/presentation/screens/order_detail_screen.dart';
import '../../features/kasir/presentation/screens/order_list_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final routerNotifier = RouterNotifier(ref);
  ref.onDispose(routerNotifier.dispose);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: routerNotifier,
    redirect: routerNotifier.redirect,
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/kasir',
        builder: (context, state) => const KasirDashboardScreen(),
        routes: [
          GoRoute(
            path: 'orders',
            builder: (context, state) => const OrderListScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = int.tryParse(state.pathParameters['id'] ?? '');
                  return OrderDetailScreen(orderId: id);
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboardScreen(),
        routes: [
          GoRoute(
            path: 'products',
            builder: (context, state) => const ProductListScreen(),
            routes: [
              GoRoute(
                path: 'create',
                builder: (context, state) => const ProductFormScreen(),
              ),
              GoRoute(
                path: ':id/edit',
                builder: (context, state) {
                  final id = int.tryParse(state.pathParameters['id'] ?? '');
                  return ProductFormScreen(productId: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'reports',
            builder: (context, state) => const ReportScreen(),
          ),
        ],
      ),
    ],
  );
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref.listen(authStateProvider, (_, __) => notifyListeners());
  }

  final Ref _ref;

  String? redirect(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authStateProvider);

    if (authState.isLoading ||
        authState.isRefreshing ||
        authState.isReloading) {
      return null;
    }

    final user = authState.valueOrNull;
    final isLoggedIn = user != null;
    final location = state.matchedLocation;
    final isOnLogin = location == '/login';
    final isAdminRoute = location.startsWith('/admin');
    final isKasirRoute = location.startsWith('/kasir');

    if (!isLoggedIn) {
      return isOnLogin ? null : '/login';
    }

    if (isOnLogin) {
      return _homeForRole(user.role);
    }

    if (user.isKasir && isAdminRoute) {
      return '/kasir';
    }

    if (user.isAdmin && isKasirRoute) {
      return '/admin';
    }

    return null;
  }

  String _homeForRole(String role) {
    return switch (role) {
      'admin' => '/admin',
      'kasir' => '/kasir',
      _ => '/login',
    };
  }
}
