import 'package:intl/intl.dart';

class DateTimeFormatterUtil {
  /// Returns the current date formatted as 'dd/MM/yyyy'
  String getCurrentFormattedDate({String? localeCode}) {
    final now = DateTime.now();
    return DateFormat('dd/MM/yyyy', localeCode).format(now);
  }

  /// Returns the current day name (e.g. 'Saturday')
  String getCurrentDayName({String? localeCode}) {
    final now = DateTime.now();
    return DateFormat('EEEE', localeCode).format(now);
  }
}
