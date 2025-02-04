class Wallet {
  Wallet({
    required this.currency,
    required this.symbol,
    required this.flag,
    required this.map,
    required this.balance,
  });

  final String currency;
  final String symbol;
  final String flag;
  final String map;
  final double balance;

  Wallet copyWith({
    String? currency,
    String? symbol,
    String? flag,
    String? map,
    double? balance,
  }) {
    return Wallet(
      currency: currency ?? this.currency,
      symbol: symbol ?? this.symbol,
      flag: flag ?? this.flag,
      map: map ?? this.map,
      balance: balance ?? this.balance,
    );
  }
}
