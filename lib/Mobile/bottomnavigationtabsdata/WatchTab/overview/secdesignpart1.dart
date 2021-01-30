import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';

class PartOne extends StatelessWidget {
  String open = '',
      openvalue = '',
      limitup = '',
      limitupvalue = '',
      high = '',
      highvalue = '',
      pe = '',
      pevalue = '';

  PartOne(this.open, this.openvalue, this.limitup, this.limitupvalue, this.high,
      this.highvalue, this.pe, this.pevalue);

  @override
  Widget build(BuildContext context) {
    return part1(this.open, this.openvalue, this.limitup, this.limitupvalue,
        this.high, this.highvalue, this.pe, this.pevalue);
  }

  Widget part1(
      open, openvalue, limitup, limitupvalue, hign, highvalue, pe, pevalue) {
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pe,
                style: TextStyleApplied.TextCustom,
              ),
              Text(
                pevalue,
                style: TextStyleApplied.Text,
              )
            ],
          ),
        ]);
  }
}
