import 'package:alramzapp2021/utils/assets.dart';
import 'package:alramzapp2021/utils/strings.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/src.dart';

class AppLogoWidget extends StatelessWidget {
  final double size;
  final String image;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const AppLogoWidget(
      {Key key, this.margin, this.padding, this.size, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: AppStrings.appName,
      child: Container(
        margin: margin ?? EdgeInsets.zero,
        padding: padding ?? Sizes.smallSpace,
        child: Image(
          image: AssetImage(image ?? Assets.logo),
          height: size ?? Sizes.s300,
          width: size ?? Sizes.s300,
          fit: BoxFit.contain,
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
      child: Text(
        AppStrings.appName,
        style: TextStyleApplied.Text,
    )
    );

  }
}
