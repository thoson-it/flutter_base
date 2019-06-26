import 'package:intl/intl.dart';

class Utils {
  static const kBirthdayDateFormat = 'yyyy年-MM月-dd日';
  static const kPointHistoryDateFormat = 'yyyy年MM月dd日 HH:mm';
  static const kDateFormat = 'yyyy-MM-dd HH:mm:ss';

  static String currencyToString(int price) {
    if (price == null) {
      return "0";
    }
    var format =
        new NumberFormat.currency(locale: "ja_JP", customPattern: "#,###");
    return format.format(price);
  }

  static String dateToString(DateTime date, {String formatStr = kDateFormat}) {
    if (date == null) {
      return "";
    }
    var result = new DateFormat("dd-MM-yyyy").format(date);
    return result;
  }

  static DateTime stringToDate(String dateStr) {
    if (dateStr == null) {
      return null;
    }
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String dateToBirthdayString(DateTime date) {
    if (date == null) {
      return "";
    }
    return dateToString(date, formatStr: kBirthdayDateFormat);
  }

  static String dateToPointHistoryString(DateTime date) {
    if (date == null) {
      return "";
    }
    return dateToString(date, formatStr: kPointHistoryDateFormat);
  }

  static int priceToInt(String price) {
    if (price == null) {
      return 0;
    }
    int format = int.parse(price.substring(1, 2));
    return format;
  }

  static String dateToJapanTimeZoneString(DateTime date,
      {String formatStr = kDateFormat}) {
    if (date == null) {
      return "";
    }
    var result =
        new DateFormat(formatStr).format(date.toUtc().add(Duration(hours: 9)));
    return result;
  }
}
