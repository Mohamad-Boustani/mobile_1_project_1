import 'package:flutter/material.dart';
import 'package:mobile/Data.dart';
// import 'package:mobile/Transaction.dart';

class TransactionList extends StatefulWidget {
  TransactionList({Key? key}) : super(key: key);

  @override
  _TransactionListState createState() {
    return _TransactionListState();
  }
}

class _TransactionListState extends State<TransactionList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var s = ModalRoute.of(context)?.settings.arguments as Transaction;
    return Scaffold(
      appBar: AppBar(title: const Text("Details of Every Transaction")),
      body: ListView.builder(
          itemCount: transactiondata.length,
          itemBuilder: (b, index) {
            return Text(transactiondata[index].toString());
          }),
    );
  }
}
