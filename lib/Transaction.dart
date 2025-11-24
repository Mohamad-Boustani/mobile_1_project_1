class Transaction {
  double amount;
  String type;
  String currency;
  String? note;
  DateTime date;

  Transaction(this.amount, this.currency, this.type, this.date, this.note);

  @override
  String toString() {
    return "Amount: $amount $currency - Type: $type - Date: $date - Note: $note";
  }
}
