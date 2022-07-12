import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _removeTransaction;
  const TransactionList(this.transactions, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      width: double.infinity,
      child: transactions.isEmpty
          ? Image.asset(
              'assets/images/no-data.jpg',
              fit: BoxFit.cover,
            )
          : ListView.builder(
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
                            _removeTransaction(transactions[index].id),
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
