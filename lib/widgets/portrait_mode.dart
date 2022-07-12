import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';

class PortraitMode extends StatelessWidget {
  final Size screenSize;
  final double statusSize;
  final AppBar appBar;
  final List<Transaction> recentTransactions;
  final Function removeTransaction;
  final List<Transaction> transactions;
  PortraitMode(this.screenSize, this.statusSize, this.appBar,
      this.recentTransactions, this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: (screenSize.height -
                      statusSize -
                      appBar.preferredSize.height) *
                  0.3,
              child: Chart(this.recentTransactions)),
          Container(
              height: (screenSize.height -
                      statusSize -
                      appBar.preferredSize.height) *
                  0.7,
              child: TransactionList(transactions, removeTransaction))
        ],
      ),
    );
  }
}
