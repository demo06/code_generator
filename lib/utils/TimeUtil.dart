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
}
