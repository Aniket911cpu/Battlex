class TransactionModel {
  final String id;
  final String title;
  final String date;
  final double amount;
  final String type; // 'credit' or 'debit'
  final String status; // 'SUCCESS', 'PENDING'

  TransactionModel({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      amount: (json['amount'] as num).toDouble(),
      type: json['type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'amount': amount,
      'type': type,
      'status': status,
    };
  }
}
