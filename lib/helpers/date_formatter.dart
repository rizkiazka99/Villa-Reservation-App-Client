import 'package:intl/intl.dart';

class DateFormatter {
  static String monthNameExcluded(DateTime date, String locale) {
    String newDate = DateFormat('dd-MM-yyyy', locale).format(date);
    return newDate;
  }

  static String monthNameIncluded(DateTime date, String locale) {
    String newDate = DateFormat('dd MMMM yyyy', locale).format(date);
    return newDate;
  }

  static String monthNameExcludedAndDaysIncluded (DateTime date, String locale) {
    String newDate = DateFormat('EEEE, dd-MM-yyyy', locale).format(date);
    return newDate;
  }

  static String monthNameAndDaysIncluded(DateTime date, String locale) {
    String newDate = DateFormat('EEEE, dd MMMM yyyy', locale).format(date);
    return newDate;
  }
}