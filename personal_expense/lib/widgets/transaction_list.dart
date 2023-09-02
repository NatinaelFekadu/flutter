import 'package:flutter/material.dart';

import 'package:personal_expense/models/transcation.dart';
import 'package:personal_expense/widgets/transaction_items.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;
  const TransactionList(this._transactions, this._deleteTransaction,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
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
                  transaction: _transactions[index],
                  deleteTransaction: _deleteTransaction);
            },
            itemCount: _transactions.length,
          );
  }
}
