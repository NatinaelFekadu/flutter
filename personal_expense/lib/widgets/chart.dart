import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transcation.dart';
import 'package:personal_expense/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  const Chart(this.recentTransaction, {super.key});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekday = DateTime.now().subtract(Duration(days: index));
        var totalSum = 0.0;

        for (var i = 0; i < recentTransaction.length; i++) {
          if (recentTransaction[i].date.day == weekday.day &&
              recentTransaction[i].date.month == weekday.month &&
              recentTransaction[i].date.year == weekday.year) {
            totalSum += recentTransaction[i].amount;
          }
        }
        return {
          'day': DateFormat.E().format(weekday).substring(0, 1),
          'amount': totalSum
        };
      },
    );
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (sum, element) => sum + (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map((transaction) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        transaction['day'] as String,
                        totalSpending == 0.0
                            ? 0.0
                            : (transaction['amount'] as double) / totalSpending,
                        transaction['amount'] as double),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
