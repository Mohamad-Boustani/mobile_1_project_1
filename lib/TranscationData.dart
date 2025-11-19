class Transaction {
  double amount;
  String type; // 'income' or 'expense'
  String currency; // 'USD', 'LBP', 'EUR'
  String? note;
  DateTime date;

  Transaction(this.amount, this.type, this.currency, this.note, this.date);
}
