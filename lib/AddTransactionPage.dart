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
  String? selectedcurrency;
  String selectedtype = "";

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
            initialSelection: selectedcurrency,
            // This line is crucial
            hintText: "Select Currency",
            dropdownMenuEntries: currencies.map<DropdownMenuEntry<String>>((
              String currency,
            ) {
              return DropdownMenuEntry(value: currency, label: currency);
            }).toList(),
            onSelected: (c) {
              setState(() {
                selectedcurrency = c;
              });
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<String>(
                value: "Income",
                groupValue: selectedtype,
                onChanged: (String? value) {
                  setState(() {
                    selectedtype = value!;
                  });
                },
              ),
              const Text('Income'),
              Radio<String>(
                value: "Expenses",
                groupValue: selectedtype,
                onChanged: (String? value) {
                  setState(() {
                    selectedtype = value!;
                  });
                },
              ),
              const Text('Expenses'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    contN.text = "";
                    contAm.text = "";
                    selectedtype = "";
                    selectedcurrency = null;
                  });
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
                      selectedcurrency != null) {
                    Transaction tr = Transaction(
                      double.parse(contAm.text),
                      selectedcurrency!,
                      selectedtype,
                      DateTime.now(),
                      contN.text,
                    );
                    transactiondata.add(tr);
                    setState(() {
                      contN.text = "";
                      contAm.text = "";
                      selectedtype = "";
                      selectedcurrency = null;
                    });
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
                  setState(() {
                    contN.text = "";
                    contAm.text = "";
                    selectedtype = "";
                    selectedcurrency = null;
                  });
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
