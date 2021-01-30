import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/styles/textstyle.dart';

import '../executevalue.dart';

class ForthSecPort extends StatelessWidget {
  String pl = '',
      plVoluePres = '',
      plVolueVolue = '',
      value2 = '',
      value2Value = '';

  ForthSecPort(this.pl, this.plVoluePres, this.plVolueVolue, this.value2,
      this.value2Value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(getTranslated(context, 'pl'), style: TextStyleApplied.Text),
            SizedBox(
              width: Sizes.s5,
            ),
            ExecuteValues(plVoluePres, plVolueVolue),
          ],
        ),
        SizedBox(
          height: Sizes.s10,
        ),
        Column(
          children: [
            Text(
              getTranslated(context, 'AvgPrice'),
              style: TextStyleApplied.Text,
            ),
            Text(
              value2Value,
              style: TextStyleApplied.Text,
            )
          ],
        )
      ],
    );
  }
}
