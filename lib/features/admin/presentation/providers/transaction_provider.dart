import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/transaction_model.dart';
import '../../data/repositories/transaction_repository.dart';

part 'transaction_provider.g.dart';

const allTransactionStatuses = <String>[
  'pending',
  'in_progress',
  'delivering',
  'completed',
  'paid',
  'canceled',
];

final transactionFilterProvider = StateProvider<TransactionFilter>((ref) {
  return const TransactionFilter();
});

class TransactionFilter {
  const TransactionFilter({this.status, this.date, this.fromDate, this.toDate});

  final String? status;
  final String? date;
  final DateTime? fromDate;
  final DateTime? toDate;

  bool get hasActiveFilter =>
      status != null || date != null || fromDate != null || toDate != null;

  TransactionFilter copyWith({
    Object? status = _sentinel,
    Object? date = _sentinel,
    Object? fromDate = _sentinel,
    Object? toDate = _sentinel,
  }) {
    return TransactionFilter(
      status: status == _sentinel ? this.status : status as String?,
      date: date == _sentinel ? this.date : date as String?,
      fromDate: fromDate == _sentinel ? this.fromDate : fromDate as DateTime?,
      toDate: toDate == _sentinel ? this.toDate : toDate as DateTime?,
    );
  }

  String? get apiFromDate => _formatDate(fromDate);

  String? get apiToDate => _formatDate(toDate);

  static String? _formatDate(DateTime? value) {
    if (value == null) {
      return null;
    }

    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');

    return '${value.year}-$month-$day';
  }
}

const Object _sentinel = Object();

@riverpod
TransactionRepository transactionRepository(Ref ref) {
  return TransactionRepository();
}

@riverpod
Future<List<TransactionModel>> transactions(Ref ref) {
  final filter = ref.watch(transactionFilterProvider);

  return ref
      .read(transactionRepositoryProvider)
      .getTransactions(
        status: filter.status,
        date: filter.date,
        fromDate: filter.apiFromDate,
        toDate: filter.apiToDate,
      );
}

@riverpod
Future<TransactionModel> transactionDetail(Ref ref, int id) {
  return ref.read(transactionRepositoryProvider).getTransaction(id);
}
