import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/providers/transactionlist.dart';
import 'package:provider/provider.dart';

class TransactionModal extends StatefulWidget {
  // final List<Transaction> transactionList;
  // TransactionModal({this.transactionList});
  @override
  _TransactionModalState createState() => _TransactionModalState();
}

class _TransactionModalState extends State<TransactionModal> {
  Widget fieldmaker(String title, TextEditingController controller) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextField(
        controller: controller,
        keyboardType:
            title == 'Amount' ? TextInputType.number : TextInputType.name,
        decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(
            fontSize: 20,
          ),
          contentPadding: EdgeInsets.all(2),
        ),
      ),
    );
  }

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

  void addtransaction(BuildContext ctx) {
    final transactionData =
        Provider.of<TransactionList>(context, listen: false);
    transactionData.addTransaction(
      Transaction(
        id: DateTime.now().toString(),
        amount: double.parse(amountcontroller.text),
        date: date,
        title: titlecontroller.text,
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    // final transactionData = Provider.of<TransactionList>(context);
    // final transactionlist = transactionData.transactions;
    // transactionlist.add(Transaction(amount: 5,date: DateTime.now(),id: DateTime.now().toString(),title: 'hi');
    return Column(
      children: [
        fieldmaker('Title', titlecontroller),
        fieldmaker('Amount', amountcontroller),
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

                    Navigator.pop(context);
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
