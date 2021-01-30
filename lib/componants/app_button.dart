import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/src.dart';

class AppButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final GestureTapCallback onPressed;
  final String text;
  final BorderRadius _borderRadius = BorderRadius.all(
    Radius.circular(Sizes.s20),
  );

  final bool enabled;

  AppButton({
    @required this.onTap,
    @required this.onPressed,
    @required this.text,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      // borderRadius: _borderRadius,
      onPressed: enabled ? onTap : () {},
      child: Container(
        width: Sizes.s165,
        height: Sizes.s70,
        child: Center(
          child: Text(
            text,
            style: TextStyleApplied.Text,
          ),
        ),
        decoration: BoxDecoration(
          color: enabled ? AppColors.aseli : Colors.grey,
          borderRadius: _borderRadius,
        ),

        // shape:RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(5),
        //     side: BorderSide(color:AppColors.aseli)
        // ),
      ),
    );
  }
}
