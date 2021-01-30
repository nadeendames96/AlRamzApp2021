class ChangePassword {
  String fileName;
  String fileType;
  String fingerPrintID;
  String fingerPrintLevel;
  String hdnKey;
  String iDNumber;
  String mainClientId;
  String mobileType;
  String newUser;
  String oldPassword;
  String password;
  String password2;
  String registrationId;
  String sessionID;
  String tokenID;
  String touchToken;
  String tradingNo;
  String userIPAddress;
  String userName;
  String validityDate;
  String versionNumber;
  String webCode;
  String isAuthorizeOnly;

  ChangePassword({this.fileName, this.fileType, this.fingerPrintID, this.fingerPrintLevel, this.hdnKey, this.iDNumber, this.mainClientId, this.mobileType, this.newUser, this.oldPassword, this.password, this.password2, this.registrationId, this.sessionID, this.tokenID, this.touchToken, this.tradingNo, this.userIPAddress, this.userName, this.validityDate, this.versionNumber, this.webCode, this.isAuthorizeOnly});

 factory ChangePassword.fromJson(Map<String, dynamic> json)=>ChangePassword(
    fileName : json['FileName'],
    fileType : json['FileType'],
    fingerPrintID : json['FingerPrintID'],
    fingerPrintLevel : json['FingerPrintLevel'],
    hdnKey : json['HdnKey'],
    iDNumber : json['IDNumber'],
    mainClientId : json['MainClientId'],
    mobileType : json['MobileType'],
    newUser : json['NewUser'],
    oldPassword : json['OldPassword'],
    password : json['Password'],
    password2 : json['Password2'],
    registrationId : json['RegistrationId'],
    sessionID : json['SessionID'],
    tokenID : json['TokenID'],
    touchToken : json['TouchToken'],
    tradingNo : json['TradingNo'],
    userIPAddress : json['UserIPAddress'],
    userName : json['UserName'],
    validityDate : json['ValidityDate'],
    versionNumber : json['VersionNumber'],
    webCode : json['WebCode'],
    isAuthorizeOnly : json['isAuthorizeOnly'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileName'] = this.fileName;
    data['FileType'] = this.fileType;
    data['FingerPrintID'] = this.fingerPrintID;
    data['FingerPrintLevel'] = this.fingerPrintLevel;
    data['HdnKey'] = this.hdnKey;
    data['IDNumber'] = this.iDNumber;
    data['MainClientId'] = this.mainClientId;
    data['MobileType'] = this.mobileType;
    data['NewUser'] = this.newUser;
    data['OldPassword'] = this.oldPassword;
    data['Password'] = this.password;
    data['Password2'] = this.password2;
    data['RegistrationId'] = this.registrationId;
    data['SessionID'] = this.sessionID;
    data['TokenID'] = this.tokenID;
    data['TouchToken'] = this.touchToken;
    data['TradingNo'] = this.tradingNo;
    data['UserIPAddress'] = this.userIPAddress;
    data['UserName'] = this.userName;
    data['ValidityDate'] = this.validityDate;
    data['VersionNumber'] = this.versionNumber;
    data['WebCode'] = this.webCode;
    data['isAuthorizeOnly'] = this.isAuthorizeOnly;
    return data;
  }
}


