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
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                transactiondata[index].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    transactiondata.removeAt(index);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Icon(Icons.delete_forever_rounded),
              ),
            ],
          );
        },
      ),
    );
  }
}
