import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Model/Expensedata.dart';

class HiveDatabase{
   final _mybox = Hive.box('Expense_Database');

   void saveData(List<ExpenseItem> allexpense){


      List<List<dynamic>> allexpenseformatted = [];

      for(var expense in allexpense){
         List<dynamic> expenseformatted = [
            expense.name,
            expense.amount,
            expense.dateTime,
         ];
         allexpenseformatted.add(expenseformatted);
      }
      _mybox.put("All_Expenses", allexpenseformatted);
   }

   List<ExpenseItem> readData(){

      List savedData = _mybox.get("All_Expenses") ?? [];
      List<ExpenseItem> allexpenses  = [];

      for(int i=0; i<savedData.length; i++){
         String name = savedData[i][0];
         String amount = savedData[i][1];
         DateTime datetime = savedData[i][2];
         ExpenseItem expense = ExpenseItem(
            name: name,
            amount: amount,
            dateTime: datetime,
         );


         allexpenses.add(expense);
      }

      return allexpenses;

   }

}