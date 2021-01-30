import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

formatDate(BuildContext context, dateString, oldDateFormat, newDateFormat) {
  var format = DateFormat(oldDateFormat, English);
  String dateRep = dateString.substring(0, 8);
  if (dateRep.contains('/')) {
    dateRep = dateRep.replaceAll('/', '-');
  }
  dateString = dateString.replaceAll(dateString.substring(0, 8), dateRep);
  var newDate = format.parse(dateString);
  format = DateFormat(newDateFormat, English);
  var date = format.format(newDate);
  return date;
}
