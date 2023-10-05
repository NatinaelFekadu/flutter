import 'package:personal_expense/models/transcation.dart';
import 'package:intl/intl.dart';

List<Map<String, Object>> getGroupedRecentTransactions(
    List<Transaction> transactions) {
  final recentTransactions = transactions
      .where(
        (transaction) => transaction.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        ),
      )
      .toList();
  return List.generate(
    7,
    (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum
      };
    },
  ).reversed.toList();
}

double totalSpending(List<Transaction> transactions) {
  return getGroupedRecentTransactions(transactions)
      .fold(0.0, (sum, element) => sum + (element['amount'] as double));
}

class TransactionState {
  final List<Transaction> transactions;
  final List<Map<String, Object>> recentTransactions;
  final double totalSpending;
  TransactionState(
      {required this.transactions,
      required this.recentTransactions,
      required this.totalSpending});
}

class InitialState extends TransactionState {
  InitialState({required List<Transaction> transactions})
      : super(
            transactions: transactions,
            recentTransactions: getGroupedRecentTransactions(transactions),
            totalSpending: totalSpending(transactions));
}

class UpdateTransactions extends TransactionState {
  UpdateTransactions({required List<Transaction> transactions})
      : super(
          transactions: transactions,
          recentTransactions: getGroupedRecentTransactions(transactions),
          totalSpending: totalSpending(transactions),
        );
}
