import 'package:flutter/material.dart';
import 'package:mobile/TransactionList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Transaction.dart';

const List<String> currencies = ["USD", "LBP"];

class AddTransaction extends StatefulWidget {
  final int? userId;

  AddTransaction({Key? key, required this.userId}) : super(key: key);

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
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  // TODO: Replace this with actual API call to add_transaction.php
  Future<bool> _addTransactionToApi(Transaction transaction) async {
    try {
      const String baseURL = 'http://bestenicsci410.atwebpages.com';
      final response = await http.post(
        Uri.parse('$baseURL/add_transaction.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_id': widget.userId,
          'amount': transaction.amount,
          'currency': transaction.currency,
          'type': transaction.type,
          'note': transaction.note ?? '',
          'transaction_date': transaction.date.toIso8601String(),
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Connection timeout'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData['success'] == true;
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding transaction: $e');
    }
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
                  selectedColor: Colors.green.withOpacity(0.2),
                  onSelected: (sel) =>
                      setState(() => selectedtype = sel ? 'Income' : ''),
                ),
                const SizedBox(width: 12),
                ChoiceChip(
                  label: const Text('Expenses'),
                  selected: selectedtype == 'Expenses',
                  selectedColor: Colors.red.withOpacity(0.2),
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
                    onPressed: _isSaving ? null : () async {
                      if (contAm.text.isNotEmpty && selectedtype.isNotEmpty &&
                          selectedcurrency != null) {
                        if (widget.userId == null) {
                          _showError('Please login first');
                          return;
                        }
                        final amt = double.tryParse(contAm.text);
                        if (amt == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Enter a valid number')));
                          return;
                        }
                        if (amt <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Amount must be greater than 0')));
                          return;
                        }
                          setState(() => _isSaving = true);
                          try {
                            final tr = Transaction(amt, selectedcurrency!,
                                selectedtype, DateTime.now(),
                                contN.text.isEmpty ? null : contN.text);

                            // Call API add_transaction.php
                            final success = await _addTransactionToApi(tr);
                            if (success) {
                              Transaction.transactiondata.add(tr);
                              Navigator.of(context).pop();
                            } else {
                              _showError('Failed to save transaction');
                            }
                          } catch (e) {
                            _showError('Error: $e');
                          } finally {
                            if (mounted) {
                              setState(() => _isSaving = false);
                            }
                          }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text(
                                'Please fill amount, currency and type')));
                      }
                    },
                    icon: _isSaving
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                        : const Icon(Icons.save_rounded),
                    label: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(_isSaving ? 'Saving...' : 'Save')),
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
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ],
        ),
      ),
    );
  }
}
