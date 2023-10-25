import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:trac_manager/Data/Hive_database.dart';
import 'package:trac_manager/Helper/DateTimeHelper.dart';
import '../Model/Expensedata.dart';

class ExpenseData extends ChangeNotifier{
  List<ExpenseItem> overallexpense = [];
  final db = HiveDatabase();
  List<ExpenseItem> getAllExpenseList(){
    return overallexpense;
  }

  void prepareData() {
    if(db.readData().isNotEmpty){
      overallexpense =db.readData();

    }
  }

  void addnewExpense (ExpenseItem item){
    overallexpense.add(item);
    db.saveData(overallexpense);
    notifyListeners();
  }

  void deleteExpense (ExpenseItem item){
    overallexpense.remove(item);
    db.saveData(overallexpense);
    notifyListeners();
  }

  String getDayname(DateTime dateTime){
    switch(dateTime.weekday){
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return '';
    }
  }


  DateTime startoftheweek(){
    DateTime? startofweek;

    DateTime today  = DateTime.now();
    for(int i=0; i<7; i++){
      if(getDayname(today.subtract(Duration(days: i))) == 'Sun'){
        startofweek = today.subtract(Duration(days: i));
      }
    }
    return startofweek!;
  }

  Map<String, double> calculateAmountDaily(){
    Map<String, double> dailyexpense = {

    };

    for(var expense in overallexpense){
      String date = convertdatetimetostring(expense.dateTime);
      double amount = double.parse(expense.amount);

      if(dailyexpense.containsKey(date)){
        double CurrentAmount = dailyexpense[date]!;
        CurrentAmount += amount;
        dailyexpense[date] = CurrentAmount;
      }else{
        dailyexpense.addAll({date: amount});
      }
    }
    return dailyexpense;
  }

}