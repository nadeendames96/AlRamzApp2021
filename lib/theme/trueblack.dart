import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/theme/thememodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrueBlackSwitch extends StatelessWidget {
  const TrueBlackSwitch({
    this.showOnlyDarkMode = true,
  });

  final bool showOnlyDarkMode;

  @override
  Widget build(BuildContext context) {
    return new Consumer<ThemeModel>(
        builder: (context, model, child) => Container(
              child: !showOnlyDarkMode || model.darkMode && showOnlyDarkMode
                  ? ListTile(
                      title: Text(getTranslated(context, 'TrueBlack')),
                      trailing: Switch.adaptive(
                        value: model.trueBlack,
                        onChanged: model.changeTrueBlack,
                      ),
                    )
                  : null,
            ));
  }
}
