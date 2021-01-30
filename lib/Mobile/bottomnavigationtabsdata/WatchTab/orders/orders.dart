import 'dart:convert';

import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/Model/order.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/OrdersTab/orderdetails/orderdetails.dart';
import 'package:alramzapp2021/Mobile/bottomnavigationtabsdata/WatchTab/watchtabs/tabs.dart';
import 'package:alramzapp2021/services/OrdersService/getorderlist_object.dart';
import 'package:alramzapp2021/services/config.dart';
import 'package:alramzapp2021/services/fetchdataservices/ExchangeOrders.dart';
import 'package:alramzapp2021/utils/colors.dart';
import 'package:alramzapp2021/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ns_utils/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'orderinfo.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<dynamic> _users = [];

  void fetchUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String webcode = prefs.getString('webcode');
    var response = await http
        .get("${Config.GetOrderList}$webcode")
        .timeout(const Duration(seconds: 15));
    setState(() {
      _users = json.decode(response.body);
    });
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsers();
  }

  bool isDivider = false;
  @override
  Widget build(BuildContext context) {
    return Order();
  }

  Widget Order() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: Sizes.s15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      RefreshIndicator(
                        onRefresh: _getData,
                        child: Text('Refresh'),
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            child: FutureBuilder<List<GetOrderListObject>>(
              future: ExchangesOrders().getOrdersList(Config.clientID),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Column(
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      Container()
                    ],
                  );
                } else {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (WatchTabs.symbol == snapshot.data[index].symbol) {
                        if (index % 2 == 0) {
                          isDivider = true;
                        } else {
                          isDivider = false;
                        }
                        return isDivider
                            ? Container(
                                color: AppColors.black.withOpacity(.3),
                                child: Card(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        OrderTab.symbol =
                                            snapshot.data[index].symbol;
                                        OrderTab.exchangeID =
                                            snapshot.data[index].exchange;
                                        OrderTab.orderId =
                                            snapshot.data[index].orderID;
                                        OrderTab.accountId =
                                            snapshot.data[index].accountID;
                                        OrderTab.account =
                                            snapshot.data[index].accountNameE;
                                        OrderTab.type =
                                            snapshot.data[index].sellBuyFlag;
                                        OrderTab.quantity =
                                            snapshot.data[index].execQty;
                                        OrderTab.price =
                                            snapshot.data[index].price;
                                        OrderTab.validity =
                                            snapshot.data[index].validityCode;
                                        OrderTab.date =
                                            snapshot.data[index].entryDate;
                                        OrderTab.remaining_quan =
                                            snapshot.data[index].remaining;
                                        OrderTab.avg_ex_price =
                                            snapshot.data[index].avgExePrice;
                                        OrderTab.status =
                                            snapshot.data[index].statusCode;
                                        OrderTab.reason =
                                            snapshot.data[index].rejectReason;
                                        OrderTab.min_fill =
                                            snapshot.data[index].minFillQty;
                                        OrderTab.visible_quan =
                                            snapshot.data[index].visibleQty;
                                        OrderTab.remark =
                                            snapshot.data[index].remark;
                                        OrderTab.totalVolume =
                                            snapshot.data[index].totalVolume;
                                        OrderTab.origin =
                                            snapshot.data[index].originCode;
                                        OrderTab.nin = snapshot.data[index].nIN;
                                        AppRoutes.push(context, OrderDetails());
                                      });
                                    },
                                    child: OrderInfo(
                                        snapshot.data[index].symbol,
                                        snapshot.data[index].sellBuyFlag,
                                        snapshot.data[index].totalVolume,
                                        snapshot.data[index].price,
                                        snapshot.data[index].statusCode,
                                        snapshot.data[index].accountNameE,
                                        snapshot.data[index].rejectReason),
                                  ),
                                ),
                              )
                            : Container(
                                child: Padding(
                                  padding: EdgeInsets.only(left: Sizes.s3),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        OrderTab.symbol =
                                            snapshot.data[index].symbol;
                                        OrderTab.exchangeID =
                                            snapshot.data[index].exchange;
                                        OrderTab.orderId =
                                            snapshot.data[index].orderID;
                                        OrderTab.accountId =
                                            snapshot.data[index].accountID;
                                        OrderTab.account =
                                            snapshot.data[index].accountNameE;
                                        OrderTab.type =
                                            snapshot.data[index].sellBuyFlag;
                                        OrderTab.quantity =
                                            snapshot.data[index].execQty;
                                        OrderTab.price =
                                            snapshot.data[index].price;
                                        OrderTab.validity =
                                            snapshot.data[index].validityCode;
                                        OrderTab.date =
                                            snapshot.data[index].entryDate;
                                        OrderTab.remaining_quan =
                                            snapshot.data[index].remaining;
                                        OrderTab.avg_ex_price =
                                            snapshot.data[index].avgExePrice;
                                        OrderTab.status =
                                            snapshot.data[index].statusCode;
                                        OrderTab.reason =
                                            snapshot.data[index].rejectReason;
                                        OrderTab.min_fill =
                                            snapshot.data[index].minFillQty;
                                        OrderTab.visible_quan =
                                            snapshot.data[index].visibleQty;
                                        OrderTab.remark =
                                            snapshot.data[index].remark;
                                        OrderTab.totalVolume =
                                            snapshot.data[index].totalVolume;
                                        OrderTab.origin =
                                            snapshot.data[index].originCode;
                                        OrderTab.nin = snapshot.data[index].nIN;
                                        AppRoutes.push(context, OrderDetails());
                                      });
                                    },
                                    child: OrderInfo(
                                        snapshot.data[index].symbol,
                                        snapshot.data[index].sellBuyFlag,
                                        snapshot.data[index].totalVolume
                                            .toString(),
                                        snapshot.data[index].price.toString(),
                                        snapshot.data[index].statusCode,
                                        snapshot.data[index].accountNameE,
                                        snapshot.data[index].rejectReason),
                                  ),
                                ),
                              );
                      } else {
                        index++;
                        return SizedBox();
                      }
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
