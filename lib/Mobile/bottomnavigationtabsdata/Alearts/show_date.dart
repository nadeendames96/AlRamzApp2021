import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowDate extends StatefulWidget {
  @override
  _ShowDateState createState() => _ShowDateState();
}

class _ShowDateState extends State<ShowDate> {
  static DateTime today = DateTime.now();
  static final DateFormat formatter = DateFormat('ddMMyyyyHHmmss');
  static String date = formatter.format(today);

  @override
  Widget build(BuildContext context) {
    return showDateTo();
  }

  showDateTo() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(DateTime.now().year + 20),
    );
    if (picked != null && picked != today)
      setState(() {
        today = picked;
        date = formatter.format(today);
      });
  }
}
