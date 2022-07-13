import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.removeTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function removeTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    var availableColors = [Colors.red, Colors.black, Colors.blue];
    _bgColor = availableColors[Random().nextInt(3)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
                child: Text('\$${widget.transaction.amount.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white))),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6.copyWith(),
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(widget.transaction.date),
          style: TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
            onPressed: () => widget.removeTransaction(widget.transaction.id),
            icon: Icon(
              Icons.remove_circle,
              color: Theme.of(context).errorColor,
            )),
      ),
    );
  }
}
