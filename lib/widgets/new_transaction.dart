import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  NewTransaction(this._newTransaction);
  final Function _newTransaction;
  var titleController = TextEditingController();
  var amountController = TextEditingController();
  void submitData() {
    var inputTitle = titleController.text;
    var inputAmount = amountController.text;
    _newTransaction;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Title',
              prefixIcon: Icon(Icons.title),
            ),
            controller: titleController,
            onSubmitted: (_) => submitData,
          ),
          TextField(
              controller: amountController,
              onSubmitted: (_) => submitData,
              decoration: const InputDecoration(
                  labelText: 'Amount', prefixIcon: Icon(Icons.money))),
          TextButton(
              onPressed: () => submitData, child: Text('Add Transaction'))
        ],
      ),
    );
  }
}
