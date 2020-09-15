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
}
