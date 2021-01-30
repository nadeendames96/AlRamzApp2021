import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/overview/secdesignpar2.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/overview/secdesignpart1.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/overview/secdesignpart3.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class FirstSectionDesign extends StatelessWidget {
  String symbolsDesc = '',
      open = '',
      openValue = '',
      limitUp = '',
      limitUupValue = '',
      hign = '',
      highValue = '',
      pe = '',
      peValue = '',
      close = '',
      closeValue = '',
      limitDown = '',
      limitDownValue = '',
      low = '',
      lowValue = '',
      volume = '',
      volumeValue = '',
      value = '',
      valueValue = '',
      mktp = '',
      mktpValue = '';

  FirstSectionDesign(
      this.symbolsDesc,
      this.open,
      this.openValue,
      this.limitUp,
      this.limitUupValue,
      this.hign,
      this.highValue,
      this.pe,
      this.peValue,
      this.close,
      this.closeValue,
      this.limitDown,
      this.limitDownValue,
      this.low,
      this.lowValue,
      this.volume,
      this.volumeValue,
      this.value,
      this.valueValue,
      this.mktp,
      this.mktpValue);

  @override
  Widget build(BuildContext context) {
    return FirstSection(
        this.symbolsDesc,
        this.open,
        this.openValue,
        this.limitUp,
        this.limitUupValue,
        this.hign,
        this.highValue,
        this.pe,
        this.peValue,
        this.close,
        this.closeValue,
        this.limitDown,
        this.limitDownValue,
        this.low,
        this.lowValue,
        this.volume,
        this.volumeValue,
        this.value,
        this.valueValue,
        this.mktp,
        this.mktpValue);
  }

  Widget FirstSection(
      symbolsDesc,
      open,
      openValue,
      limitUp,
      limitUupValue,
      hign,
      highValue,
      pe,
      peValue,
      close,
      closeValue,
      limitDown,
      limitDownValue,
      low,
      lowValue,
      volume,
      volumeValue,
      value,
      valueValue,
      mktp,
      mktpValue) {
    return Container(
        child: SingleChildScrollView(
            child: Container(
      padding: EdgeInsets.only(left: Sizes.s10, right: Sizes.s10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Sizes.s5,
            ),
            Text(
              symbolsDesc,
              style: TextStyleApplied.TextCustom,
            ),
            SizedBox(
              height: Sizes.s10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              PartOne(open, openValue, limitUp, limitUupValue, hign, highValue,
                  pe, peValue),
              PartTow(
                  close, closeValue, limitDown, limitDownValue, low, lowValue),
              PartThree(
                  volume, volumeValue, value, valueValue, mktp, mktpValue),
              PartThree('', '', '', '', '', '')
            ]),
          ]),
    )));
  }
}
