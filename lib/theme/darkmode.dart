import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/theme/thememodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/styles/textstyle.dart';
import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/utils/colors.dart';

class DarkModeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Consumer<ThemeModel>(
        builder: (context, model, child) => Container(
              child: ListTile(
                title: Text(
                  getTranslated(context, 'DarkTheme'),
                  style: TextStyleApplied.Text,
                ),
                trailing: Switch.adaptive(
                  activeColor: AppColors.white,
                  activeTrackColor: AppColors.white,
                  inactiveTrackColor: AppColors.white,
                  inactiveThumbColor: AppColors.white,
                  value: model.darkMode,
                  onChanged: model.changeDarkMode,
                ),
              ),
            ));
  }
}
