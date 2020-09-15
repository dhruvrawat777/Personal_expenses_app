import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionList with ChangeNotifier {
  List<Transaction> _transactionList = [];

  List<Transaction> get transactions {
    return [..._transactionList];
  }

  void addTransaction(Transaction x) {
    //_transactionList.add();
    _transactionList.add(x);
    notifyListeners();
  }

  double total() {
    double x = 0;
    for (int i = 0; i < _transactionList.length; ++i) {
      x += _transactionList[i].amount;
    }
    return double.parse((x).toStringAsFixed(3));
  }

  void deleter(String id) {
    _transactionList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
