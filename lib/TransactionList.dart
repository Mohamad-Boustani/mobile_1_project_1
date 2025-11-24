import 'package:flutter/material.dart';
import 'package:mobile/Data.dart';
import 'Transaction.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Details"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: transactiondata.isEmpty
            ? const Center(
            child: Text('No transactions yet', style: TextStyle(fontSize: 18)))
            : ListView.builder(
          itemCount: transactiondata.length,
          itemBuilder: (ctx, index) {
            final tr = transactiondata[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                leading: CircleAvatar(
                  backgroundColor: tr.type == 'Income'
                      ? Colors.green[50]
                      : Colors.red[50],
                  child: Text(tr.currency, style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                title: Text('${tr.type} - ${tr.amount} ${tr.currency}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (tr.note != null && tr.note!.isNotEmpty) Text(
                        'Note: ${tr.note}'),
                    Text('Date: ${tr.date
                        .toLocal()
                        .toString()
                        .split('.')
                        .first}'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(
                      Icons.delete_forever_rounded, color: Colors.red),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (dctx) =>
                          AlertDialog(
                            title: const Text('Confirm delete'),
                            content: const Text(
                                'Are you sure you want to delete this transaction?'),
                            actions: [
                              TextButton(onPressed: () =>
                                  Navigator.of(dctx).pop(false),
                                  child: const Text('Cancel')),
                              TextButton(
                                  onPressed: () => Navigator.of(dctx).pop(true),
                                  child: const Text('Delete')),
                            ],
                          ),
                    );
                    if (confirm == true) {
                      setState(() {
                        transactiondata.removeAt(index);
                      });
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
