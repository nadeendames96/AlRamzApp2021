import 'dart:ui';

import 'package:flutter/material.dart';

class SpacificFormate extends StatelessWidget {
  String value = '';
  TextStyle valueText;
  SpacificFormate(this.value, {this.valueText});
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';
  @override
  Widget build(BuildContext context) {
    return formateFun(this.value);
  }

  Widget formateFun(String value) {
    return Text(
      value.replaceAllMapped(reg, mathFunc),
      style: valueText,
    );
  }
}
