import 'package:chg_racing/services/convert_date.dart';
import 'package:flutter/material.dart';

class DateTimePicker {
  Future<String?> selectDate(BuildContext context,
      {required DateTime initialDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked == null) return null;

    String? _date = ConvertDate.formatDate(picked);
    return _date;
  }
}
