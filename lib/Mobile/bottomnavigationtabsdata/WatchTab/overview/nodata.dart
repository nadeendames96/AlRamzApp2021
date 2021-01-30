import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              child: Table(
            border:
                TableBorder.all(color: AppColors.light_blue.withOpacity(.2)),
            textDirection: TextDirection.rtl,
            defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            children: [
              TableRow(children: [
                Text(
                  "#",
                  style: TextStyleApplied.TextCustom,
                  textAlign: TextAlign.center,
                ),
                Text(
                  getTranslated(context, 'offqty'),
                  style: TextStyleApplied.TextCustom,
                ),
                Text(getTranslated(context, 'offer'),
                    style: TextStyleApplied.TextCustom,
                    textAlign: TextAlign.center),
                Text(getTranslated(context, 'bid'),
                    style: TextStyleApplied.TextCustom,
                    textAlign: TextAlign.center),
                Text(getTranslated(context, 'bidqty'),
                    style: TextStyleApplied.TextCustom,
                    textAlign: TextAlign.center),
                Text(
                  "#",
                  style: TextStyleApplied.TextCustom,
                  textAlign: TextAlign.center,
                )
              ]),
              TableRow(children: [
                Text(
                  '',
                ),
                Text(
                  '',
                ),
                Text(
                  '',
                ),
                Text(
                  getTranslated(context, 'nodata'),
                  style: TextStyleApplied.TextCustom,
                ),
                Text(
                  '',
                ),
                Text(
                  '',
                ),
              ]),
              TableRow(children: [
                Text('0',
                    style: TextStyleApplied.Text, textAlign: TextAlign.center),
                Text('0',
                    style: TextStyleApplied.Text, textAlign: TextAlign.center),
                Text(''),
                Text(''),
                Text('0',
                    style: TextStyleApplied.Text, textAlign: TextAlign.center),
                Text('0',
                    style: TextStyleApplied.Text, textAlign: TextAlign.center),
              ]),
            ],
          )),
        ],
      ),
    );
  }
}
