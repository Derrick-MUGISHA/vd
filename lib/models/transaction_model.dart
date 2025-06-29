class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final DateTime date;
  final String type;
  final String icon;
  final bool isIncome;

  TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
    required this.icon,
    required this.isIncome,
  });
}