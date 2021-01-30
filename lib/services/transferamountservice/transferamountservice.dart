class TransferAmoutObject {
  String aCCOUNTNAME;
  String aMOUNT;
  int aVILABLEBALANCE;
  String accountTo;
  String bANKACCGLNO;
  String bANKACCNO;
  String bANKCODE;
  String bANKNAME;
  String bankName;
  String branchName;
  String cHEQUEDATE;
  String cLIENTID;
  String cLIENTIDTO;
  String cURRENCY;
  String cURRENCYRATE;
  String cURRACCBANKID;
  String cURRACCCURRANCY;
  String dESCIPTION;
  String fROMACCID;
  String iBAN;
  String iNVESTACCBANKID;
  String iSREPRESINTITIVE;
  String isSameCurrency;
  String mAINCLIENTID;
  String pAYEENAME;
  String rEPRESINTITIVEID;
  String rEQUESTDATE;
  String rEQAPPROVALSTATUS;
  String rEQCONFIRM;
  String rEQID;
  String rEQTYPR;
  String sTATUS;
  String tOACCID;
  int tRANSFERABLEBALANCE;
  String transferType;
  String userCode;
  String wEBCODE;

  TransferAmoutObject(
      {this.aCCOUNTNAME,
      this.aMOUNT,
      this.aVILABLEBALANCE,
      this.accountTo,
      this.bANKACCGLNO,
      this.bANKACCNO,
      this.bANKCODE,
      this.bANKNAME,
      this.bankName,
      this.branchName,
      this.cHEQUEDATE,
      this.cLIENTID,
      this.cLIENTIDTO,
      this.cURRENCY,
      this.cURRENCYRATE,
      this.cURRACCBANKID,
      this.cURRACCCURRANCY,
      this.dESCIPTION,
      this.fROMACCID,
      this.iBAN,
      this.iNVESTACCBANKID,
      this.iSREPRESINTITIVE,
      this.isSameCurrency,
      this.mAINCLIENTID,
      this.pAYEENAME,
      this.rEPRESINTITIVEID,
      this.rEQUESTDATE,
      this.rEQAPPROVALSTATUS,
      this.rEQCONFIRM,
      this.rEQID,
      this.rEQTYPR,
      this.sTATUS,
      this.tOACCID,
      this.tRANSFERABLEBALANCE,
      this.transferType,
      this.userCode,
      this.wEBCODE});

  factory TransferAmoutObject.fromJson(Map<String, dynamic> json) =>
      TransferAmoutObject(
        aCCOUNTNAME: json['ACCOUNT_NAME'],
        aMOUNT: json['AMOUNT'],
        aVILABLEBALANCE: json['AVILABLE_BALANCE'],
        accountTo: json['AccountTo'],
        bANKACCGLNO: json['BANK_ACC_GL_NO'],
        bANKACCNO: json['BANK_ACC_NO'],
        bANKCODE: json['BANK_CODE'],
        bANKNAME: json['BANK_NAME'],
        bankName: json['BankName'],
        branchName: json['BranchName'],
        cHEQUEDATE: json['CHEQUE_DATE'],
        cLIENTID: json['CLIENT_ID'],
        cLIENTIDTO: json['CLIENT_ID_TO'],
        cURRENCY: json['CURRENCY'],
        cURRENCYRATE: json['CURRENCY_RATE'],
        cURRACCBANKID: json['CURR_ACC_BANK_ID'],
        cURRACCCURRANCY: json['CURR_ACC_CURRANCY'],
        dESCIPTION: json['DESCIPTION'],
        fROMACCID: json['FROM_ACC_ID'],
        iBAN: json['IBAN'],
        iNVESTACCBANKID: json['INVEST_ACC_BANK_ID'],
        iSREPRESINTITIVE: json['IS_REPRESINTITIVE'],
        isSameCurrency: json['Is_Same_Currency'],
        mAINCLIENTID: json['MAIN_CLIENT_ID'],
        pAYEENAME: json['PAYEE_NAME'],
        rEPRESINTITIVEID: json['REPRESINTITIVE_ID'],
        rEQUESTDATE: json['REQUEST_DATE'],
        rEQAPPROVALSTATUS: json['REQ_APPROVAL_STATUS'],
        rEQCONFIRM: json['REQ_CONFIRM'],
        rEQID: json['REQ_ID'],
        rEQTYPR: json['REQ_TYPR'],
        sTATUS: json['STATUS'],
        tOACCID: json['TO_ACC_ID'],
        tRANSFERABLEBALANCE: json['TRANSFERABLE_BALANCE'],
        transferType: json['TransferType'],
        userCode: json['UserCode'],
        wEBCODE: json['WEB_CODE'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ACCOUNT_NAME'] = this.aCCOUNTNAME;
    data['AMOUNT'] = this.aMOUNT;
    data['AVILABLE_BALANCE'] = this.aVILABLEBALANCE;
    data['AccountTo'] = this.accountTo;
    data['BANK_ACC_GL_NO'] = this.bANKACCGLNO;
    data['BANK_ACC_NO'] = this.bANKACCNO;
    data['BANK_CODE'] = this.bANKCODE;
    data['BANK_NAME'] = this.bANKNAME;
    data['BankName'] = this.bankName;
    data['BranchName'] = this.branchName;
    data['CHEQUE_DATE'] = this.cHEQUEDATE;
    data['CLIENT_ID'] = this.cLIENTID;
    data['CLIENT_ID_TO'] = this.cLIENTIDTO;
    data['CURRENCY'] = this.cURRENCY;
    data['CURRENCY_RATE'] = this.cURRENCYRATE;
    data['CURR_ACC_BANK_ID'] = this.cURRACCBANKID;
    data['CURR_ACC_CURRANCY'] = this.cURRACCCURRANCY;
    data['DESCIPTION'] = this.dESCIPTION;
    data['FROM_ACC_ID'] = this.fROMACCID;
    data['IBAN'] = this.iBAN;
    data['INVEST_ACC_BANK_ID'] = this.iNVESTACCBANKID;
    data['IS_REPRESINTITIVE'] = this.iSREPRESINTITIVE;
    data['Is_Same_Currency'] = this.isSameCurrency;
    data['MAIN_CLIENT_ID'] = this.mAINCLIENTID;
    data['PAYEE_NAME'] = this.pAYEENAME;
    data['REPRESINTITIVE_ID'] = this.rEPRESINTITIVEID;
    data['REQUEST_DATE'] = this.rEQUESTDATE;
    data['REQ_APPROVAL_STATUS'] = this.rEQAPPROVALSTATUS;
    data['REQ_CONFIRM'] = this.rEQCONFIRM;
    data['REQ_ID'] = this.rEQID;
    data['REQ_TYPR'] = this.rEQTYPR;
    data['STATUS'] = this.sTATUS;
    data['TO_ACC_ID'] = this.tOACCID;
    data['TRANSFERABLE_BALANCE'] = this.tRANSFERABLEBALANCE;
    data['TransferType'] = this.transferType;
    data['UserCode'] = this.userCode;
    data['WEB_CODE'] = this.wEBCODE;
    return data;
  }
}
