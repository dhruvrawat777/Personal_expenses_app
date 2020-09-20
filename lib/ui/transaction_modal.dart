import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/providers/transactionlist.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TransactionModal extends StatefulWidget {
  // final List<Transaction> transactionList;
  // TransactionModal({this.transactionList});
  @override
  _TransactionModalState createState() => _TransactionModalState();
}

class _TransactionModalState extends State<TransactionModal> {
  String dt = '';
  DateTime date = DateTime.now();
  void showdatepicker(BuildContext context) async {
    DateTime temp = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    setState(() {
      date = temp;
      dt = DateFormat().format(temp);
    });
  }

  final amountcontroller = TextEditingController();
  final titlecontroller = TextEditingController();

  void addtransaction(BuildContext ctx) async {
    final transactionData =
        Provider.of<TransactionList>(context, listen: false);
    /*  Transaction x = Transaction(
      //id: DateTime.now().toString(),
      amount: double.parse(amountcontroller.text),
      date: date,
      title: titlecontroller.text,
    ); */

    const url = 'https://apps-8d36b.firebaseio.com/transactions.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': titlecontroller.text,
          'amount': double.parse(amountcontroller.text),
          'date': date.toIso8601String(),
        }),
      );
      print('hi');
      print(response.body);
      var data = json.decode(response.body);

      Transaction x = Transaction(
        id: data['name'].toString(),
        amount: double.parse(amountcontroller.text),
        date: date,
        title: titlecontroller.text,
      );

      transactionData.addTransaction(x);
    } catch (error) {
      print(error);
    }
    /*  .then((response) {
      print(response.body);
      transactionData.addTransaction(x);
    }).catchError((error) {
      return showDialog<Null>(
          context: ctx,
          builder: (ct) => AlertDialog(
                title: Text('Error occured'),
                content: Text('Someting went wrong!'),
                actions: [
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ct).pop();
                    },
                  )
                ],
              ));
    }); */
  }

  bool validator() {
    if (dt == '' || titlecontroller.text == '' || amountcontroller.text == '') {
      return false;
    } else {
      return true;
    }
  }

  // set up the AlertDialog
  Widget alerter() {
    return AlertDialog(
      title: Text(
        "Error",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.normal,
        ),
      ),
      content: Text(
        "Fill all details!",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  final _f = FocusNode();

  @override
  void dispose() {
    _f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final transactionData = Provider.of<TransactionList>(context);
    // final transactionlist = transactionData.transactions;
    // transactionlist.add(Transaction(amount: 5,date: DateTime.now(),id: DateTime.now().toString(),title: 'hi');
    return Column(
      children: [
        // fieldmaker('Title', titlecontroller),
        // fieldmaker('Amount', amountcontroller),
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Enter title!';
            } else
              return null;
          },
          controller: titlecontroller,
          decoration: InputDecoration(
            labelText: 'Title',
          ),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_f);
          },
        ),
        TextFormField(
          controller: amountcontroller,
          validator: (value) {
            if (value.isEmpty)
              return 'Enger price!';
            else if (double.tryParse(value) == null)
              return 'Enter valid number!';
            else if (double.parse(value) <= 0)
              return 'Enter value greater than zero!';
            else
              return null;
          },
          decoration: InputDecoration(labelText: 'Amount'),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          focusNode: _f,
        ),
        Container(
          margin: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: Text(
            dt == '' ? 'No Date Chosen!' : dt,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(10),
              child: FlatButton(
                textColor: Colors.blue,
                child: Text('Choose Date'),
                onPressed: () {
                  showdatepicker(context);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: FlatButton(
                textColor: Colors.purple,
                child: Text('Add Transaction'),
                onPressed: () {
                  if (validator()) {
                    addtransaction(context);
                    Navigator.of(context).pop();
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alerter();
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
