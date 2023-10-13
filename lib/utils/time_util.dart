import 'package:intl/intl.dart';

class TimeUtil {
  static int getCurrentYear() {
    return DateTime.now().year;
  }

  static int getCurrentMonth() {
    return DateTime.now().month;
  }

  static int getCurrentDay() {
    return DateTime.now().day;
  }

  static int getTodayStartTime() {
    return DateTime(getCurrentYear(), getCurrentMonth(), getCurrentDay()).millisecondsSinceEpoch ~/ 1000;
  }

  static String getTodayDate({String? format = "yyyy年MM月dd日"}) {
    return DateFormat(format).format(DateTime.now());
  }

  static String transMillToDate({required int millisconds, String? format = "yyyy年MM月dd日"}) {
    return DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(millisconds));
  }
}
