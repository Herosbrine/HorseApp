import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConvertDate {
  /// Convert and Format Date from TimeStamp
  static String? formatDate(DateTime? date, {String format = 'yMMMd'}) {
    if (date == null) return null;

    // DateTime? _dateTime = date.toDate();
    DateFormat formatter = DateFormat(format);
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  /// Format date to time
  static String? formatTime(String? time) {
    DateTime? _datetime = convertToDateTime(time);
    if (_datetime == null) return null;
    DateFormat formatter = DateFormat('HH:mm');
    String formattedTime = formatter.format(_datetime);
    return formattedTime;
  }

  /// Convert string to date time
  static DateTime? convertToDateTime(String? date) {
    if (date == null) return null;
    DateTime dateTime = DateTime.parse(date);
    return dateTime;
  }
}
