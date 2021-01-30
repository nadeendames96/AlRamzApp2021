class AccountsPortofioloObject {
  var cOMPANYSHORTA;
  var cOMPANYSHORTE;
  var cUSTODIANA;
  var cUSTODIANE;
  var clientID;
  var companyNameA;
  var companyNameE;
  var curCode;
  var currDiff;
  var custodianId;
  var ePrice;
  var exchange;
  var locBookedPsValue;
  var locNValue;
  var nValue;
  var pCost;
  var pPerc;
  var pProf;
  var prClosePrice;
  var prPriceDate;
  var precision;
  var profit;
  var psValue;
  var qTYSETTLED;
  var qTYT0;
  var qTYT1;
  var qTYT2;
  var qTYUNSETTLED;
  var qty;
  var rate;
  var sectorA;
  var sectorE;
  String symbol;
  var totalExpectedProfitLoss;
  var totalExpectedSellComm;
  var totalMarketValue;
  var totalNetProfitLoss;
  var totalRealizedProfitLoss;
  var typeA;
  var typeE;

  AccountsPortofioloObject.cons({this.pCost,this.symbol,text});
  AccountsPortofioloObject(
      {this.cOMPANYSHORTA,
        this.cOMPANYSHORTE,
        this.cUSTODIANA,
        this.cUSTODIANE,
        this.clientID,
        this.companyNameA,
        this.companyNameE,
        this.curCode,
        this.currDiff,
        this.custodianId,
        this.ePrice,
        this.exchange,
        this.locBookedPsValue,
        this.locNValue,
        this.nValue,
        this.pCost,
        this.pPerc,
        this.pProf,
        this.prClosePrice,
        this.prPriceDate,
        this.precision,
        this.profit,
        this.psValue,
        this.qTYSETTLED,
        this.qTYT0,
        this.qTYT1,
        this.qTYT2,
        this.qTYUNSETTLED,
        this.qty,
        this.rate,
        this.sectorA,
        this.sectorE,
        this.symbol,
        this.totalExpectedProfitLoss,
        this.totalExpectedSellComm,
        this.totalMarketValue,
        this.totalNetProfitLoss,
        this.totalRealizedProfitLoss,
        this.typeA,
        this.typeE});

 factory AccountsPortofioloObject.fromJson(Map<String, dynamic> json)=>AccountsPortofioloObject(
    cOMPANYSHORTA : json['COMPANY_SHORT_A'],
    cOMPANYSHORTE : json['COMPANY_SHORT_E'],
    cUSTODIANA : json['CUSTODIAN_A'],
    cUSTODIANE : json['CUSTODIAN_E'],
    clientID : json['ClientID'],
    companyNameA : json['CompanyNameA'],
    companyNameE : json['CompanyNameE'],
    curCode : json['CurCode'],
    currDiff : json['CurrDiff'],
    custodianId : json['CustodianId'],
    ePrice : json['EPrice'],
    exchange : json['Exchange'],
    locBookedPsValue : json['LocBookedPsValue'],
    locNValue : json['LocNValue'],
    nValue : json['NValue'],
    pCost : json['PCost'],
    pPerc : json['PPerc'],
    pProf : json['PProf'],
    prClosePrice : json['PrClosePrice'],
    prPriceDate : json['PrPriceDate'],
    precision : json['Precision'],
    profit : json['Profit'],
    psValue : json['PsValue'],
    qTYSETTLED : json['QTY_SETTLED'],
    qTYT0 : json['QTY_T0'],
    qTYT1 : json['QTY_T1'],
    qTYT2 : json['QTY_T2'],
    qTYUNSETTLED :json['QTY_UNSETTLED'],
    qty : json['Qty'],
    rate : json['Rate'],
    sectorA : json['SectorA'],
    sectorE : json['SectorE'],
    symbol : json['Symbol'],
    totalExpectedProfitLoss : json['Total_Expected_Profit_Loss'],
    totalExpectedSellComm : json['Total_Expected_Sell_Comm'],
    totalMarketValue : json['Total_Market_Value'],
    totalNetProfitLoss : json['Total_Net_Profit_Loss'],
    totalRealizedProfitLoss : json['Total_Realized_Profit_Loss'],
    typeA : json['TypeA'],
    typeE : json['TypeE'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['COMPANY_SHORT_A'] = this.cOMPANYSHORTA;
    data['COMPANY_SHORT_E'] = this.cOMPANYSHORTE;
    data['CUSTODIAN_A'] = this.cUSTODIANA;
    data['CUSTODIAN_E'] = this.cUSTODIANE;
    data['ClientID'] = this.clientID;
    data['CompanyNameA'] = this.companyNameA;
    data['CompanyNameE'] = this.companyNameE;
    data['CurCode'] = this.curCode;
    data['CurrDiff'] = this.currDiff;
    data['CustodianId'] = this.custodianId;
    data['EPrice'] = this.ePrice;
    data['Exchange'] = this.exchange;
    data['LocBookedPsValue'] = this.locBookedPsValue;
    data['LocNValue'] = this.locNValue;
    data['NValue'] = this.nValue;
    data['PCost'] = this.pCost;
    data['PPerc'] = this.pPerc;
    data['PProf'] = this.pProf;
    data['PrClosePrice'] = this.prClosePrice;
    data['PrPriceDate'] = this.prPriceDate;
    data['Precision'] = this.precision;
    data['Profit'] = this.profit;
    data['PsValue'] = this.psValue;
    data['QTY_SETTLED'] = this.qTYSETTLED;
    data['QTY_T0'] = this.qTYT0;
    data['QTY_T1'] = this.qTYT1;
    data['QTY_T2'] = this.qTYT2;
    data['QTY_UNSETTLED'] = this.qTYUNSETTLED;
    data['Qty'] = this.qty;
    data['Rate'] = this.rate;
    data['SectorA'] = this.sectorA;
    data['SectorE'] = this.sectorE;
    data['Symbol'] = this.symbol;
    data['Total_Expected_Profit_Loss'] = this.totalExpectedProfitLoss;
    data['Total_Expected_Sell_Comm'] = this.totalExpectedSellComm;
    data['Total_Market_Value'] = this.totalMarketValue;
    data['Total_Net_Profit_Loss'] = this.totalNetProfitLoss;
    data['Total_Realized_Profit_Loss'] = this.totalRealizedProfitLoss;
    data['TypeA'] = this.typeA;
    data['TypeE'] = this.typeE;
    return data;
  }
}