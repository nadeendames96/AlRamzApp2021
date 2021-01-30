import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/placeorder/placeorder.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/menues/menupoporder.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ns_utils/utils/sizes.dart';

class Status extends StatelessWidget {
  var status = '';
  TextStyle style;

  Status(this.status, {this.style});

  @override
  Widget build(BuildContext context) {
    return determineStatus(this.status);
  }

  Widget determineStatus(String status) {
    if (status == 'R') {
      return Builder(
        builder: (context) {
          return Text(getTranslated(context, 'rejected'), style: style);
        },
      );
    }
    if (status == 'A') {
      return Builder(builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(getTranslated(context, 'active'), style: style),
            Hero(
              tag: 'AppStrings.heroMenuPopup55434',
              child: PopupMenuButton<String>(
                offset: Offset(0, 100),
                // onSelected: choiceActionOrder,
                icon: Icon(
                  Icons.more_vert,
                  size: Sizes.s25,
                  color: AppColors.white,
                ),
                itemBuilder: (BuildContext context) {
                  return MenuPopUpOrder.choice.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
                onSelected: choiceAction,
              ),
            ),
          ],
        );
      });
    } else if (status == 'W') {
      return Builder(builder: (context) {
        return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            getTranslated(context, 'waiting'),
            style: style,
          ),
          Hero(
            tag: 'AppStrings.heroMenuPopup55434',
            child: PopupMenuButton<String>(
              offset: Offset(0, 100),
              // onSelected: choiceActionOrder,
              icon: Icon(
                Icons.more_vert,
                size: Sizes.s25,
                color: AppColors.white,
              ),
              itemBuilder: (BuildContext context) {
                return MenuPopUpOrder.choice.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              onSelected: choiceAction,
            ),
          ),
        ]);
      });
    } else if (status == 'T') {
      return Builder(builder: (context) {
        return Text(
          getTranslated(context, 'sent'),
          style: style,
        );
      });
    } else if (status == 'E') {
      return Builder(builder: (context) {
        return Text(
          getTranslated(context, 'expired'),
          style: style,
        );
      });
    } else if (status == 'S') {
      return Builder(builder: (context) {
        return Text(
          getTranslated(context, 'fullyfilled'),
          style: style,
        );
      });
    } else if (status == 'AL') {
      return Builder(builder: (context) {
        return Text(
          getTranslated(context, 'all'),
          style: style,
        );
      });
    }
    // else if(status=='S'){
    //   return Builder(builder: (context){
    //     return Text(getTranslated(context, 'sent'),style: TextStyle(color: AppColors.lightgreen,fontFamily: FontFamily.roboto),);
    //   });
    // }
    else if (status == 'C') {
      return Builder(builder: (context) {
        return Text(
          getTranslated(context, 'cancelorder'),
          style: style,
        );
      });
    } else {
      return Text(status, style: style);
    }
  }

  choiceAction(String choice) {
    return Builder(builder: (context) {
      // ignore: missing_return
      if (choice == MenuPopUpOrder.modifier) {
        AppRoutes.push(context, PlaceOrder());
      }
      // ignore: missing_return
      else if (choice == MenuPopUpOrder.cancel) {
        // AppRoutes.push(context, CancelOrder());
      }
    });
  }
}
