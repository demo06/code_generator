import 'package:intl/intl.dart';

class TimeUtil {
  DateTime dateTime = DateTime.now();

  int getCurrentYear() {
    return dateTime.year;
  }

  int getCurrentMonth() {
    return dateTime.month;
  }

  int getCurrentDay() {
    return dateTime.day;
  }

  int getTodayStartTime() {
    return DateTime(getCurrentYear(), getCurrentMonth(), getCurrentDay()).millisecondsSinceEpoch ~/ 1000;
  }

  String getTodayDate() {
    return DateFormat('yyyy年MM月dd日').format(DateTime.now());
  }
}
