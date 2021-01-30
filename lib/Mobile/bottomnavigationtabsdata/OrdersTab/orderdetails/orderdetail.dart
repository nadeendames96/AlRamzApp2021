import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/Model/order.dart';
import 'package:alramzapp2021/determinetype/determinetypes.dart';
import 'package:alramzapp2021/determinetype/status.dart';
import 'package:alramzapp2021/localization/localizationmethods.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ns_utils/utils/sizes.dart';

class OrderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: Sizes.s30, left: Sizes.s10, right: Sizes.s10),
      child: ListView(
        children: [
          Column(
            children: [
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated(context, 'symbol'),
                      style: TextStyleApplied.TextCustom),
                  Text(OrderTab.symbol, style: TextStyleApplied.Text),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, 'exchange'),
                    style: TextStyleApplied.TextCustom,
                  ),
                  Text(
                    OrderTab.exchangeID,
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, 'orderid'),
                    style: TextStyleApplied.TextCustom,
                  ),
                  Text(
                    OrderTab.orderId,
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, 'accountid'),
                    style: TextStyleApplied.TextCustom,
                  ),
                  Text(
                    OrderTab.accountId,
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated(context, 'account'),
                      style: TextStyleApplied.TextCustom),
                  Text(
                    OrderTab.account,
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated(context, 'operation'),
                      style: TextStyleApplied.TextCustom),
                  DetermineType(OrderTab.type),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, 'quantity'),
                    style: TextStyleApplied.TextCustom,
                  ),
                  Text(
                    OrderTab.quantity,
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, 'price'),
                    style: TextStyleApplied.TextCustom,
                  ),
                  Text(
                    OrderTab.price,
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated(context, 'validity'),
                      style: TextStyleApplied.TextCustom),
                  Text(
                    OrderTab.validity,
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, 'date'),
                    style: TextStyleApplied.TextCustom,
                  ),
                  Text(
                    OrderTab.date,
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated(context, 'remainingqty'),
                      style: TextStyleApplied.TextCustom),
                  Text(
                    OrderTab.remaining_quan,
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated(context, 'avgexeprice'),
                      style: TextStyleApplied.TextCustom),
                  Text(
                    OrderTab.avg_ex_price,
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, 'status'),
                    style: TextStyleApplied.TextCustom,
                  ),
                  Status(OrderTab.status)
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, 'reason'),
                    style: TextStyleApplied.TextCustom,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    OrderTab.reason,
                    style: TextStyleApplied.TextReason,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, 'minimumfill'),
                    style: TextStyleApplied.TextCustom,
                  ),
                  Text(
                    OrderTab.min_fill,
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, 'visiblequantity'),
                    style: TextStyleApplied.TextCustom,
                  ),
                  Text(
                    OrderTab.visible_quan,
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated(context, 'remarks'),
                      style: TextStyleApplied.TextCustom),
                  Text(
                    OrderTab.remark,
                    style: TextStyleApplied.Text,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
