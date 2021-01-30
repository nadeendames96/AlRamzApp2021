class WatchGetCompaniesLookups {
  String companyA;
  String companyE;
  String currCode;
  String exchange;
  String iSDERIVATIVE;
  String isFund;
  String isinCode;
  String marketType;
  String precision;
  String symbol;
  String symbolCompanyA;
  String symbolCompanyDesc;
  String symbolCompanyE;
  String symbolID;

  WatchGetCompaniesLookups(
      {this.companyA,
        this.companyE,
        this.currCode,
        this.exchange,
        this.iSDERIVATIVE,
        this.isFund,
        this.isinCode,
        this.marketType,
        this.precision,
        this.symbol,
        this.symbolCompanyA,
        this.symbolCompanyDesc,
        this.symbolCompanyE,
        this.symbolID});

  factory WatchGetCompaniesLookups.fromJson(Map<String, dynamic> json)=> WatchGetCompaniesLookups(
    companyA : json['CompanyA'],
    companyE : json['CompanyE'],
    currCode : json['CurrCode'],
    exchange : json['Exchange'],
    iSDERIVATIVE : json['IS_DERIVATIVE'],
    isFund : json['IsFund'],
    isinCode : json['IsinCode'],
    marketType : json['MarketType'],
    precision : json['Precision'],
    symbol : json['Symbol'],
    symbolCompanyA : json['SymbolCompanyA'],
    symbolCompanyDesc : json['SymbolCompanyDesc'],
    symbolCompanyE : json['SymbolCompanyE'],
    symbolID : json['SymbolID'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyA'] = this.companyA;
    data['CompanyE'] = this.companyE;
    data['CurrCode'] = this.currCode;
    data['Exchange'] = this.exchange;
    data['IS_DERIVATIVE'] = this.iSDERIVATIVE;
    data['IsFund'] = this.isFund;
    data['IsinCode'] = this.isinCode;
    data['MarketType'] = this.marketType;
    data['Precision'] = this.precision;
    data['Symbol'] = this.symbol;
    data['SymbolCompanyA'] = this.symbolCompanyA;
    data['SymbolCompanyDesc'] = this.symbolCompanyDesc;
    data['SymbolCompanyE'] = this.symbolCompanyE;
    data['SymbolID'] = this.symbolID;
    return data;
  }
}