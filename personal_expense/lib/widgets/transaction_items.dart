import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/bloc/transaction_bloc.dart';
import 'package:personal_expense/bloc/transaction_event.dart';

import 'package:personal_expense/models/transcation.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required Transaction transaction,
  }) : _transaction = transaction;

  final Transaction _transaction;

  @override
  Widget build(BuildContext context) {
    final transactionBloc = (context).read<TransactionBloc>();
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: FittedBox(
              child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text('\$${_transaction.amount}'))),
        ),
        title: Text(
          _transaction.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(_transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 500
            ? TextButton.icon(
                icon: const Icon(
                  Icons.delete,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                onPressed: () {
                  transactionBloc
                      .add(DeleteTransactionEvent(id: _transaction.id));
                },
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () {
                  transactionBloc
                      .add(DeleteTransactionEvent(id: _transaction.id));
                },
              ),
      ),
    );
  }
}
