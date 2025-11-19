import 'package:flutter/material.dart';
import 'package:mobile/AddTransactionPage.dart';
import 'HomePage.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Daily Transaction Summary",
      debugShowCheckedModeBanner: false,
      home: AddTransaction(),
    );
  }
}
