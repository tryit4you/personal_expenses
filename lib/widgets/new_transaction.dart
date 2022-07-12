import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _newTransaction;

  NewTransaction(this._newTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime dateChoosen;

  void submitData() {
    var inputTitle = titleController.text;
    var inputAmount = amountController.text;
    if (inputTitle == null ||
        (inputAmount == null || inputAmount.isEmpty) ||
        dateChoosen == null) {
      return;
    }

    widget._newTransaction(inputTitle, double.parse(inputAmount), dateChoosen);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime(2099))
        .then((pickedDate) {
      setState(() {
        dateChoosen = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  dateChoosen == null
                      ? Text('No date choosen!')
                      : Text(
                          'Date Picked: ${DateFormat('dd/MM/yyyy').format(dateChoosen)}'),
                  TextButton(
                    onPressed: () => _presentDatePicker(),
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () => submitData(),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).textTheme.button.color)),
                child: Text(
                  'Add Transaction',
                ))
          ],
        ),
      ),
    );
  }
}
