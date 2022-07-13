import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactionValues {
    List<Map<String, Object>> groupeds = [];
    var weekDay = List.generate(
        7, (index) => DateTime.now().subtract(Duration(days: index)));
    for (int i = 0; i < weekDay.length; i++) {
      double amount = recentTransactions.where((tx) {
        return tx.date.day == weekDay[i].day &&
            tx.date.month == weekDay[i].month &&
            tx.date.year == weekDay[i].year;
      }).fold(0.0, (pre, tx) => pre += tx.amount);
      groupeds.add(
        {
          'day': DateFormat.E().format(weekDay[i]).substring(0, 2),
          'amount': amount
        },
      );
    }
    return groupeds.reversed.toList();
  }

  double get getTotalAmountOfWeeken {
    return groupedTransactionValues.fold(
        0.0,
        (previousValue, element) =>
            previousValue += (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Text(
            'Your Transaction in Weeken',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          elevation: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((tx) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  title: tx['day'],
                  amount: tx['amount'],
                  totalAmount: getTotalAmountOfWeeken == 0
                      ? 0
                      : (tx['amount'] as double) / getTotalAmountOfWeeken,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
