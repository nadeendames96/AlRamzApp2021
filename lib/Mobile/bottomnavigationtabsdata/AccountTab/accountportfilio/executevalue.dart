import 'package:flutter/material.dart';

import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/styles/textstyle.dart';

class ExecuteValues extends StatelessWidget {
  var plVoluePres = '0', plVolueVolue = '0';

  ExecuteValues(this.plVoluePres, this.plVolueVolue);

  @override
  Widget build(BuildContext context) {
    return Execute(this.plVoluePres, this.plVolueVolue);
  }

  Widget Execute(plValuePrec, plValue) {
    if (double.parse(plValue) > 0) {
      return Column(
        children: [
          Text(plValue, style: TextStyleApplied.TextSmallGreen),
          Text(
            plValuePrec,
            style: TextStyleApplied.TextSmallGreen,
          )
        ],
      );
    } else if (double.parse(plValue) < 0) {
      return Column(
        children: [
          Text(
            plValue,
            style: TextStyleApplied.TextSmallRed,
          ),
          Text(
            plValuePrec,
            style: TextStyleApplied.TextSmallRed,
          )
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            plValue,
            style: TextStyleApplied.Text,
          ),
          Text(
            plValuePrec,
            style: TextStyleApplied.Text,
          )
        ],
      );
    }
  }
}
