import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  const NewTransaction({Key key}) : super(key: key);
  void _newTransaction() {}
  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var amountController = TextEditingController();
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Title',
              prefixIcon: Icon(Icons.title),
            ),
            controller: titleController,
            onSubmitted: (_) => _newTransaction,
          ),
          TextField(
              controller: amountController,
              onSubmitted: (_) => _newTransaction,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixIcon: Icon(Icons.currency_exchange),
              )),
          TextButton(onPressed: () {}, child: Text('Add Transaction'))
        ],
      ),
    );
  }
}
