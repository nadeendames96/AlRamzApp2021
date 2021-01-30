import 'package:alramzapp2021/componants/applogowidset.dart';
import 'package:alramzapp2021/componants/background.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class Token extends StatefulWidget {
  @override
  _TokenState createState() => _TokenState();
}

class _TokenState extends State<Token> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalObjectKey<ScaffoldState>('Token');
  TextEditingController token = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Form(
            key: _formKey,
            child: Stack(fit: StackFit.expand, children: <Widget>[
              BackgroundImageWidget(),
              ListView(children: <Widget>[
                Center(
                  child: AppLogoWidget(
                    margin: EdgeInsets.only(top: Sizes.s100),
                    padding: Sizes.defaultSpace,
                  ),
                ),
                SizedBox(
                  height: Sizes.s50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.s20,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: Sizes.s5),
                    color: AppColors.white,
                    child: TextFormField(
                      controller: token,
                      cursorColor: Colors.white,
                      obscureText: true,
                      style: TextStyleApplied.TextBlack,
                      decoration: InputDecoration(
                        hintText: getTranslated(context, 'TokenID'),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        hintStyle: TextStyleApplied.Text,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Sizes.s15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.s20,
                  ),
                  child: Container(
                    color: AppColors.gray,
                    child: FlatButton(
                      child: Text(
                        getTranslated(context, 'submit'),
                        style: TextStyleApplied.Text,
                      ),
                      onPressed: () {
                        setState(() {
                          // Submit(token.text);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Sizes.s5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.s20,
                  ),
                  child: Container(
                    color: AppColors.gray,
                    child: FlatButton(
                      child: Text(getTranslated(context, 'Cancel')),
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) {
                                // return SureCancel();
                              }));
                        });
                      },
                    ),
                  ),
                )
              ])
            ])));
  }
}
