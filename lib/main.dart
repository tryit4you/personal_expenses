import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';

void main(List<String> args) => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> transactions = [
    Transaction('t1', 'new shoes', 22.00, DateTime.now()),
    Transaction('t2', 'New avatar', 22.00, DateTime.now()),
    Transaction('t1', 'new shoes', 22.00, DateTime.now()),
    Transaction('t1', 'new shoes', 22.00, DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expense'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chart(),
              NewTransaction(),
              TransactionList(transactions)
            ],
          ),
        ),
      ),
    );
  }
}
