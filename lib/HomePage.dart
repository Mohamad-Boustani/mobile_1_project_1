import 'package:flutter/material.dart';
import 'package:mobile/AddTransactionPage.dart';
import 'TransactionList.dart';
import 'Transaction.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
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
        title: const Text("Daily Summary"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Balances',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),

            // USD Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('USD', style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                        Icon(Icons.attach_money, color: Colors.indigo)
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.arrow_downward, color: Colors.green),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('Income')),
                        Text('\$${Transaction
                            .totalIncome('USD')
                            .toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.green,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.arrow_upward, color: Colors.red),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('Expenses')),
                        Text('\$${Transaction
                            .totalExpenses('USD')
                            .toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      children: [
                        const Expanded(child: Text('Balance', style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
                        Text('\$${Transaction.balance('USD').toStringAsFixed(
                            2)}', style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // LBP Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('LBP', style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                        Icon(Icons.money, color: Colors.indigo)
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.arrow_downward, color: Colors.green),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('Income')),
                        Text('${Transaction.totalIncome('LBP').toStringAsFixed(
                            2)} LBP', style: const TextStyle(color: Colors
                            .green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.arrow_upward, color: Colors.red),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('Expenses')),
                        Text('${Transaction
                            .totalExpenses('LBP')
                            .toStringAsFixed(2)} LBP',
                            style: const TextStyle(color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      children: [
                        const Expanded(child: Text('Balance', style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
                        Text('${Transaction.balance('LBP').toStringAsFixed(
                            2)} LBP', style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (b) => AddTransaction()),
                      ).then((_) => setState(() {}));
                    },
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Text('Add Transaction'),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (c) => TransactionList()));
                    },
                    icon: const Icon(Icons.account_balance_wallet_rounded,
                        color: Colors.indigo),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Text('View Transactions',
                          style: TextStyle(color: Colors.indigo)),
                    ),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.indigo),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
