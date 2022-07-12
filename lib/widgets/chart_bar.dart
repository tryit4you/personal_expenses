import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String title;
  final double amount;
  final double totalAmount;
  const ChartBar({this.title, this.amount, this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          Container(
            child: FittedBox(child: Text('\$${amount.toStringAsFixed(2)}')),
            height: 25,
          ),
          Container(
            width: 10,
            height: 100,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 1),
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30)),
                ),
                FractionallySizedBox(
                  heightFactor: totalAmount,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                )
              ],
            ),
          ),
          Text(
            '${title}',
            style: TextStyle(fontWeight: FontWeight.w200),
          )
        ],
      ),
    );
  }
}
