extension DoubleUtils on double {
  String get toPriceInString {
    final parts = toStringAsFixed(2).split('.');
    String integerPart = parts[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},');
    String result = integerPart;

    if (parts.length > 1) {
      result += '.${parts[1]}';
    }

    return result;
  }

  String get integerPart {
    final parts = toStringAsFixed(2).split('.');
    final regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return parts.first.replaceAllMapped(regex, (m) => '${m[1]},');
  }

  String get decimalPart => toStringAsFixed(2).split('.').last;
}
