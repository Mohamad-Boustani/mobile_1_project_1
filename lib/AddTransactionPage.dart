import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  AddTransaction({Key? key}) : super(key: key);

  @override
  _AddTransactionState createState() {
    return _AddTransactionState();
  }
}

class _AddTransactionState extends State<AddTransaction> {
  TextEditingController contAm = TextEditingController();
  TextEditingController contN = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new transaction"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            controller: contAm,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text("Enter The Amount"),
              border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
            ),
          ),
          const SizedBox(height: 10),

          TextField(
            controller: contN,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text("Enter A Note"),
              border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
            ),
          ),
        ],
      ),
    );
  }
}
