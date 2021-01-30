class ReskManagment {
  String accountID;
  String clientID;
  String compInit;
  String custodyID;
  String includeFacil;
  String includeMargin;
  String mainClientID;
  String memberID;
  String nIN;
  String orderID;
  String orderType;
  String portMang;
  String price;
  String qty;
  String symbol;
  String typeCode;
  String uCode;
  String userCat;
  String validity;
  String validityCode;
  String settType;
  String webCode;

  ReskManagment(
      {this.accountID,
      this.clientID,
      this.compInit,
      this.custodyID,
      this.includeFacil,
      this.includeMargin,
      this.mainClientID,
      this.memberID,
      this.nIN,
      this.orderID,
      this.orderType,
      this.portMang,
      this.price,
      this.qty,
      this.symbol,
      this.typeCode,
      this.uCode,
      this.userCat,
      this.validity,
      this.validityCode,
      this.settType,
      this.webCode});

  factory ReskManagment.fromJson(Map<String, dynamic> json) => ReskManagment(
      accountID: json['AccountID'],
      clientID: json['ClientID'],
      compInit: json['CompInit'],
      custodyID: json['CustodyID'],
      includeFacil: json['IncludeFacil'],
      includeMargin: json['IncludeMargin'],
      mainClientID: json['MainClientID'],
      memberID: json['MemberID'],
      nIN: json['NIN'],
      orderID: json['OrderID'],
      orderType: json['OrderType'],
      portMang: json['PortMang'],
      price: json['Price'],
      qty: json['Qty'],
      symbol: json['Symbol'],
      typeCode: json['TypeCode'],
      uCode: json['UCode'],
      userCat: json['UserCat'],
      validity: json['Validity'],
      validityCode: json['ValidityCode'],
      settType: json['settType'],
      webCode: json['webCode']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AccountID'] = this.accountID;
    data['ClientID'] = this.clientID;
    data['CompInit'] = this.compInit;
    data['CustodyID'] = this.custodyID;
    data['IncludeFacil'] = this.includeFacil;
    data['IncludeMargin'] = this.includeMargin;
    data['MainClientID'] = this.mainClientID;
    data['MemberID'] = this.memberID;
    data['NIN'] = this.nIN;
    data['OrderID'] = this.orderID;
    data['OrderType'] = this.orderType;
    data['PortMang'] = this.portMang;
    data['Price'] = this.price;
    data['Qty'] = this.qty;
    data['Symbol'] = this.symbol;
    data['TypeCode'] = this.typeCode;
    data['UCode'] = this.uCode;
    data['UserCat'] = this.userCat;
    data['Validity'] = this.validity;
    data['ValidityCode'] = this.validityCode;
    data['settType'] = this.settType;
    data['webCode'] = this.webCode;
    return data;
  }
}
