class TradeObject {
  String accountID;
  String accountNameA;
  String accountNameE;
  String avgExePrice;
  String bankID2;
  String clientID;
  String companyShortNameA;
  String companyShortNameE;
  String date;
  String orderID;
  String precision;
  String price;
  String qTY;
  String remaining;
  String sellBuyA;
  String sellBuyE;
  String statusCode;
  String symbol;
  String totalVolume;
  String tradeID;
  String tradeValue;

  TradeObject(
      {this.accountID,
        this.accountNameA,
        this.accountNameE,
        this.avgExePrice,
        this.bankID2,
        this.clientID,
        this.companyShortNameA,
        this.companyShortNameE,
        this.date,
        this.orderID,
        this.precision,
        this.price,
        this.qTY,
        this.remaining,
        this.sellBuyA,
        this.sellBuyE,
        this.statusCode,
        this.symbol,
        this.totalVolume,
        this.tradeID,
        this.tradeValue});

  factory TradeObject.fromJson(Map<String, dynamic> json) =>TradeObject(
    accountID : json['AccountID'],
      accountNameA : json['AccountNameA'],
    accountNameE : json['AccountNameE'],
    avgExePrice : json['AvgExePrice'],
    bankID2 : json['BankID2'],
    clientID : json['ClientID'],
    companyShortNameA : json['CompanyShortNameA'],
    companyShortNameE : json['CompanyShortNameE'],
    date : json['Date'],
    orderID : json['OrderID'],
    precision : json['Precision'],
    price : json['Price'],
    qTY : json['QTY'],
    remaining : json['Remaining'],
    sellBuyA : json['SellBuyA'],
    sellBuyE : json['SellBuyE'],
    statusCode : json['StatusCode'],
    symbol : json['Symbol'],
    totalVolume : json['TotalVolume'],
    tradeID : json['TradeID'],
    tradeValue : json['TradeValue']
  );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AccountID'] = this.accountID;
    data['AccountNameA'] = this.accountNameA;
    data['AccountNameE'] = this.accountNameE;
    data['AvgExePrice'] = this.avgExePrice;
    data['BankID2'] = this.bankID2;
    data['ClientID'] = this.clientID;
    data['CompanyShortNameA'] = this.companyShortNameA;
    data['CompanyShortNameE'] = this.companyShortNameE;
    data['Date'] = this.date;
    data['OrderID'] = this.orderID;
    data['Precision'] = this.precision;
    data['Price'] = this.price;
    data['QTY'] = this.qTY;
    data['Remaining'] = this.remaining;
    data['SellBuyA'] = this.sellBuyA;
    data['SellBuyE'] = this.sellBuyE;
    data['StatusCode'] = this.statusCode;
    data['Symbol'] = this.symbol;
    data['TotalVolume'] = this.totalVolume;
    data['TradeID'] = this.tradeID;
    data['TradeValue'] = this.tradeValue;
    return data;
  }
}