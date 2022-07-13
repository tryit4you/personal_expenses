import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _newTransaction;

  NewTransaction(this._newTransaction) {
    print('Constructor NewTransaction Widget');
  }

  @override
  _NewTransactionState createState() {
    print('CreateState New Transaction Widget');

    return _NewTransactionState();
  }
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

  @override
  void initState() {
    print('InitState()');

    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    print('didUpdateWidget(): ');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  _NewTransactionState() {
    print('Constructor NewTransaction State');
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
    print('Run build()');
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
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
      ),
    );
  }
}
