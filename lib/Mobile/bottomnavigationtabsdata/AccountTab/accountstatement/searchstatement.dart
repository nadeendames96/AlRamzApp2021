import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/AccountTab/accounttabs/accounttabs.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ns_utils/src.dart';
import 'package:ns_utils/utils/sizes.dart';

import 'accountstatement.dart';

class SearchForm extends StatefulWidget {
  static DateTime selectedDateTo = DateTime.now();
  static DateTime selectedDateFrom = selectedDateTo.subtract(Duration(days: 1));
  static final DateFormat formatter = DateFormat('ddMMyyyy000000');
  static String dateto = formatter.format(selectedDateTo);
  static String datefrom = formatter.format(selectedDateFrom);
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  String _radioValue = '1';
  int choiceValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Statement.datefrom = SearchForm.datefrom;
    Statement.dateto = SearchForm.dateto;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.99,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.5,
        color: AppColors.primary,
        child: Opacity(
          opacity: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Sizes.s50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    getTranslated(context, 'statement'),
                    style: TextStyleApplied.TextLarge,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: AppColors.red,
                      size: Sizes.s30,
                    ),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: Sizes.s20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, 'from'),
                    style: TextStyleApplied.Text,
                  ),
                  Container(
                    height: Sizes.s30,
                    color: AppColors.white,
                    width: Sizes.s200,
                    child: GestureDetector(
                      child: Text(
                          "${SearchForm.selectedDateFrom.toLocal()}"
                              .split(' ')[0],
                          style: TextStyleApplied.TextBlack),
                      onTap: showDateFrom,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Sizes.s5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, 'to') + '    ',
                    style: TextStyleApplied.Text,
                  ),
                  Container(
                    height: Sizes.s30,
                    color: AppColors.white,
                    width: Sizes.s200,
                    child: GestureDetector(
                      child: Text(
                        "${SearchForm.selectedDateTo.toLocal()}".split(' ')[0],
                        style: TextStyleApplied.TextBlack,
                      ),
                      onTap: showDateTo,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: Sizes.s50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Radio(
                              value: '1',
                              groupValue: _radioValue,
                              onChanged: (value) {
                                setState(() {
                                  _radioValue = value;
                                  radioButtonChanges(value);
                                });
                              },
                            ),
                            Text(
                              getTranslated(context, 'normal'),
                              style: TextStyleApplied.Text,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Radio(
                              value: '2',
                              groupValue: _radioValue,
                              onChanged: (value) {
                                setState(() {
                                  _radioValue = value;
                                  radioButtonChanges(value);
                                });
                              },
                            ),
                            Text(
                              getTranslated(context, 'bygroup'),
                              style: TextStyleApplied.Text,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Radio(
                              value: '3',
                              groupValue: _radioValue,
                              onChanged: (value) {
                                setState(() {
                                  _radioValue = value;
                                  radioButtonChanges(value);
                                });
                              },
                            ),
                            Text(
                              getTranslated(context, 'byorder'),
                              style: TextStyleApplied.Text,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  color: AppColors.lightgreen2,
                  child: FlatButton(
                    child: Text(getTranslated(context, 'generatestatement'),
                        style: TextStyleApplied.Text),
                    onPressed: () {
                      setState(() {
                        Statement.datefrom = SearchForm.datefrom;
                        Statement.dateto = SearchForm.dateto;
                        Statement(SearchForm.datefrom, SearchForm.dateto);
                        AppRoutes.push(context, AccountTabs());
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showDateTo() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: SearchForm.selectedDateTo,
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(DateTime.now().year + 20),
    );
    if (picked != null && picked != SearchForm.selectedDateTo)
      setState(() {
        SearchForm.selectedDateTo = picked;
        SearchForm.dateto =
            SearchForm.formatter.format(SearchForm.selectedDateTo);
      });
  }

  showDateFrom() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: SearchForm.selectedDateFrom,
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(DateTime.now().year + 20),
    );
    if (picked != null && picked != SearchForm.selectedDateFrom)
      setState(() {
        SearchForm.selectedDateFrom = picked;
        SearchForm.datefrom =
            SearchForm.formatter.format(SearchForm.selectedDateFrom);
      });
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case '1':
          choiceValue = int.parse(value);
          break;
        case '2':
          choiceValue = int.parse(value);
          break;
        case '3':
          choiceValue = int.parse(value);
          break;
        default:
          choiceValue = int.parse(value);
      }
    });
  }
}
