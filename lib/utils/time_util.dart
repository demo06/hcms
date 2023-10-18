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

  static String getTodayDate({String? format = "yyyy-MM-dd"}) {
    return DateFormat(format).format(DateTime.now());
  }

  static String transMillToDate({required int millisconds, String? format = "yyyy-MM-dd"}) {
    return DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(millisconds));
  }

  static int transDateToMill({required String date, String? format = "yyyy-MM-dd"}) {
    return DateTime.parse(date).millisecondsSinceEpoch;
  }

  static int transDateToString({required String date, String? format = "yyyy-MM-dd"}) {
    return DateTime.parse(date).millisecondsSinceEpoch;
  }
  static int getTodayStartTime() {
    DateTime now = DateTime.now(); // 获取当前日期时间
    DateTime dayStart = DateTime(now.year, now.month, now.day, 0); // 获取本月第一天的日期时间
    return dayStart.millisecondsSinceEpoch;
  }

  static int getTodayEndTime() {
    DateTime now = DateTime.now(); // 获取当前日期时间
    DateTime dayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59); // 获取本月第一天的日期时间
    return dayEnd.millisecondsSinceEpoch;
  }

  static int getMonthEnd() {
    DateTime now = DateTime.now(); // 获取当前日期时间
    DateTime monthEnd = DateTime(now.year, now.month + 1, 0, 23, 59, 59); // 获取本月最后一天的日期时间（时间为23:59:59）
    return monthEnd.millisecondsSinceEpoch;
  }

  static int getMonthStart() {
    DateTime now = DateTime.now(); // 获取当前日期时间
    DateTime monthStart = DateTime(now.year, now.month, 1); // 获取本月第一天的日期时间
    return monthStart.millisecondsSinceEpoch;
  }
}
