class CardModel {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cvv;
  final String cardType;
  final double balance;
  final bool isActive;

  CardModel({
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cvv,
    required this.cardType,
    required this.balance,
    this.isActive = false,
  });
}