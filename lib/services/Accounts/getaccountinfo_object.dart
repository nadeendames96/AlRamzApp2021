class GetAccountInfo {
  String aLLOWDERIVTRADING;
  String accType;
  String accountDesc;
  String accountID;
  String cLBANKID;
  String cLBANKID2;
  String cURCODE;
  String clientID;
  String clientNameA;
  String clientNameE;
  String emailAddress;
  String exchange;
  String exchangeDESCA;
  String exchangeDESCE;
  String iSDEFAULTACC;
  String iSINTER;
  String iSIslamic;
  String iSMARGINACC;
  String iSSAMEDAY;
  String mainClientID;
  String mainClientNameA;
  String mainClientNameE;
  String mobileNO;
  String nIN;

  GetAccountInfo(
      {this.aLLOWDERIVTRADING,
        this.accType,
        this.accountDesc,
        this.accountID,
        this.cLBANKID,
        this.cLBANKID2,
        this.cURCODE,
        this.clientID,
        this.clientNameA,
        this.clientNameE,
        this.emailAddress,
        this.exchange,
        this.exchangeDESCA,
        this.exchangeDESCE,
        this.iSDEFAULTACC,
        this.iSINTER,
        this.iSIslamic,
        this.iSMARGINACC,
        this.iSSAMEDAY,
        this.mainClientID,
        this.mainClientNameA,
        this.mainClientNameE,
        this.mobileNO,
        this.nIN});

 factory GetAccountInfo.fromJson(Map<String, dynamic> json) =>GetAccountInfo(
    aLLOWDERIVTRADING : json['ALLOW_DERIV_TRADING'],
    accType : json['AccType'],
    accountDesc : json['AccountDesc'],
    accountID : json['AccountID'],
    cLBANKID : json['CL_BANK_ID'],
    cLBANKID2 : json['CL_BANK_ID2'],
    cURCODE : json['CUR_CODE'],
    clientID : json['ClientID'],
    clientNameA : json['ClientNameA'],
    clientNameE : json['ClientNameE'],
    emailAddress : json['Email_Address'],
    exchange : json['Exchange'],
    exchangeDESCA : json['Exchange_DESC_A'],
    exchangeDESCE : json['Exchange_DESC_E'],
    iSDEFAULTACC : json['IS_DEFAULT_ACC'],
    iSINTER : json['IS_INTER'],
    iSIslamic : json['IS_Islamic'],
    iSMARGINACC : json['IS_MARGIN_ACC'],
    iSSAMEDAY : json['IS_SAMEDAY'],
    mainClientID : json['MainClientID'],
    mainClientNameA : json['MainClientNameA'],
    mainClientNameE : json['MainClientNameE'],
    mobileNO : json['Mobile_NO'],
    nIN : json['NIN'],
 );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ALLOW_DERIV_TRADING'] = this.aLLOWDERIVTRADING;
    data['AccType'] = this.accType;
    data['AccountDesc'] = this.accountDesc;
    data['AccountID'] = this.accountID;
    data['CL_BANK_ID'] = this.cLBANKID;
    data['CL_BANK_ID2'] = this.cLBANKID2;
    data['CUR_CODE'] = this.cURCODE;
    data['ClientID'] = this.clientID;
    data['ClientNameA'] = this.clientNameA;
    data['ClientNameE'] = this.clientNameE;
    data['Email_Address'] = this.emailAddress;
    data['Exchange'] = this.exchange;
    data['Exchange_DESC_A'] = this.exchangeDESCA;
    data['Exchange_DESC_E'] = this.exchangeDESCE;
    data['IS_DEFAULT_ACC'] = this.iSDEFAULTACC;
    data['IS_INTER'] = this.iSINTER;
    data['IS_Islamic'] = this.iSIslamic;
    data['IS_MARGIN_ACC'] = this.iSMARGINACC;
    data['IS_SAMEDAY'] = this.iSSAMEDAY;
    data['MainClientID'] = this.mainClientID;
    data['MainClientNameA'] = this.mainClientNameA;
    data['MainClientNameE'] = this.mainClientNameE;
    data['Mobile_NO'] = this.mobileNO;
    data['NIN'] = this.nIN;
    return data;
  }
}