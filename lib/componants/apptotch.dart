import 'package:alramzapp2021/utils/assets.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/strings.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/src.dart';

class AppTouchIDWidget extends StatelessWidget {
  final double size;
  final String image;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadius _borderRadius = BorderRadius.all(
    Radius.circular(
      Sizes.s20,
    ),
  );
  final bool enabled;
  final GestureTapCallback onTap;
  final GestureTapCallback onPressed;
  AppTouchIDWidget(
      {Key key,
      this.margin,
      this.padding,
      this.size,
      this.image,
      this.enabled = true,
      this.onTap,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: enabled ? onTap : () {},
      child: Container(
        decoration: BoxDecoration(
          color: enabled ? AppColors.aseli : Colors.grey,
          borderRadius: _borderRadius,
        ),
        width: Sizes.s165,
        height: Sizes.s70,
        padding: EdgeInsets.all(Sizes.s15),
        child: Image(
          image: AssetImage(image ?? Assets.touchID),
          height: size ?? Sizes.s50,
          width: size ?? Sizes.s50,
          fit: BoxFit.contain,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 10),
      child: Text(AppStrings.appName, style: TextStyleApplied.Text),
    );
  }
}
