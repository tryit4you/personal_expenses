import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';

class LandscapeMode extends StatelessWidget {
  final Size screenSize;
  final double statusSize;
  final AppBar appBar;
  final List<Transaction> recentTransactions;
  final Function removeTransaction;
  final List<Transaction> transactions;

  const LandscapeMode(this.screenSize, this.appBar, this.statusSize,
      this.recentTransactions, this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: (screenSize.width) * 0.4,
              child: Chart(this.recentTransactions)),
          Container(
              width: (screenSize.width) * 0.55,
              child: TransactionList(
                  transactions, removeTransaction, true, appBar, statusSize))
        ],
      ),
    );
  }
}
