import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:personal_expense/bloc/transaction_event.dart';
import 'package:personal_expense/bloc/transaction_state.dart';
import 'package:personal_expense/models/transcation.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc()
      : super(InitialState(transactions: [
          Transaction(
            id: 't1',
            title: "New Shoes",
            amount: 56.99,
            date: DateTime.now(),
          ),
          Transaction(
            id: 't2',
            title: "Weekly Groceries",
            amount: 16.99,
            date: DateTime.now().subtract(const Duration(days: 1)),
          ),
          Transaction(
            id: 't3',
            title: "Football Ticket",
            amount: 20.99,
            date: DateTime.now().subtract(const Duration(days: 1)),
          ),
          Transaction(
            id: 't4',
            title: "Bus Fee",
            amount: 10.99,
            date: DateTime.now().subtract(const Duration(days: 2)),
          ),
          Transaction(
            id: 't5',
            title: "Bus Fee",
            amount: 10.99,
            date: DateTime.now().subtract(const Duration(days: 2)),
          ),
          Transaction(
            id: 't6',
            title: "Bus Fee",
            amount: 10.99,
            date: DateTime.now().subtract(const Duration(days: 2)),
          ),
        ])) {
    on<AddTransactionEvent>((event, emit) {
      state.transactions.add(event.transaction);
      emit(UpdateTransactions(transactions: state.transactions));
    });

    on<DeleteTransactionEvent>(
      (event, emit) {
        state.transactions.removeWhere((element) => element.id == event.id);
        emit(UpdateTransactions(transactions: state.transactions));
      },
    );
    void updateRecentTransactions(){
      
    }
  }
}
