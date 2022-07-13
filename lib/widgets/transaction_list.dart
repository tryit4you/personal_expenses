import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;
  final AppBar appBar;
  final double status;
  final bool isLandScape;
  // final bool isLandScape;
  TransactionList(this.transactions, this.removeTransaction,
      [this.isLandScape = false, this.appBar, this.status]);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height -
          (isLandScape == true ? appBar.preferredSize.height + 30 : 0),
      child: transactions.isEmpty
          ? Image.asset(
              'assets/images/no-data.jpg',
              fit: BoxFit.cover,
            )
          : ListView(
              scrollDirection: Axis.vertical,
              children: transactions.map((tx) {
                return TransactionItem(
                    key: ValueKey(tx.id),
                    transaction: tx,
                    removeTransaction: removeTransaction);
              }).toList()),
    );
  }
}
