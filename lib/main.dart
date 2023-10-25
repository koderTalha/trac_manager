import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:trac_manager/Custom/color.dart';
import 'package:trac_manager/Data/Expensedata.dart';

import 'Screen/HomePage.dart';

void main()async{

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: bgcolor, statusBarIconBrightness: Brightness.dark));
  await Hive.initFlutter();
  await Hive.openBox("Expense_Database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>ExpenseData(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Track',
        home: Homepage(),
      ),

    );
  }
}
