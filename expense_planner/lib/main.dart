import 'dart:io';
import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.purple,
        primarySwatch: Colors.purple,
        fontFamily: 'QuickSand',
        errorColor: Colors.purple,
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ))),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleName;
  // String amountName;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  bool _showChart = false;
  final List<Transaction> _userTransaction = [
    // Transaction(id: '1', title: "New shoes", amount: 59, date: DateTime.now()),
    // Transaction(id: '2', title: "Grocery", amount: 19, date: DateTime.now()),
  ];
  void _addNewTransaction(String txTitle, double txAmount, DateTime newDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: newDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((item) => (id == item.id));
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  List<Transaction> get _recentTransactions {
    //generate a new list where all transactions before 7 days are neglected using getter
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList(); //Need to convert it to list as we are expecting List of Transaction but where returns Iterable
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: Text("Expense Planner"),

      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
        )
      ],
    );
    final txList = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransaction, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            children: [
              // Card(
              //   child: Container(
              //       color: Colors.blue,
              //       width: double.infinity,
              //       child: Text("Widget Playground")),
              //   elevation: 6,
              // ),
              if (!isLandscape)
                Container(
                    height: (MediaQuery.of(context)
                                .size
                                .height - //get total height of screen
                            appBar.preferredSize
                                .height - //retrieve height of appBar
                            MediaQuery.of(context)
                                .padding
                                .top) * //retrieve height of status bar
                        0.3,
                    child: Chart(_recentTransactions)),
              if (!isLandscape)
                txList,
              if (isLandscape)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('show Chart'),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ]),

              if (isLandscape)
                _showChart
                    ? Container(
                        height: (MediaQuery.of(context)
                                    .size
                                    .height - //get total height of screen
                                appBar.preferredSize
                                    .height - //retrieve height of appBar
                                MediaQuery.of(context)
                                    .padding
                                    .top) * //retrieve height of status bar
                            0.7,
                        child: Chart(_recentTransactions))
                    : txList,
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => startAddNewTransaction(context),
            ),
    );
  }
}
