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
}
