import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransaction;
  final Function _delTx;
  TransactionList(this._userTransaction, this._delTx);
  @override
  Widget build(BuildContext context) {
    return _userTransaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.1,
                  child: Text('No transaction added yet!',
                      style: Theme.of(context).textTheme.title),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                  height: constraints.maxHeight * 0.75,
                  child: Image.asset(
                    'assets/images/6.jpg',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: _userTransaction.length,
            itemBuilder: (ctx, index) {
              return
                  // Card(
                  //   child: Row(children: [
                  //     Container(
                  //         margin: EdgeInsets.symmetric(
                  //             vertical: 10, horizontal: 15),
                  //         padding: EdgeInsets.symmetric(
                  //             vertical: 10, horizontal: 10),
                  //         decoration: BoxDecoration(
                  //             border:
                  //                 Border.all(color: Colors.purple, width: 2)),
                  //         child: Text(
                  //             '\$${_userTransaction[index].amount.toStringAsFixed(2)}',
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 20,
                  //                 color: Colors.purple))),
                  //     Column(
                  //       children: [
                  //         Text(
                  //           _userTransaction[index].title,
                  //           // style: TextStyle(
                  //           //     fontWeight: FontWeight.bold,
                  //           //     fontSize: 16,
                  //           //     color: Colors.black)
                  //           style: Theme.of(context).textTheme.title,
                  //         ),
                  //         Text(
                  //             DateFormat.yMMMd()
                  //                 .format(_userTransaction[index].date),
                  //             style: TextStyle(color: Colors.grey)),
                  //       ],
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //     ),
                  //   ]),
                  // );
                  Card(
                margin: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    //leading/first element
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: FittedBox(
                        //to shrink longer items
                        child: Text(
                            '\$${_userTransaction[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(_userTransaction[index].title, //seocond element
                      style: Theme.of(context).textTheme.title),
                  subtitle: Text(
                    DateFormat.yMMMd() //element below title
                        .format(_userTransaction[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          label: Text("Delete"),
                          onPressed: () => _delTx(_userTransaction[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => _delTx(_userTransaction[index].id),
                        ), //last element
                ),
              );
            },
          );
  }
}
