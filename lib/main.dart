import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  List<Transaction> transactions = [];
  var appState = '';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _presentBottomSheet(BuildContext context) {
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
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              children: [
                IconButton(
                    onPressed: () => _newTransaction, icon: Icon(Icons.add))
              ],
            ),
          )
        : AppBar(
            title: const Text('Personal Expense'),
            actions: [
              IconButton(
                  onPressed: () => _presentBottomSheet(context),
                  icon: Icon(Icons.add))
            ],
          );
    final pageBody = Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: isLandScape
            ? LandscapeMode(screenSize, appBar, statusSize,
                this._recentTransaction, transactions, _removeTransaction)
            : PortraitMode(screenSize, statusSize, appBar,
                this._recentTransaction, transactions, _removeTransaction));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _presentBottomSheet(context),
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).textTheme.button.color,
                    ),
                  ),
          );
  }
}
