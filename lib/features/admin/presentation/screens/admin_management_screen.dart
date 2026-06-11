import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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

class _UsersTab extends ConsumerStatefulWidget {
  const _UsersTab();

  @override
  ConsumerState<_UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends ConsumerState<_UsersTab> {
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    final usersState = ref.watch(adminUsersProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(adminUsersProvider),
      child: usersState.when(
        loading: () => _LoadingList(),
        error: (error, _) => AppErrorWidget(
          error: error,
          onRetry: () => ref.invalidate(adminUsersProvider),
        ),
        data: (result) {
          final roles = _sortedUnique(result.users.map((user) => user.role));
          final users = _selectedRole == null
              ? result.users
              : result.users
                    .where((user) => user.role == _selectedRole)
                    .toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _FilterChips(
                label: 'Role',
                options: roles,
                selectedValue: _selectedRole,
                labelFor: _roleLabel,
                countFor: (role) =>
                    result.users.where((user) => user.role == role).length,
                onSelected: (value) => setState(() => _selectedRole = value),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => _showUserForm(context, ref),
                icon: const Icon(Icons.person_add_alt),
                label: const Text('Tambah User'),
              ),
              const SizedBox(height: 12),
              if (users.isEmpty)
                EmptyStateWidget(
                  icon: Icons.people_outline,
                  title: _selectedRole == null
                      ? 'Belum ada user'
                      : 'User ${_roleLabel(_selectedRole!)} kosong',
                  subtitle: _selectedRole == null
                      ? 'User admin, kasir, dan member akan tampil di sini.'
                      : 'Tidak ada user pada filter ini.',
                )
              else
                ...users.map(
                  (user) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _UserTile(user: user),
                  ),
                ),
            ],
          );
        },
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

class _NotificationsTab extends ConsumerStatefulWidget {
  const _NotificationsTab();

  @override
  ConsumerState<_NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends ConsumerState<_NotificationsTab> {
  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminNotificationsProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(adminNotificationsProvider),
      child: state.when(
        loading: () => _LoadingList(),
        error: (error, _) => AppErrorWidget(
          error: error,
          onRetry: () => ref.invalidate(adminNotificationsProvider),
        ),
        data: (result) {
          final types = _sortedUnique(
            result.notifications.map((notification) => notification.type),
          );
          final notifications = _selectedType == null
              ? result.notifications
              : result.notifications
                    .where((notification) => notification.type == _selectedType)
                    .toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _FilterChips(
                label: 'Tipe',
                options: types,
                selectedValue: _selectedType,
                labelFor: _notificationTypeLabel,
                countFor: (type) => result.notifications
                    .where((notification) => notification.type == type)
                    .length,
                onSelected: (value) => setState(() => _selectedType = value),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => _showNotificationForm(context, ref),
                icon: const Icon(Icons.add_alert_outlined),
                label: const Text('Tambah Notifikasi'),
              ),
              const SizedBox(height: 12),
              if (notifications.isEmpty)
                EmptyStateWidget(
                  icon: Icons.notifications_none,
                  title: _selectedType == null
                      ? 'Belum ada notifikasi'
                      : 'Notifikasi ${_notificationTypeLabel(_selectedType!)} kosong',
                  subtitle: _selectedType == null
                      ? 'Notifikasi broadcast akan tampil di sini.'
                      : 'Tidak ada notifikasi pada filter ini.',
                )
              else
                ...notifications.map(
                  (notification) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _NotificationTile(notification: notification),
                  ),
                ),
            ],
          );
        },
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
            _SummaryHeader(summary: summary),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth >= 620 ? 3 : 1;

                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: crossAxisCount == 1 ? 3.35 : 1.25,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _SummaryMetricCard(
                      label: 'Transaksi',
                      value: NumberFormat.decimalPattern(
                        'id_ID',
                      ).format(summary.totalTransactions),
                      icon: Icons.receipt_long_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    _SummaryMetricCard(
                      label: 'Revenue',
                      value: CurrencyFormatter.formatRupiah(
                        summary.totalRevenue,
                      ),
                      icon: Icons.payments_outlined,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    _SummaryMetricCard(
                      label: 'Item Terjual',
                      value: NumberFormat.decimalPattern(
                        'id_ID',
                      ).format(summary.totalItems),
                      icon: Icons.inventory_2_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips({
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.labelFor,
    required this.countFor,
    required this.onSelected,
  });

  final String label;
  final List<String> options;
  final String? selectedValue;
  final String Function(String value) labelFor;
  final int Function(String value) countFor;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    final total = options.fold<int>(0, (sum, option) => sum + countFor(option));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  selected: selectedValue == null,
                  label: Text('Semua ($total)'),
                  onSelected: (_) => onSelected(null),
                ),
              ),
              ...options.map(
                (option) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: selectedValue == option,
                    label: Text('${labelFor(option)} (${countFor(option)})'),
                    onSelected: (_) => onSelected(option),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

List<String> _sortedUnique(Iterable<String> values) {
  return values
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty && value != '-')
      .toSet()
      .toList()
    ..sort();
}

String _roleLabel(String role) {
  return switch (role) {
    'admin' => 'Admin',
    'kasir' => 'Kasir',
    'member' => 'Member',
    _ => role,
  };
}

String _notificationTypeLabel(String type) {
  return switch (type) {
    'info' => 'Info',
    'warning' => 'Warning',
    'success' => 'Success',
    'maintenance' => 'Maintenance',
    _ => type,
  };
}

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({required this.summary});

  final ReportSummary summary;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final average = summary.totalTransactions == 0
        ? 0
        : summary.totalRevenue / summary.totalTransactions;

    return Card(
      color: colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.analytics_outlined, color: colorScheme.onPrimary),
            const SizedBox(height: 14),
            Text(
              'Ringkasan penjualan',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              CurrencyFormatter.formatRupiah(summary.totalRevenue),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Rata-rata ${CurrencyFormatter.formatRupiah(average.toDouble())} per transaksi',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimary.withValues(alpha: 0.82),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryMetricCard extends StatelessWidget {
  const _SummaryMetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
