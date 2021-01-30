import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';

class PartTow extends StatelessWidget {
  String open = '',
      openvalue = '',
      limitup = '',
      limitupvalue = '',
      high = '',
      highvalue = '';

  PartTow(this.open, this.openvalue, this.limitup, this.limitupvalue, this.high,
      this.highvalue);

  @override
  Widget build(BuildContext context) {
    return part1(this.open, this.openvalue, this.limitup, this.limitupvalue,
        this.high, this.highvalue);
  }

  Widget part1(open, openvalue, limitup, limitupvalue, hign, highvalue) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                open,
                style: TextStyleApplied.TextCustom,
              ),
              Text(
                openvalue,
                style: TextStyleApplied.Text,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                limitup,
                style: TextStyleApplied.TextCustom,
              ),
              Text(
                limitupvalue,
                style: TextStyleApplied.Text,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hign,
                style: TextStyleApplied.TextCustom,
              ),
              Text(
                highvalue,
                style: TextStyleApplied.Text,
              )
            ],
          ),
        ]);
  }
}
