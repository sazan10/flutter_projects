import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child:SingleChildScrollView(
        padding: EdgeInsets.only(top:10,bottom:MediaQuery.of(context).viewInsets.bottom+10,left:10,right:10),//viewINset gives dimension of anything overlapping the view... if not used the input fields will be totally overlapped by the keyboard so adding padding below the input filed container for keyboard
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData()
                // onChanged: (value) {
                //   titleName = value;
                // },
                ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) =>
                  _submitData(), //i have an argument but i dont care as it is required for onSubmitted
              // onChanged: (value) {
              //   amountName = value;
              // },
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text(_selectedDate == null
                      ? 'No date chosen'
                      : DateFormat.MMMd().format(_selectedDate)),
                  FlatButton(
                    child: Text('Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColorDark,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }

  void _submitData() {
    if(_titleController.text.isEmpty || _amountController.text.isEmpty)
    {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null) return;
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate=pickedDate;
      });
    });
    print("button pressed");
  }
}
