import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:personal_expense/bloc/transaction_bloc.dart';
import 'package:personal_expense/bloc/transaction_state.dart';
import 'package:personal_expense/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: state.recentTransactions
                  .map((transaction) => Flexible(
                        fit: FlexFit.tight,
                        child: ChartBar(
                            transaction['day'] as String,
                            state.totalSpending == 0.0
                                ? 0.0
                                : (transaction['amount'] as double) /
                                    state.totalSpending,
                            transaction['amount'] as double),
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
