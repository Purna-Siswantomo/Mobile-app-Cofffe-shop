import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/admin_management_repository.dart';

part 'admin_management_provider.g.dart';

@riverpod
AdminManagementRepository adminManagementRepository(Ref ref) {
  return AdminManagementRepository();
}

@riverpod
Future<AdminUsersResult> adminUsers(Ref ref) {
  return ref.read(adminManagementRepositoryProvider).getUsers();
}

@riverpod
Future<AdminNotificationsResult> adminNotifications(Ref ref) {
  return ref.read(adminManagementRepositoryProvider).getNotifications();
}

@riverpod
Future<bool> deliveryEnabled(Ref ref) {
  return ref.read(adminManagementRepositoryProvider).getDeliveryEnabled();
}

@riverpod
Future<ReportSummary> reportSummary(Ref ref) {
  return ref.read(adminManagementRepositoryProvider).getReportSummary();
}
