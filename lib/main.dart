import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/landscape_mode.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/portrait_mode.dart';

void main(List<String> args) {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Color.fromARGB(255, 89, 202, 132),
          fontFamily: 'QuickSand',
          textTheme: TextTheme(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: TextStyle(color: Colors.white)),
          buttonColor: Theme.of(context).primaryColor,
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20)))),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> transactions = [];
  void _newTransaction(String title, double amount, DateTime choosenDate) {
    setState(() {
      transactions.add(Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: choosenDate));
    });
  }

  List<Transaction> get _recentTransaction {
    return transactions
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _presentBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_newTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _removeTransaction(String id) {
    setState(() {
      this.transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var statusSize = MediaQuery.of(context).padding.top;
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var appBar = AppBar(
      title: const Text('Personal Expense'),
      actions: [
        IconButton(
            onPressed: () => _presentBottomSheet(), icon: Icon(Icons.add))
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: isLandScape
              ? LandscapeMode(screenSize, appBar, statusSize,
                  this._recentTransaction, transactions, _removeTransaction)
              : PortraitMode(screenSize, statusSize, appBar,
                  this._recentTransaction, transactions, _removeTransaction)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _presentBottomSheet(),
        child: Icon(
          Icons.add,
          color: Theme.of(context).textTheme.button.color,
        ),
      ),
    );
  }
}
