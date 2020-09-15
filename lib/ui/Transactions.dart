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
    return Column(
      children: [
        Card(
          child: Text('hgi'),
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
