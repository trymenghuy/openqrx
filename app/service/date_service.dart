import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openqrx/app/provider/setting_provider.dart';
import 'package:openqrx/app/util/navigator.dart';

class DateService {
  static DateService? _instance;
  DateService._();
  static DateService get instance {
    _instance ??= DateService._();
    return _instance!;
  }

  String dayId(DateTime? date) {
    return DateFormat('dd-MM-yyyy').format(date ?? DateTime.now());
  }

  DateTime _date(int milliSecond) =>
      DateTime.fromMillisecondsSinceEpoch(milliSecond);
  String ymd(int milliSecond) =>
      DateFormat('yyyy-MM-dd').format(_date(milliSecond));
  String nameMd(DateTime? now) {
    if (now == null) return '';
    return DateFormat.MMMEd().format(now);
  }

  String hour(int milliSecond) =>
      DateFormat('HH:mm').format(_date(milliSecond));
  String nameYmd(DateTime? now) {
    if (now == null) return '';
    return DateFormat.yMMMEd().format(now);
  }

  String nameYm(DateTime? now) {
    if (now == null) return '';
    return DateFormat.yMMMM().format(now);
  }

  String day(DateTime? now) {
    if (now == null) return '';
    return DateFormat.E().format(now);
  }

  String fullText(DateTime? date) {
    if (date == null) return '';
    return DateFormat.yMMMd().add_Hm().format(date);
  }

  Future<DateTime?> pickDate({
    DateTime? now,
    DateTime? lastDate,
    DateTime? firstDate,
  }) async {
    now ??= DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: XNavigator.context,
      locale: Locale(SettingProvider.instance.ln.value),
      initialDate: now,
      currentDate: DateTime.now(),
      firstDate: firstDate ?? now.subtract(const Duration(days: 50)),
      lastDate: lastDate ?? DateTime.now(),
    );
    return picked;
  }

  Future<DateTimeRange?> pickRangeDate({
    DateTime? now,
    DateTime? lastDate,
    DateTime? firstDate,
    DateTimeRange? initialDateRange,
  }) async {
    now ??= DateTime.now();
    final picked = await showDateRangePicker(
      initialDateRange: initialDateRange,
      context: XNavigator.context,
      firstDate: firstDate ?? now.subtract(const Duration(days: 50)),
      lastDate: lastDate ?? DateTime.now(),
    );
    return picked;
  }

  int nthWeekOfYear(DateTime date) {
    DateTime firstDayOfYear = DateTime(date.year, 1, 1);
    int daysSinceFirstDayOfYear = date.difference(firstDayOfYear).inDays;
    int weekNumber = daysSinceFirstDayOfYear ~/ 7 + 1;
    return weekNumber;
  }

  int nthDayOfTheWeek(DateTime date) {
    int dayOfWeek = date.weekday;
    return dayOfWeek;
  }

  int totalDayFromStart(DateTime a, DateTime b) {
    final from = DateTime(a.year, a.month, a.day);
    final today = DateTime(b.year, b.month, b.day);
    return today.difference(from).inDays;
  }

  int totalWeekFromStart(DateTime a, DateTime b) {
    int weekIn = 3;
    return totalDayFromStart(a, b) ~/ 7 + weekIn;
  }

  String formatMilliseconds(num milliseconds) {
    int seconds = (milliseconds / 1000).round();
    int minutes = seconds ~/ 60;
    seconds %= 60;

    String minutesStr = minutes < 10 ? '0$minutes' : '$minutes';
    String secondsStr = seconds < 10 ? '0$seconds' : '$seconds';

    return '$minutesStr:$secondsStr';
  }

  Map<String, dynamic> getDayWeek(DateTime start, DateTime now) {
    return {
      'dayOfWeek': nthDayOfTheWeek(now),
      'weekOfYear': nthWeekOfYear(now),
      'nthDay': totalDayFromStart(start, now),
      'nthWeek': totalWeekFromStart(start, now),
    };
  }

  String dateToDay([DateTime? dateTime, String? format = 'dd-MM-yyyy']) {
    return DateFormat(format).format(dateTime ?? DateTime.now());
  }

  String dateToFullDay([DateTime? dateTime, String? format = 'dd-MMM-yyyy']) {
    return DateFormat(format).format(dateTime ?? DateTime.now());
  }

  DateTime dayToDate(String day) {
    return DateFormat('dd-MM-yyyy').parse(day);
  }

  String durationDay(DateTime date) {
    if (isDateToday(date)) {
      return 'Today ${hm(date)}';
    }
    if (date.difference(DateTime.now()).inDays < 3) {
      return dhm(date);
    }
    return mdhm(date);
  }

  String mdhm(DateTime date) => DateFormat('dd MMM').add_Hm().format(date);
  String dhm(DateTime date) => DateFormat.EEEE().add_Hm().format(date);
  String hm(DateTime date) => DateFormat.Hm().format(date);
  bool isDateToday(DateTime date) {
    DateTime now = DateTime.now();
    final today =
        date.year == now.year && date.month == now.month && date.day == now.day;
    return today;
  }

  List<String> generateDaysOfWeek() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday));

    final daysOfWeek = List.generate(
      7,
      (index) {
        final day = monday.add(Duration(days: index));
        return DateFormat.E().format(day);
      },
    );
    return daysOfWeek;
  }
}
