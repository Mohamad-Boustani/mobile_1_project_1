import 'package:http/http.dart' as http;
import 'dart:convert';

const String _baseURL = 'http://bestenicsci410.atwebpages.com';

class Transaction {
  static List<Transaction> transactiondata = [];
  int? id;
  double amount;
  String type;
  String currency;
  String? note;
  DateTime date;

  Transaction(this.amount, this.currency, this.type, this.date, this.note,
      {this.id});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      double.tryParse(json['Amount']?.toString() ?? '0') ?? 0,
      json['Currency'] ?? '',
      json['Type'] ?? '',
      DateTime.parse(json['Transaction_date']),
      json['Note'],
      id: json['ID'],
    );
  }

  Map<String, dynamic> toJson(int userId) {
    return {
      'user_id': userId,
      'amount': amount,
      'currency': currency,
      'type': type,
      'note': note ?? '',
      'transaction_date': date.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "Amount: $amount $currency - Type: $type - Date: $date \n Note: $note";
  }

  static double totalIncome(String currency) {
    double sum = 0.0;
    for (var t in Transaction.transactiondata) {
      if (t.currency == currency && t.type == "Income") {
        sum += t.amount;
      }
    }
    return sum;
  }

  static double totalExpenses(String currency) {
    double sum = 0.0;
    for (var t in Transaction.transactiondata) {
      if (t.currency == currency && t.type == "Expenses") {
        sum += t.amount;
      }
    }
    return sum;
  }

  static double balance(String currency) {
    return totalIncome(currency) - totalExpenses(currency);
  }

  // API helpers
  static Future<List<Transaction>> fetchTransactions(int userId) async {
    final url = Uri.parse("$_baseURL/get_transactions.php?user_id=$userId");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => Transaction.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  static Future<bool> addTransactionApi(Transaction tr, int userId) async {
    final url = Uri.parse("$_baseURL/add_transaction.php");
    final res = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tr.toJson(userId)));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return data['success'] == true;
    }
    throw Exception('Failed to add transaction');
  }

  static Future<bool> deleteTransactionApi(int id) async {
    final url = Uri.parse("$_baseURL/delete_transaction.php?id=$id");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return data['success'] == true;
    }
    throw Exception('Failed to delete transaction');
  }
}
