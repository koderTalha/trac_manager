import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  ExpenseTile({super.key, required this.name, required this.amount, required this.dateTime, required this.deleteexpense});

  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteexpense;


  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
              onPressed: deleteexpense,
            icon: Icons.delete,
            backgroundColor: Colors.red,

          ),

        ],
      ),

      child: ListTile(
        title: Text(name),
        subtitle: Text(dateTime.day.toString()+'-'+dateTime.month.toString()+'-'+dateTime.year.toString() ),
        trailing: Text('PKR '+amount),

      ),
    );
  }


}
