import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:trac_manager/Custom/ExpenseListTile.dart';
import 'package:trac_manager/Custom/color.dart';
import 'package:trac_manager/Custom/summary.dart';
import 'package:trac_manager/Data/Expensedata.dart';
import 'package:trac_manager/Model/Expensedata.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController namec = TextEditingController();
  TextEditingController amountc = TextEditingController();

  void save() {
    ExpenseItem newexpense = ExpenseItem(
      name: namec.text,
      amount: amountc.text,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addnewExpense(newexpense);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void deleteExpense(ExpenseItem item) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(item);
  }

  void clear() {
    namec.clear();
    amountc.clear();
  }

  void addnewexpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add New Expense"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: namec,
                    decoration: const InputDecoration(hintText: "Name"),
                  ),
                  TextField(
                    controller: amountc,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "Amount"),
                  )
                ],
              ),
              actions: [
                MaterialButton(
                  color: btncolor,
                  onPressed: () {},
                  child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                ),
                MaterialButton(
                  color: btncolor,
                  onPressed: save,
                  child: const Text("Save", style: TextStyle(color: Colors.white),),
                ),

              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: bgcolor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: btncolor,
          onPressed: addnewexpense,
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            ExpenseSummary(startofweek: value.startoftheweek()),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                    name: value.overallexpense[index].name,
                    amount: value.overallexpense[index].amount,
                    dateTime: value.overallexpense[index].dateTime,
                  deleteexpense: (p0) => deleteExpense(value.overallexpense[index]),
                )),
          ],
        ),
      ),
    );
  }
}
