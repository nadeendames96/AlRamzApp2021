import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';

class FirstPortofilo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Icons.search,
          color: AppColors.white,
        ),
        Text(
          getTranslated(context, 'search'),
          style: TextStyleApplied.Text,
        )
      ],
    );
  }
}
