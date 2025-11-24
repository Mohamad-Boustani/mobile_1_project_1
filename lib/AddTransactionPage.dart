import 'package:flutter/material.dart';
import 'package:mobile/Data.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            TextField(
              controller: contAm,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contN,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Note (optional)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
              ),
            ),
            const SizedBox(height: 12),
            // Currency selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedcurrency,
                  hint: const Text('Select Currency'),
                  items: currencies.map((c) =>
                      DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (c) => setState(() => selectedcurrency = c),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Type radio buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Income'),
                  selected: selectedtype == 'Income',
                  selectedColor: Colors.green[50],
                  onSelected: (sel) =>
                      setState(() => selectedtype = sel ? 'Income' : ''),
                ),
                const SizedBox(width: 12),
                ChoiceChip(
                  label: const Text('Expenses'),
                  selected: selectedtype == 'Expenses',
                  selectedColor: Colors.red[50],
                  onSelected: (sel) =>
                      setState(() => selectedtype = sel ? 'Expenses' : ''),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // simply pop back to previous screen
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                        Icons.arrow_back_rounded, color: Colors.indigo),
                    label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(
                            'Cancel', style: TextStyle(color: Colors.indigo))),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.indigo),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (contAm.text.isNotEmpty && selectedtype.isNotEmpty &&
                          selectedcurrency != null) {
                        final amt = double.tryParse(contAm.text);
                        if (amt != null) {
                          final tr = Transaction(amt, selectedcurrency!,
                              selectedtype, DateTime.now(), contN.text);
                          transactiondata.add(tr);
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Enter a valid number')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text(
                                'Please fill amount, currency and type')));
                      }
                    },
                    icon: const Icon(Icons.save_rounded),
                    label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Text('Save')),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (b) => TransactionList()));
              },
              icon: const Icon(Icons.list),
              label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  child: Text('View all transactions')),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ],
        ),
      ),
    );
  }
}
