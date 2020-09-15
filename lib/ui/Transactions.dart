import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transactionlist.dart';

class Transactions extends StatelessWidget {
  // final List<Transaction> transactionList;
  //Transactions({@required this.transactionList});
  @override
  Widget build(BuildContext context) {
    final td = Provider.of<TransactionList>(context);
    final transactionlist = td.transactions;
    print(transactionlist);
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Text(transactionlist[index].amount.toString());
      },
      itemCount: transactionlist.length,
    );
  }
}
