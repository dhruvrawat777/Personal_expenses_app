import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/transactionlist.dart';

class Transactions extends StatelessWidget {
  // final List<Transaction> transactionList;
  //Transactions({@required this.transactionList});
  double getexpense(BuildContext ctx) {
    final pro = Provider.of<TransactionList>(ctx);
    return pro.total();
  }

  void deleter(BuildContext ctx, String id) {
    final pro = Provider.of<TransactionList>(ctx, listen: false);
    pro.deleter(id);
  }

  @override
  Widget build(BuildContext context) {
    final td = Provider.of<TransactionList>(context);
    final transactionlist = td.transactions;
    print(transactionlist);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          height: 100,
          child: Text(
            'Total Expenses:' + getexpense(context).toString(),
            style: TextStyle(
              color: Colors.orange,
              fontSize: 35,
            ),
          ),
        ),
        Expanded(
          //height: MediaQuery.of(context).size.height - 50,
          child: ListView.separated(
            separatorBuilder: (ctx, index) {
              return Divider(
                color: Colors.black54,
              );
            },
            itemBuilder: (ctx, index) {
              //return Text(transactionlist[index].amount.toString());
              return Container(
                width: 200,
                height: 100,
                child: ListTile(
                  leading: Icon(
                    Icons.account_box,
                    color: Colors.amber,
                    size: 80,
                  ),
                  title: Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      transactionlist[index].title,
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    'Rs: ' + transactionlist[index].amount.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Container(
                    padding: EdgeInsets.only(top: 12),
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 40,
                      ),
                      color: Colors.red,
                      onPressed: () {
                        deleter(ctx, transactionlist[index].id);
                      },
                    ),
                  ),
                ),
              );
            },
            itemCount: transactionlist.length,
          ),
        ),
      ],
    );
  }
}
