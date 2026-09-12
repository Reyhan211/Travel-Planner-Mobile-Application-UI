/// Data & aturan format untuk halaman Currency Converter.
///
/// [ratePerUsd] = berapa unit mata uang itu setara 1 USD (kurs tengah,
/// per 11 September 2026, dari data pasar valas). Ini tetap dummy/statis
/// (bukan live API), tapi angkanya disesuaikan supaya realistis untuk
/// tahun ini — bukan asal karang.
class CurrencyInfo {
  final String code;
  final String name;
  final String symbol;
  final double ratePerUsd;
  final int decimalDigits;
  final String thousandsSeparator;
  final String decimalSeparator;

  const CurrencyInfo({
    required this.code,
    required this.name,
    required this.symbol,
    required this.ratePerUsd,
    this.decimalDigits = 2,
    this.thousandsSeparator = ',',
    this.decimalSeparator = '.',
  });
}

const List<CurrencyInfo> currencies = [
  CurrencyInfo(
    code: 'IDR',
    name: 'Indonesian Rupiah',
    symbol: 'Rp',
    ratePerUsd: 17550,
    decimalDigits: 0,
    thousandsSeparator: '.',
  ),
  CurrencyInfo(code: 'USD', name: 'US Dollar', symbol: '\$', ratePerUsd: 1),
  CurrencyInfo(code: 'EUR', name: 'Euro', symbol: '€', ratePerUsd: 0.86),
  CurrencyInfo(code: 'JPY', name: 'Japanese Yen', symbol: '¥', ratePerUsd: 154, decimalDigits: 0),
  CurrencyInfo(code: 'GBP', name: 'British Pound', symbol: '£', ratePerUsd: 0.74),
  CurrencyInfo(code: 'SGD', name: 'Singapore Dollar', symbol: 'S\$', ratePerUsd: 1.27),
  CurrencyInfo(code: 'MYR', name: 'Malaysian Ringgit', symbol: 'RM', ratePerUsd: 4.06),
  CurrencyInfo(code: 'AUD', name: 'Australian Dollar', symbol: 'A\$', ratePerUsd: 1.39),
  CurrencyInfo(code: 'CAD', name: 'Canadian Dollar', symbol: 'C\$', ratePerUsd: 1.40),
  CurrencyInfo(code: 'KRW', name: 'South Korean Won', symbol: '₩', ratePerUsd: 1492, decimalDigits: 0),
  CurrencyInfo(code: 'THB', name: 'Thai Baht', symbol: '฿', ratePerUsd: 33.05),
];

CurrencyInfo currencyByCode(String code) =>
    currencies.firstWhere((c) => c.code == code);

/// Konversi [amount] dari mata uang [fromCode] ke [toCode], lewat USD
/// sebagai basis (amount / rate asal * rate tujuan).
double convertCurrency(double amount, String fromCode, String toCode) {
  final from = currencyByCode(fromCode);
  final to = currencyByCode(toCode);
  return (amount / from.ratePerUsd) * to.ratePerUsd;
}

/// Format angka jadi tampilan mata uang, contoh: formatCurrency(10000, 'IDR')
/// menghasilkan "Rp10.000", formatCurrency(71.45, 'USD') -> "\$71.45".
String formatCurrency(double value, String code) {
  final info = currencyByCode(code);
  return '${info.symbol}${formatNumber(value, info)}';
}

/// Format angka murni (tanpa simbol mata uang) mengikuti aturan pemisah
/// ribuan/desimal mata uang tsb. Dipakai untuk tampilan input yang masih
/// diketik user (belum perlu simbol).
String formatNumber(double value, CurrencyInfo info) {
  final isNegative = value < 0;
  final fixed = value.abs().toStringAsFixed(info.decimalDigits);
  final parts = fixed.split('.');
  final intPart = parts[0];
  final decPart = parts.length > 1 ? parts[1] : '';

  final buffer = StringBuffer();
  for (int i = 0; i < intPart.length; i++) {
    if (i > 0 && (intPart.length - i) % 3 == 0) {
      buffer.write(info.thousandsSeparator);
    }
    buffer.write(intPart[i]);
  }

  final result = buffer.toString();
  final withDecimal = decPart.isEmpty ? result : '$result${info.decimalSeparator}$decPart';
  return isNegative ? '-$withDecimal' : withDecimal;
}

/// Sama seperti [formatNumber], tapi untuk string mentah yang lagi diketik
/// (boleh berakhir dengan titik desimal kosong, misal user baru ketik "100.").
/// Tidak memaksa jumlah digit desimal seperti formatNumber.
String groupRawInput(String raw, CurrencyInfo info) {
  final isNegative = raw.startsWith('-');
  final unsigned = isNegative ? raw.substring(1) : raw;
  final dotIndex = unsigned.indexOf('.');
  final intPart = dotIndex == -1 ? unsigned : unsigned.substring(0, dotIndex);
  final decPart = dotIndex == -1 ? '' : unsigned.substring(dotIndex);

  final buffer = StringBuffer();
  for (int i = 0; i < intPart.length; i++) {
    if (i > 0 && (intPart.length - i) % 3 == 0) {
      buffer.write(info.thousandsSeparator);
    }
    buffer.write(intPart[i]);
  }
  final sep = decPart.isEmpty ? '' : info.decimalSeparator + decPart.substring(1);
  return '${isNegative ? '-' : ''}${buffer.toString()}$sep';
}
