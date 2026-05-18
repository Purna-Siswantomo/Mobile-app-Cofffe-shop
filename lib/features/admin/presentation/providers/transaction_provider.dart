import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/transaction_model.dart';
import '../../data/repositories/transaction_repository.dart';

part 'transaction_provider.g.dart';

@riverpod
TransactionRepository transactionRepository(Ref ref) {
  return TransactionRepository();
}

@riverpod
Future<List<TransactionModel>> transactions(Ref ref) {
  return ref.read(transactionRepositoryProvider).getTransactions();
}

@riverpod
Future<TransactionModel> transactionDetail(Ref ref, int id) {
  return ref.read(transactionRepositoryProvider).getTransaction(id);
}
