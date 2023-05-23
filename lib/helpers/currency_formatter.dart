import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String convertToIdr(dynamic number, int decimalDigits) {
    NumberFormat formatCurrency = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: decimalDigits
    );

    return formatCurrency.format(number);
  }
}