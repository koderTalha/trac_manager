import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trac_manager/Bargraph/bargraph.dart';
import 'package:trac_manager/Custom/color.dart';
import 'package:trac_manager/Data/Expensedata.dart';
import 'package:trac_manager/Helper/DateTimeHelper.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startofweek;

  const ExpenseSummary({super.key, required this.startofweek});

  double calculatemaxbarh(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturady,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateAmountDaily()[sunday] ?? 0,
      value.calculateAmountDaily()[monday] ?? 0,
      value.calculateAmountDaily()[tuesday] ?? 0,
      value.calculateAmountDaily()[wednesday] ?? 0,
      value.calculateAmountDaily()[thursday] ?? 0,
      value.calculateAmountDaily()[friday] ?? 0,
      value.calculateAmountDaily()[saturady] ?? 0,
    ];
    values.sort();
    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  String calculateweektotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturady,
  ) {
    List<double> values = [
      value.calculateAmountDaily()[sunday] ?? 0,
      value.calculateAmountDaily()[monday] ?? 0,
      value.calculateAmountDaily()[tuesday] ?? 0,
      value.calculateAmountDaily()[wednesday] ?? 0,
      value.calculateAmountDaily()[thursday] ?? 0,
      value.calculateAmountDaily()[friday] ?? 0,
      value.calculateAmountDaily()[saturady] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toString();
  }

  @override
  Widget build(BuildContext context) {
    String Sunday =
        convertdatetimetostring(startofweek.add(const Duration(days: 0)));
    String Monday =
        convertdatetimetostring(startofweek.add(const Duration(days: 1)));
    String Tuesday =
        convertdatetimetostring(startofweek.add(const Duration(days: 2)));
    String Wednesday =
        convertdatetimetostring(startofweek.add(const Duration(days: 3)));
    String Thursday =
        convertdatetimetostring(startofweek.add(const Duration(days: 4)));
    String Friday =
        convertdatetimetostring(startofweek.add(const Duration(days: 5)));
    String Saturady =
        convertdatetimetostring(startofweek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
        builder: (context, value, child) => Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 25),
                    child: Text("Expense Tracker", style: TextStyle(color: textcolor, fontWeight: FontWeight.bold, fontSize: 28),)),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text(
                        'Week total: ',
                        style: TextStyle(
                            color: textcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        'PKR ${calculateweektotal(value, Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturady)}',
                        style: TextStyle(
                            color: textcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 200,
                    child: BarGraph(
                      maxY: calculatemaxbarh(value, Sunday, Monday, Tuesday,
                          Wednesday, Thursday, Friday, Saturady),
                      sunAmount: value.calculateAmountDaily()[Sunday] ?? 0,
                      monAmount: value.calculateAmountDaily()[Monday] ?? 0,
                      tueAmount: value.calculateAmountDaily()[Tuesday] ?? 0,
                      wedAmount: value.calculateAmountDaily()[Wednesday] ?? 0,
                      thuAmount: value.calculateAmountDaily()[Thursday] ?? 0,
                      friAmount: value.calculateAmountDaily()[Friday] ?? 0,
                      satAmount: value.calculateAmountDaily()[Saturady] ?? 0,



                    )),
              ],
            ));
  }
}
