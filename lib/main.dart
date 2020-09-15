import 'package:flutter/material.dart';
import 'package:personal_expenses/ui/Transactions.dart';
import 'package:personal_expenses/ui/transaction_modal.dart';
import './providers/transactionlist.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) {
        return TransactionList();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final List<Transaction> transactionList = [];
  void modalshower(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          //return TransactionModal(transactionList: transactionList);
          return TransactionModal();
        });
  }

  Widget fab() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              modalshower(context);
            },
          ),
        ],
      ),
      body: Transactions(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          modalshower(context);
        },
      ),
    );
  }
}
