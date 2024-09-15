class BudgetRecord {
  final int? id;
  final String category;
  final double amount;
  final String date;
  final String time;
  final String type;
  final String? memo;
  final String? description;

  BudgetRecord({
    this.id,
    required this.category,
    required this.amount,
    required this.date,
    required this.time,
    required this.type,
    this.memo,
    this.description,
  });

  // Convert a BudgetRecord into a Map. The keys must correspond to the column names in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'date': date,
      'time': time,
      'type': type,
      'memo': memo,
      'description': description,
    };
  }

  // Extract a BudgetRecord object from a Map.
  factory BudgetRecord.fromMap(Map<String, dynamic> map) {
    return BudgetRecord(
      id: map['id'],
      category: map['category'],
      amount: map['amount'],
      date: map['date'],
      time: map['time'],
      type: map['type'],
      memo: map['memo'],
      description: map['description'],
    );
  }
}
