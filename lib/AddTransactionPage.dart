import 'package:flutter/material.dart';
import 'package:mobile/Data.dart';
import 'package:mobile/HomePage.dart';
import 'package:mobile/TransactionList.dart';

import 'Transaction.dart';

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
  late String selectedcurrency;
  late String selectedtype;

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
        backgroundColor: Colors.indigo,
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
          const SizedBox(height: 10),
          DropdownMenu(
            width: 200,
            hintText: "Select Currency",
            dropdownMenuEntries: currencies.map<DropdownMenuEntry<String>>((
              String currency,
            ) {
              return DropdownMenuEntry(value: currency, label: currency);
            }).toList(),
            onSelected: (c) {
              setState(() {
                selectedcurrency = c!;
              });
            },
          ),
          const SizedBox(height: 10),
          DropdownMenu(
            width: 200,
            hintText: "Select Type",
            dropdownMenuEntries: type.map<DropdownMenuEntry<String>>((
              String type,
            ) {
              return DropdownMenuEntry(value: type, label: type);
            }).toList(),
            onSelected: (t) {
              setState(() {
                selectedtype = t!;
              });
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  contN.text = "";
                  contAm.text = "";
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (b) {
                        return HomePage();
                      },
                    ),
                  );
                },
                icon: Icon(Icons.arrow_back_rounded),
                label: const Text("Go To Home"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (contAm.text.isNotEmpty &&
                      contN.text.isNotEmpty &&
                      selectedtype.isNotEmpty &&
                      selectedcurrency.isNotEmpty) {
                    Transaction tr = Transaction(
                      double.parse(contAm.text),
                      selectedtype,
                      selectedcurrency,
                      contN.text,
                      DateTime.now(),
                    );
                    transactiondata.add(tr);
                    contN.text = "";
                    contAm.text = "";
                  }
                },
                icon: Icon(Icons.save_rounded),
                label: const Text("Save transaction"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  contN.text = "";
                  contAm.text = "";

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (b) {
                        return TransactionList();
                      },
                    ),
                  );
                },
                icon: Icon(Icons.arrow_forward_rounded),
                label: const Text("View all transactions"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
