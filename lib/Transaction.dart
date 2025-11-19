class Transaction {
  double amount;
  String type;
  String currency;
  String? note;
  DateTime date;

  Transaction(this.amount, this.type, this.currency, this.note, this.date);

  @override
  String toString() {
    return "Amount: $amount $currency - Type: $type - Date: $date - Note: $note";
  }
}
