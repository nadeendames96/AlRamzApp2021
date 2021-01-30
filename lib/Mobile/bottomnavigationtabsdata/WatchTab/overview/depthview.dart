import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ns_utils/utils/sizes.dart';

class DepthView extends StatefulWidget {
  static int choice = 5;
  @override
  _DepthViewState createState() => _DepthViewState();
}

class _DepthViewState extends State<DepthView> {
  static int current = 1;
  static String _radioValue = current.toString();
  //Initial definition of radio button value
  int choiceValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: Sizes.s50),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                Radio(
                  value: '1',
                  groupValue: _radioValue,
                  onChanged: (value) {
                    radioButtonChanges(value);
                    DepthView.choice = 5;
                  },
                ),
                Text(
                  getTranslated(context, 'displayfifelevels'),
                  style: TextStyleApplied.Text,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: '2',
                  groupValue: _radioValue,
                  onChanged: (value) {
                    radioButtonChanges(value);
                    DepthView.choice = 10;
                  },
                ),
                Text(
                  getTranslated(context, 'displayalllevels'),
                  style: TextStyleApplied.Text,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case '1':
          choiceValue = int.parse(value);
          break;
        case '2':
          choiceValue = int.parse(value);
          break;
        default:
          choiceValue = int.parse(value);
      }
    });
  }
}
