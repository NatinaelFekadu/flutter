import 'package:personal_expense/models/transcation.dart';

abstract class TransactionEvent {}

class AddTransactionEvent extends TransactionEvent {
  final Transaction transaction;
  AddTransactionEvent({required this.transaction});
}

class DeleteTransactionEvent extends TransactionEvent {
  final String id;
  DeleteTransactionEvent({required this.id});
}
