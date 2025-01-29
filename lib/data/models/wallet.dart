class Wallet {
  Wallet({
    required this.currency,
    required this.symbol,
    required this.flag,
    required this.balance,
  });

  final String currency;
  final String symbol;
  final String flag;
  final double balance;

  Wallet copyWith({
    String? currency,
    String? symbol,
    String? flag,
    double? balance,
  }) {
    return Wallet(
      currency: currency ?? this.currency,
      symbol: symbol ?? this.symbol,
      flag: flag ?? this.flag,
      balance: balance ?? this.balance,
    );
  }
}
