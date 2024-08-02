import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Date {
  static String convertDate(DateTime date, String format) {
    try {
      DateFormat dateFormat = DateFormat(format);
      String formattedDate = dateFormat.format(date);
      return formattedDate;
    } catch (e) {
      debugPrint('Error parsing date: $e');
      return '';
    }
  }

  static Future<DateTime?> selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
  }

  static bool isInSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }

  static DateTime addMonths(DateTime date, int monthsToAdd) {
    int newYear = date.year;
    int newMonth = date.month + monthsToAdd;

    // Adjust year if month goes beyond December
    while (newMonth > 12) {
      newYear++;
      newMonth -= 12;
    }

    int newDay = date.day;

    // Handle cases where the new month has fewer days than the current day
    int lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;
    if (newDay > lastDayOfNewMonth) {
      newDay = lastDayOfNewMonth;
    }

    return DateTime(newYear, newMonth, newDay);
  }

  static DateTime subtractMonths(DateTime date, int monthsToSubtract) {
    int newYear = date.year;
    int newMonth = date.month - monthsToSubtract;

    // Adjust year if month goes below January
    while (newMonth < 1) {
      newYear--;
      newMonth += 12;
    }

    int newDay = date.day;

    // Handle cases where the new month has fewer days than the current day
    int lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;
    if (newDay > lastDayOfNewMonth) {
      newDay = lastDayOfNewMonth;
    }

    return DateTime(newYear, newMonth, newDay);
  }
}
