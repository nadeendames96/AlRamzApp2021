class GetOrderListObject {
  String accountID;
  String accountNameA;
  String accountNameE;
  String avgExePrice;
  String clientID;
  String companyShortNameA;
  String companyShortNameE;
  String entryDate;
  String exchange;
  String execOrderComm;
  String execQty;
  String maxPrice;
  String minFillQty;
  String minPrice;
  String modifyDate;
  String nIN;
  String ordComm;
  String orderID;
  String orderTypeCode;
  String originCode;
  String precision;
  String price;
  String rejectReason;
  String remaining;
  String remark;
  String sMARTORDERID;
  String sellBuyFlag;
  String statusCode;
  String stopLossPx;
  String symbol;
  String totalVolume;
  String validityCode;
  String validityDate;
  String visibleQty;

  GetOrderListObject(
      {this.accountID,
      this.accountNameA,
      this.accountNameE,
      this.avgExePrice,
      this.clientID,
      this.companyShortNameA,
      this.companyShortNameE,
      this.entryDate,
      this.exchange,
      this.execOrderComm,
      this.execQty,
      this.maxPrice,
      this.minFillQty,
      this.minPrice,
      this.modifyDate,
      this.nIN,
      this.ordComm,
      this.orderID,
      this.orderTypeCode,
      this.originCode,
      this.precision,
      this.price,
      this.rejectReason,
      this.remaining,
      this.remark,
      this.sMARTORDERID,
      this.sellBuyFlag,
      this.statusCode,
      this.stopLossPx,
      this.symbol,
      this.totalVolume,
      this.validityCode,
      this.validityDate,
      this.visibleQty});

  factory GetOrderListObject.fromJson(Map<String, dynamic> json) =>
      GetOrderListObject(
        accountID: json['AccountID'],
        accountNameA: json['AccountNameA'],
        accountNameE: json['AccountNameE'],
        avgExePrice: json['AvgExePrice'],
        clientID: json['ClientID'],
        companyShortNameA: json['CmpanyShortNameA'],
        companyShortNameE: json['CompanyShortNameE'],
        entryDate: json['EntryDate'],
        exchange: json['Exchange'],
        execOrderComm: json['ExecOrderComm'],
        execQty: json['ExecQty'],
        maxPrice: json['MaxPrice'],
        minFillQty: json['MinFillQty'],
        minPrice: json['MinPrice'],
        modifyDate: json['ModifyDate'],
        nIN: json['NIN'],
        ordComm: json['OrdComm'],
        orderID: json['OrderID'],
        orderTypeCode: json['OrderTypeCode'],
        originCode: json['OriginCode'],
        precision: json['Precision'],
        price: json['Price'],
        rejectReason: json['RejectReason'],
        remaining: json['Remaining'],
        remark: json['Remark'],
        sMARTORDERID: json['SMART_ORDER_ID'],
        sellBuyFlag: json['SellBuyFlag'],
        statusCode: json['StatusCode'],
        stopLossPx: json['StopLossPx'],
        symbol: json['Symbol'],
        totalVolume: json['TotalVolume'],
        validityCode: json['ValidityCode'],
        validityDate: json['ValidityDate'],
        visibleQty: json['VisibleQty'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AccountID'] = this.accountID;
    data['AccountNameA'] = this.accountNameA;
    data['AccountNameE'] = this.accountNameE;
    data['AvgExePrice'] = this.avgExePrice;
    data['ClientID'] = this.clientID;
    data['CompanyShortNameA'] = this.companyShortNameA;
    data['CompanyShortNameE'] = this.companyShortNameE;
    data['EntryDate'] = this.entryDate;
    data['Exchange'] = this.exchange;
    data['ExecOrderComm'] = this.execOrderComm;
    data['ExecQty'] = this.execQty;
    data['MaxPrice'] = this.maxPrice;
    data['MinFillQty'] = this.minFillQty;
    data['MinPrice'] = this.minPrice;
    data['ModifyDate'] = this.modifyDate;
    data['NIN'] = this.nIN;
    data['OrdComm'] = this.ordComm;
    data['OrderID'] = this.orderID;
    data['OrderTypeCode'] = this.orderTypeCode;
    data['OriginCode'] = this.originCode;
    data['Precision'] = this.precision;
    data['Price'] = this.price;
    data['RejectReason'] = this.rejectReason;
    data['Remaining'] = this.remaining;
    data['Remark'] = this.remark;
    data['SMART_ORDER_ID'] = this.sMARTORDERID;
    data['SellBuyFlag'] = this.sellBuyFlag;
    data['StatusCode'] = this.statusCode;
    data['StopLossPx'] = this.stopLossPx;
    data['Symbol'] = this.symbol;
    data['TotalVolume'] = this.totalVolume;
    data['ValidityCode'] = this.validityCode;
    data['ValidityDate'] = this.validityDate;
    data['VisibleQty'] = this.visibleQty;
    return data;
  }
}
