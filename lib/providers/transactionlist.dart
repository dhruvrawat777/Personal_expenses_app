import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  void eraser() {
    _transactionList.clear();
    notifyListeners();
  }

  double total() {
    double x = 0;
    for (int i = 0; i < _transactionList.length; ++i) {
      x += _transactionList[i].amount;
    }
    return double.parse((x).toStringAsFixed(3));
  }

  /*  void deleter(String id) {
    _transactionList.removeWhere((element) => element.id == id);
    notifyListeners();
  } */

  void deleteTransaction(String id) {
    print(id.runtimeType);
    print(id);
    final url = 'https://apps-8d36b.firebaseio.com/transactions/$id.json';
    final existingIndex =
        _transactionList.indexWhere((element) => element.id == id);
    var existingTrans = _transactionList[existingIndex];
    // _transactionList.retainWhere((trans) => trans.id == id);
    _transactionList.removeAt(existingIndex);
    http.delete(url).then((_) {
      existingTrans = null;
    }).catchError((_) {
      _transactionList.insert(existingIndex, existingTrans);
    });
    //_transactionList.removeAt(existingIndex);

    notifyListeners();
  }

  Future<void> fetchAndSet() async {
    const url = 'https://apps-8d36b.firebaseio.com/transactions.json';
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      print('hi');
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Transaction> loadedProducts = [];
      extractedData.forEach((id, prodData) {
        loadedProducts.add(
          Transaction(
              amount: prodData['amount'],
              id: id,
              date: DateTime.parse(prodData['date']),
              title: prodData['title']),
        );
      });
      _transactionList += loadedProducts;
      print(loadedProducts);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
