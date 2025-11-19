class Transaction {
  final double amount;
  final String type; // 'income' or 'expense'
  final String currency; // 'USD', 'LBP', 'EUR'
  final String? note;
  final DateTime date;

  Transaction(this.amount, this.type, this.currency, this.note, this.date);
}
