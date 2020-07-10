class Transaction {
  Transaction({this.category, this.amount, this.content, this.date});

  final String category;
  final int amount;
  final String content;
  final DateTime date;

  Map toMap() => {
        'category': category,
        'amount': amount,
        'content': content,
        'date': date.toIso8601String(),
      };

  Transaction.fromMap(Map map)
      : category = map['category'],
        amount = map['amount'],
        content = map['content'],
        date = DateTime.parse(map['date']);
}
