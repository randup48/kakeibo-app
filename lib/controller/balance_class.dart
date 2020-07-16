import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kakeibo/model/transaction.dart';

class Balance with ChangeNotifier {
  int cash = 0;
  int savings = 0;
  List<Transaction> _transcation = [];

  Balance() {
    syncData();
  }

  Future syncData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var transactionData = prefs.getStringList('Transaction');
      var cashData = prefs.getInt('cash');
      var savingsData = prefs.getInt('savings');

      if (transactionData != null) {
        _transcation = transactionData
            .map((e) => Transaction.fromMap(json.decode(e)))
            .toList();
      }

      if (cashData != null) {
        cash = cashData;
      }

      if (savingsData != null) {
        savings = savingsData;
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  List<String> _listCategory = [
    'Food',
    'Social Life',
    'Self-development',
    'Transport',
    'Culture',
    'Household',
    'Apprel',
    'Beauty',
    'Health',
    'Education',
    'Gift',
    'Other'
  ];

  UnmodifiableListView<String> get category {
    return UnmodifiableListView(_listCategory);
  }

  UnmodifiableListView get transaction {
    return UnmodifiableListView(_transcation);
  }

  void addCash(String cashInput) {
    cash += int.parse(cashInput);
    updateCash();
    notifyListeners();
  }

  void addSavings(String savingsInput, DateTime dateTime) {
    final saving = Transaction(
      amount: int.parse(savingsInput),
      category: 'Savings',
      content: 'Savings',
      date: dateTime,
    );
    _transcation.add(saving);
    savings += int.parse(savingsInput);
    cash -= int.parse(savingsInput);
    updateList();
    updateSavings();
    updateCash();
    notifyListeners();
  }

  void deleteAll() {
    _transcation.clear();
    cash = 0;
    savings = 0;
    updateCash();
    updateSavings();
    updateList();
  }

  void deleteThisMonth(DateTime dateTime) {
    _transcation.removeWhere((e) => e.date.month == dateTime.month);
    updateList();
  }

  void takenSavings(
      String takensavingsInput, DateTime dateTime, String content) {
    final takensaving = Transaction(
      amount: int.parse(takensavingsInput),
      category: 'Taken Savings',
      content: content,
      date: dateTime,
    );
    _transcation.add(takensaving);
    savings -= int.parse(takensavingsInput);
    updateList();
    updateSavings();
    notifyListeners();
  }

  void addTransaction(String dropdownInput, String amountInput,
      String contentInput, DateTime dateInput) {
    final transaction = Transaction(
      category: dropdownInput,
      amount: int.parse(amountInput),
      content: contentInput,
      date: dateInput,
    );
    _transcation.add(transaction);
    cash -= int.parse(amountInput);
    updateList();
    updateCash();
    notifyListeners();
  }

  Future updateList() async {
    try {
      List<String> theTransactoin =
          _transcation.map((e) => json.encode(e.toMap())).toList();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setStringList('Transaction', theTransactoin);
    } catch (e) {
      print(e);
    }
  }

  Future updateCash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('cash', cash);
  }

  Future updateSavings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('savings', savings);
  }
}
