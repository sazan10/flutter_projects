import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
          ), //FittedBox is used to remove the wrapping caused by flexible
          SizedBox(
            //for adding gaps
            height: constraints.maxHeight * 0.05,
          ),
          Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                //Creates widgets one on top of another, takes width/height of parent(60,10)
                children: <Widget>[
                  Container(
                      //Forms box
                      decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(
                        220, 220, 220, 1), //inside color of bar/box
                  )),
                  FractionallySizedBox(
                    //create inside box within aovecontainer fractionally
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      //It needs to be child as FractionallySizedBox takes styling of children/not parent
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              )),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(height: constraints.maxHeight * 0.15, child: Text(label)),
        ],
      );
    });
  }
}
