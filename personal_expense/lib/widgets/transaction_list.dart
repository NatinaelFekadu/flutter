import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expense/bloc/transaction_bloc.dart';
import 'package:personal_expense/bloc/transaction_state.dart';

import 'package:personal_expense/widgets/transaction_items.dart';

class TransactionList extends StatelessWidget {
  // final Function _deleteTransaction;
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return state.transactions.isEmpty
            ? LayoutBuilder(
                builder: (ctx, constraints) {
                  return Column(
                    children: [
                      Text(
                        'No transactions added yet!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          './lib/assets/images/download.jpg',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  );
                },
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return TransactionItem(
                    transaction: state.transactions[index],
                  );
                },
                itemCount: state.transactions.length,
              );
      },
    );
  }
}
