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
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(25),
            /* BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25), */
          ),
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 1),
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          height: 100,
          child: Text(
            'Total Expenses:' + getexpense(context).toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        Expanded(
          //height: MediaQuery.of(context).size.height - 50,
          child: Container(
            decoration: BoxDecoration(
                //color: Colors.lime,
                //border: Border.all(color: Colors.black),
                // borderRadius: BorderRadius.circular(25),
                ),
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
                      color: Colors.blue,
                      size: 80,
                    ),
                    title: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        transactionlist[index].title,
                        style: TextStyle(
                          fontSize: 25,
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
        ),
      ],
    );
  }
}
