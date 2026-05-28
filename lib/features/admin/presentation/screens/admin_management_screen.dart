import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../shared/utils/currency_formatter.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../data/repositories/admin_management_repository.dart';
import '../providers/admin_management_provider.dart';

class AdminManagementScreen extends ConsumerWidget {
  const AdminManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: _AdminManagementAppBar(),
        body: TabBarView(
          children: [
            _UsersTab(),
            _NotificationsTab(),
            _DeliverySettingsTab(),
            _ReportSummaryTab(),
          ],
        ),
      ),
    );
  }
}

class _AdminManagementAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _AdminManagementAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Manajemen Admin'),
      bottom: const TabBar(
        isScrollable: true,
        tabs: [
          Tab(text: 'Users'),
          Tab(text: 'Notifikasi'),
          Tab(text: 'Delivery'),
          Tab(text: 'Summary'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);
}

class _UsersTab extends ConsumerWidget {
  const _UsersTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(adminUsersProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(adminUsersProvider),
      child: usersState.when(
        loading: () => _LoadingList(),
        error: (error, _) => AppErrorWidget(
          error: error,
          onRetry: () => ref.invalidate(adminUsersProvider),
        ),
        data: (result) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _StatsWrap(stats: result.stats),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => _showUserForm(context, ref),
              icon: const Icon(Icons.person_add_alt),
              label: const Text('Tambah User'),
            ),
            const SizedBox(height: 12),
            if (result.users.isEmpty)
              const EmptyStateWidget(
                icon: Icons.people_outline,
                title: 'Belum ada user',
                subtitle: 'User admin, kasir, dan member akan tampil di sini.',
              )
            else
              ...result.users.map(
                (user) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _UserTile(user: user),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showUserForm(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    String role = 'kasir';

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Tambah user'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: role,
                  decoration: const InputDecoration(labelText: 'Role'),
                  items: const [
                    DropdownMenuItem(value: 'admin', child: Text('Admin')),
                    DropdownMenuItem(value: 'kasir', child: Text('Kasir')),
                    DropdownMenuItem(value: 'member', child: Text('Member')),
                  ],
                  onChanged: (value) => setState(() => role = value ?? role),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );

    if (saved != true || !context.mounted) {
      return;
    }

    try {
      await ref.read(adminManagementRepositoryProvider).createUser({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'role': role,
        'is_active': true,
      });
      ref.invalidate(adminUsersProvider);
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    } finally {
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
    }
  }
}

class _UserTile extends ConsumerWidget {
  const _UserTile({required this.user});

  final AdminUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(user.name.characters.first)),
        title: Text(user.name),
        subtitle: Text('${user.email}\n${user.role}'),
        isThreeLine: true,
        trailing: Wrap(
          spacing: 4,
          children: [
            Switch(
              value: user.isActive,
              onChanged: (_) => _toggle(context, ref),
            ),
            IconButton(
              tooltip: 'Hapus',
              onPressed: () => _delete(context, ref),
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggle(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(adminManagementRepositoryProvider).toggleUser(user.id);
      ref.invalidate(adminUsersProvider);
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await _confirm(context, 'Hapus user?');
    if (!confirmed || !context.mounted) {
      return;
    }

    try {
      await ref.read(adminManagementRepositoryProvider).deleteUser(user.id);
      ref.invalidate(adminUsersProvider);
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
  }
}

class _NotificationsTab extends ConsumerWidget {
  const _NotificationsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminNotificationsProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(adminNotificationsProvider),
      child: state.when(
        loading: () => _LoadingList(),
        error: (error, _) => AppErrorWidget(
          error: error,
          onRetry: () => ref.invalidate(adminNotificationsProvider),
        ),
        data: (result) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _StatsWrap(stats: result.stats),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => _showNotificationForm(context, ref),
              icon: const Icon(Icons.add_alert_outlined),
              label: const Text('Tambah Notifikasi'),
            ),
            const SizedBox(height: 12),
            if (result.notifications.isEmpty)
              const EmptyStateWidget(
                icon: Icons.notifications_none,
                title: 'Belum ada notifikasi',
                subtitle: 'Notifikasi broadcast akan tampil di sini.',
              )
            else
              ...result.notifications.map(
                (notification) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _NotificationTile(notification: notification),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showNotificationForm(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final titleController = TextEditingController();
    final messageController = TextEditingController();
    String type = 'info';

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Tambah notifikasi'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Judul'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: messageController,
                  decoration: const InputDecoration(labelText: 'Pesan'),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: type,
                  decoration: const InputDecoration(labelText: 'Tipe'),
                  items: const [
                    DropdownMenuItem(value: 'info', child: Text('Info')),
                    DropdownMenuItem(value: 'warning', child: Text('Warning')),
                    DropdownMenuItem(value: 'success', child: Text('Success')),
                    DropdownMenuItem(
                      value: 'maintenance',
                      child: Text('Maintenance'),
                    ),
                  ],
                  onChanged: (value) => setState(() => type = value ?? type),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );

    if (saved != true || !context.mounted) {
      return;
    }

    try {
      await ref.read(adminManagementRepositoryProvider).createNotification({
        'title': titleController.text.trim(),
        'message': messageController.text.trim(),
        'type': type,
        'is_active': true,
      });
      ref.invalidate(adminNotificationsProvider);
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    } finally {
      titleController.dispose();
      messageController.dispose();
    }
  }
}

class _NotificationTile extends ConsumerWidget {
  const _NotificationTile({required this.notification});

  final AdminNotification notification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text(notification.title),
        subtitle: Text('${notification.type}\n${notification.message}'),
        isThreeLine: true,
        trailing: Wrap(
          spacing: 4,
          children: [
            Switch(
              value: notification.isActive,
              onChanged: (_) => _toggle(context, ref),
            ),
            IconButton(
              tooltip: 'Hapus',
              onPressed: () => _delete(context, ref),
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggle(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(adminManagementRepositoryProvider)
          .toggleNotification(notification.id);
      ref.invalidate(adminNotificationsProvider);
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await _confirm(context, 'Hapus notifikasi?');
    if (!confirmed || !context.mounted) {
      return;
    }

    try {
      await ref
          .read(adminManagementRepositoryProvider)
          .deleteNotification(notification.id);
      ref.invalidate(adminNotificationsProvider);
    } catch (error) {
      if (context.mounted) {
        _showError(context, error);
      }
    }
  }
}

class _DeliverySettingsTab extends ConsumerWidget {
  const _DeliverySettingsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deliveryEnabledProvider);

    return state.when(
      loading: () => _LoadingList(),
      error: (error, _) => AppErrorWidget(
        error: error,
        onRetry: () => ref.invalidate(deliveryEnabledProvider),
      ),
      data: (enabled) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: SwitchListTile(
              value: enabled,
              title: const Text('Delivery aktif'),
              subtitle: const Text('Mengatur ketersediaan checkout delivery.'),
              onChanged: (value) async {
                try {
                  await ref
                      .read(adminManagementRepositoryProvider)
                      .updateDeliveryEnabled(value);
                  ref.invalidate(deliveryEnabledProvider);
                } catch (error) {
                  if (context.mounted) {
                    _showError(context, error);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportSummaryTab extends ConsumerWidget {
  const _ReportSummaryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportSummaryProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(reportSummaryProvider),
      child: state.when(
        loading: () => _LoadingList(),
        error: (error, _) => AppErrorWidget(
          error: error,
          onRetry: () => ref.invalidate(reportSummaryProvider),
        ),
        data: (summary) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SummaryCard(
              label: 'Total transaksi',
              value: '${summary.totalTransactions}',
              icon: Icons.receipt_long,
            ),
            _SummaryCard(
              label: 'Total revenue',
              value: CurrencyFormatter.formatRupiah(summary.totalRevenue),
              icon: Icons.payments_outlined,
            ),
            _SummaryCard(
              label: 'Total item',
              value: '${summary.totalItems}',
              icon: Icons.inventory_2_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsWrap extends StatelessWidget {
  const _StatsWrap({required this.stats});

  final Map<String, dynamic> stats;

  @override
  Widget build(BuildContext context) {
    if (stats.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: stats.entries.map((entry) {
        return Chip(label: Text('${entry.key}: ${entry.value}'));
      }).toList(),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text(value, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}

class _LoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, __) => const LoadingWidget.listTile(),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemCount: 6,
    );
  }
}

Future<bool> _confirm(BuildContext context, String title) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Ya'),
            ),
          ],
        ),
      ) ??
      false;
}

void _showError(BuildContext context, Object error) {
  final message = error is AppException ? error.message : 'Aksi gagal.';
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
