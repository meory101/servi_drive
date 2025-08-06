import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';



abstract class DateTimeHelper {
  static String formatDateWithMonthName({required String? date}) {
    try {
      if (date == null) return "";
      return DateFormat('d-M-yyyy').format(DateTime.parse(date).toLocal());
    } catch (e) {
      return '';
    }
  }
 static String formatDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    try {

      final String pattern = 'dd MMM';
      final DateFormat formatter = DateFormat(pattern);
      return '${formatter.format(startDate)} ${formatter.format(endDate)}';
    } catch (e) {
      return '';
    }
  }
  static DateTime convertIsoToDateTime(String isoString) {
    try {
      return DateTime.parse(isoString);
    } catch (e) {
      return DateTime.now();
    }
  }

  static DateTime? convertToDateTime({required String? date}){
    if((date??"").isEmpty) return null;
    return DateTime.parse((date??""));
  }

  static String getDaysBetween(String startDate, String endDate) {
    if (startDate.isEmpty || endDate.isEmpty) return "";
    return "${DateTime.parse(endDate)
            .difference(DateTime.parse(startDate).toLocal())
            .inDays} ${"day".tr()}";
  }

  static String getHoursBetween(String startDate, String endDate) {
    if (startDate.isEmpty || endDate.isEmpty) return "";
    return "${DateTime.parse(endDate)
            .difference(DateTime.parse(startDate).toLocal())
            .inHours} ${"hour".tr()}";
  }

  static String getHour(String date) {
    if ((date).isEmpty) return "";
    DateTime dateTime = DateTime.parse(date).toLocal();
    int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    hour = hour == 0 ? 12 : hour;
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  static String? convertToIsoString({required DateTime? date}) {
    if (date == null) return "";
    return date.toIso8601String();
  }

  static String formatDateWithDash({required DateTime? date}) {
    try {
      if (date == null) return "";
      return DateFormat('yyyy-m-d').format(date.toLocal());
    } catch (e) {
      return '';
    }
  }

  static DateTime convertToUtc({required DateTime date}) {
    return date.toUtc();
  }

  static DateTime toLocal({required DateTime date}) {
    return date.toLocal();
  }

  static String formatTimeOnly({required String? date}) {
    try {
      if (date == null) return "";
      final dateTime = DateTime.parse(date).toLocal();
      return DateFormat('h:mm a').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static String formatDateWithDayAndMonthName({required String? date}) {
    try {
      if (date == null) return "";
      final dateTime = DateTime.parse(date).toLocal();
      return DateFormat('EEEE   d  MMMM  yyyy', 'ar').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static String formatDateBasedOnLang({required String date, String? lang}) {
    if (date.isEmpty) return "";

    DateTime dateTime = DateTime.parse(date).toLocal();

    String dayName = DateFormat('EEEE', lang ?? 'ar').format(dateTime);
    String dayNumber = DateFormat('d').format(dateTime);
    String monthName = DateFormat('MMMM', lang ?? 'ar').format(dateTime);

    return "$dayName $dayNumber $monthName";
  }

  static String formatTimeBasedOnLang({required String date, String? lang}) {
    if (date.isEmpty) return "";
    final dateTime = DateTime.parse(date).toLocal();
    return DateFormat('h:mm a', lang).format(dateTime);
  }

  static String formatDateWithSlashBasedOnLang({
    required String date,
    String? lang,
  }) {
    if (date.isEmpty) return "";
    DateTime dateTime = DateTime.parse(date).toLocal();
    return DateFormat('M/d/yyyy', lang ?? 'en').format(dateTime);
  }

  static DateTime mergeDateWithTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  static String getCurrentYear() {
    return DateTime.now().year.toString();
  }

  static String formatTimeToString(TimeOfDay time, {DateTime? date}) {
    final now = date ?? DateTime.now();
    final localDateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final utcDateTime = localDateTime.toUtc();
    return utcDateTime.toIso8601String();
  }
}
