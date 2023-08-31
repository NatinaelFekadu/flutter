import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransactionHandler;

  NewTransaction(this._addTransactionHandler, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void _submitData() {
    final enteredTitle = titleController.text;
    final enterdAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enterdAmount <= 0) {
      return;
    }

    widget._addTransactionHandler(enteredTitle, enterdAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              onSubmitted: (_) => _submitData(),
              keyboardType: TextInputType.number,
            ),
            TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.purple),
                onPressed: _submitData,
                child: const Text('Add Transaction'))
          ],
        ),
      ),
    );
  }
}
