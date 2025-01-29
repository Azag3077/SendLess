import '../../core/constants/enums.dart';

class Transaction {
  Transaction({
    required this.name,
    required this.currency,
    this.image,
    required this.datetime,
    required this.amount,
    required this.type,
  });

  final String name;
  final String currency;
  final String? image;
  final DateTime datetime;
  final double amount;
  final TxnStatus type;
}
