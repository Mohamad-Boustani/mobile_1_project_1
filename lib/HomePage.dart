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
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Title(
              color: Colors.indigo,
              child: const Text(
                "USD Balance",
                style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Today’s Income \$: ${Transaction
                  .totalIncome('USD')
                  .toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Today’s Expenses \$: ${Transaction
                  .totalExpenses('USD')
                  .toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Balance \$: ${Transaction.balance('USD').toStringAsFixed(2)}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 30),
            Title(
              color: Colors.indigo,
              child: const Text(
                "LBP Balance",
                style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Today’s Income LBP: ${Transaction
                  .totalIncome('LBP')
                  .toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Today’s Expenses LBP: ${Transaction
                  .totalExpenses('LBP')
                  .toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Balance LBP: ${Transaction.balance('LBP').toStringAsFixed(2)}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (b) {
                            return AddTransaction();
                          },
                        )
                    );
                  },
                  icon: Icon(Icons.add_circle_outline),
                  label: Text("Add Transaction"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                ),
                SizedBox(width: 50),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) {
                            return TransactionList();
                          },
                        )
                    );
                  },
                  icon: Icon(Icons.account_balance_wallet_rounded),
                  label: Text("View Transactions"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
