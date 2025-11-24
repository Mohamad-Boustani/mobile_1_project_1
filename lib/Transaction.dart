import 'Data.dart';

class Transaction {
  double amount;
  String type;
  String currency;
  String? note;
  DateTime date;

  Transaction(this.amount, this.currency, this.type, this.date, this.note);

  @override
  String toString() {
    return "Amount: $amount $currency - Type: $type - Date: $date \n Note: $note";
  }

  static double totalIncome(String currency) {
    double sum = 0.0;
    for (var t in transactiondata) {
      if (t.currency == currency && t.type == "Income") {
        sum += t.amount;
      }
    }
    return sum;
  }

  static double totalExpenses(String currency) {
    double sum = 0.0;
    for (var t in transactiondata) {
      if (t.currency == currency && t.type == "Expenses") {
        sum += t.amount;
      }
    }
    return sum;
  }

  static double balance(String currency) {
    return totalIncome(currency) - totalExpenses(currency);
  }
}
