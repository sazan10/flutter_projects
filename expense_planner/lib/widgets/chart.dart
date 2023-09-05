import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactionValues {
    //Creating a List similar to transaction for weekdays(sun-sat) and also store total transaction of each day as multiple things could cost in a single day. It returns a list like
    //[{day: Fri, amount: 5585632225.0}, {day: Thu, amount: 0.0}, {day: Wed, amount: 0.0}, {day: Tue, amount: 0.0}, {day: Mon, amount: 0.0}, {day: Sun, amount: 0.0}, {day: Sat, amount: 0.0}] 
    return List.generate(7, (index) {
      //generates 7 elements for list starting from 0 to 6(index)
      final weekDay = DateTime.now().subtract(Duration(
          days:
              index)); //Generating today, yesterday, day before yesterday by subtracting index from current time
      double sum = 0;
      for (int i = 0; i < recentTransactions.length; i++) {
        //Transaction list may contain different transactions for different days, including multiple for same day
        if (recentTransactions[i].date.day ==
                weekDay
                    .day && //checking whether multiple transactions have occurred for same day in same month and same year
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year)
          sum = sum +
              recentTransactions[i]
                  .amount; // if yes calculating total cost for that day
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': sum
      }; //DateFormat converts numerical value of day into a specific format, here just the day(Thur, Wed)
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return  Card(
          elevation: 5,
          margin: EdgeInsets.all(20),
          child: Container(
            padding:EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,//distribute chart in space
                children: groupedTransactionValues.map((data) {
                  // return Text('${data['day']} ${data['amount']}');
                  return Flexible( //to restrict large labels to its restricted space
                    fit:FlexFit.tight,
                    child: ChartBar(
                        data['day'],
                        data['amount'],
                        totalSpending == 0
                            ? 0.0
                            : (data['amount'] as double) / totalSpending),
                  );
                }).toList()),
          ),
    );
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) { //fold is used to convert List into double/other type with initial value 0.0 of sum and item is the 
      return sum + item['amount'];
    });
  }
}
