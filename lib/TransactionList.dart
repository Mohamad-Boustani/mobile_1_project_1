import 'package:flutter/material.dart';
import 'Transaction.dart';

class TransactionList extends StatefulWidget {
  TransactionList({Key? key}) : super(key: key);

  @override
  _TransactionListState createState() {
    return _TransactionListState();
  }
}

class _TransactionListState extends State<TransactionList> {
  late List<dynamic> _filteredTransactions;
  String _searchQuery = '';
  String _dateQuery = '';
  String _filterType = 'All';
  String _filterCurrency = 'All';

  @override
  void initState() {
    super.initState();
    _filteredTransactions = Transaction.transactiondata;
  }

  void _updateSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _applyFilters();
    });
  }

  void _updateDateSearch(String query) {
    setState(() {
      _dateQuery = query.toLowerCase();
      _applyFilters();
    });
  }

  void _applyFilters() {
    _filteredTransactions = Transaction.transactiondata.where((tr) {
      // Search by note
      final dateText = tr.date
          .toLocal()
          .toString()
          .split('.')
          .first
          .toLowerCase();
      bool matchesNoteSearch = _searchQuery.isEmpty ||
          (tr.note != null && tr.note!.toLowerCase().contains(_searchQuery));

      // Search by date
      bool matchesDateSearch = _dateQuery.isEmpty ||
          dateText.contains(_dateQuery);

      // Filter by type
      bool matchesType = _filterType == 'All' || tr.type == _filterType;

      // Filter by currency
      bool matchesCurrency =
          _filterCurrency == 'All' || tr.currency == _filterCurrency;

      return matchesNoteSearch && matchesDateSearch && matchesType &&
          matchesCurrency;
    }).toList();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Filter Transactions'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Type:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: _filterType,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: 'All', child: Text('All Types')),
                  DropdownMenuItem(value: 'Income', child: Text('Income')),
                  DropdownMenuItem(value: 'Expenses', child: Text('Expenses')),
                ]
                    .map((item) =>
                    DropdownMenuItem(
                      value: item.value,
                      child: item.child,
                    ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _filterType = value ?? 'All');
                  Navigator.of(ctx).pop();
                  _applyFilters();
                },
              ),
              const SizedBox(height: 16),
              const Text('Currency:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: _filterCurrency,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: 'All', child: Text('All Currencies')),
                  DropdownMenuItem(value: 'USD', child: Text('USD')),
                  DropdownMenuItem(value: 'LBP', child: Text('LBP')),
                ]
                    .map((item) =>
                    DropdownMenuItem(
                      value: item.value,
                      child: item.child,
                    ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _filterCurrency = value ?? 'All');
                  Navigator.of(ctx).pop();
                  _applyFilters();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Details"),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _showFilterDialog,
            tooltip: 'Filter',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by note...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _updateSearch('');
                  },
                )
                    : null,
              ),
              onChanged: _updateSearch,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by date (e.g., 2026-01-03)',
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: _dateQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _updateDateSearch('');
                  },
                )
                    : null,
              ),
              onChanged: _updateDateSearch,
            ),
          ),
          // Active Filters Display
          if (_filterType != 'All' || _filterCurrency != 'All')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  if (_filterType != 'All')
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Chip(
                        label: Text(_filterType),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () {
                          setState(() => _filterType = 'All');
                          _applyFilters();
                        },
                        backgroundColor: Theme
                            .of(context)
                            .colorScheme
                            .secondaryContainer,
                      ),
                    ),
                  if (_filterCurrency != 'All')
                    Chip(
                      label: Text(_filterCurrency),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () {
                        setState(() => _filterCurrency = 'All');
                        _applyFilters();
                      },
                      backgroundColor: Theme
                          .of(context)
                          .colorScheme
                          .secondaryContainer,
                    ),
                ],
              ),
            ),
          // Transactions List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: _filteredTransactions.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      _searchQuery.isNotEmpty || _filterType != 'All' ||
                          _filterCurrency != 'All'
                          ? 'No transactions found'
                          : 'No transactions yet',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: _filteredTransactions.length,
                itemBuilder: (ctx, index) {
                  final tr = _filteredTransactions[index];
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
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                        child: Text(tr.currency,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: tr.type == 'Income'
                                    ? Colors.green
                                    : Colors.red)),
                      ),
                      title: Text(
                          '${tr.type} - ${tr.amount} ${tr.currency}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (tr.note != null && tr.note!.isNotEmpty)
                            Text('Note: ${tr.note}'),
                          Text('Date: ${tr.date
                              .toLocal()
                              .toString()
                              .split('.')
                              .first}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_forever_rounded,
                            color: Colors.red),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (dctx) =>
                                AlertDialog(
                                  title: const Text('Confirm delete'),
                                  content: const Text(
                                      'Are you sure you want to delete this transaction?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(dctx).pop(false),
                                        child: const Text('Cancel')),
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(dctx).pop(true),
                                        child: const Text('Delete')),
                                  ],
                                ),
                          );
                          if (confirm == true) {
                            try {
                              if (tr.id != null) {
                                final ok = await Transaction
                                    .deleteTransactionApi(tr.id!);
                                if (!ok) {
                                  throw Exception('Delete failed');
                                }
                              }
                              setState(() {
                                Transaction.transactiondata.remove(tr);
                                _applyFilters();
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $e')),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
