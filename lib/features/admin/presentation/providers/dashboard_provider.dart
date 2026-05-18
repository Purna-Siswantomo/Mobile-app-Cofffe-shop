import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/dashboard_stats_model.dart';
import '../../data/repositories/dashboard_repository.dart';

part 'dashboard_provider.g.dart';

@riverpod
DashboardRepository dashboardRepository(Ref ref) {
  return DashboardRepository();
}

@riverpod
Future<DashboardStatsModel> dashboardStats(Ref ref) {
  ref.keepAlive();

  final timer = Timer.periodic(const Duration(seconds: 30), (_) {
    ref.invalidateSelf();
  });
  ref.onDispose(timer.cancel);

  return ref.read(dashboardRepositoryProvider).getStats();
}
