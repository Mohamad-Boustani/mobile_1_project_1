class Transaction {
  double amount;
  String type;
  String currency;
  String? note;
  DateTime date;

  Transaction({
    required this.amount,
    required this.type,
    required this.currency,
    this.note,
    required this.date,
  });
}
