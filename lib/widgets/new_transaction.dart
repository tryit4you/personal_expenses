import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function _newTransaction;

  NewTransaction(this._newTransaction);

  var titleController = TextEditingController();
  var amountController = TextEditingController();

  void submitData() {
    var inputTitle = titleController.text;
    var inputAmount = amountController.text;
    if (inputTitle == null || inputAmount == null) {
      return;
    }

    _newTransaction(inputTitle, double.parse(inputAmount));
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
            keyboardType: TextInputType.text,
            controller: titleController,
            onSubmitted: (_) => submitData(),
          ),
          TextField(
              controller: amountController,
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Amount', prefixIcon: Icon(Icons.money))),
          TextButton(
              onPressed: () => submitData(), child: Text('Add Transaction'))
        ],
      ),
    );
  }
}
