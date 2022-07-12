import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

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
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: transactions.length,
              itemBuilder: (_, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.white))),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6.copyWith(),
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy').format(transactions[index].date),
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                        onPressed: () =>
                            removeTransaction(transactions[index].id),
                        icon: Icon(
                          Icons.remove_circle,
                          color: Theme.of(context).errorColor,
                        )),
                  ),
                );
              },
            ),
    );
  }
}
