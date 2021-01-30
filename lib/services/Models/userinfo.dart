class UserInfo {
  final String UserName;
  final String Password;
  final String MobileType;
  final String SessionID;
  final String UserIPAddress;
  final String TokenID;
  final String HdnKey;
  final String FingerPrintID;
  final String FingerPrintLevel;

  UserInfo(
      {this.UserName,
        this.Password,
        this.MobileType,
        this.SessionID,
        this.UserIPAddress,
        this.TokenID,
        this.HdnKey,
        this.FingerPrintID,
        this.FingerPrintLevel});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      UserName: json['UserName'],
      Password: json['Password'],
      MobileType: json['MobileType'],
      SessionID: json['SessionID'],
      UserIPAddress: json['UserIPAddress'],
      TokenID: json['TokenID'],
      HdnKey: json['HdnKey'],
      FingerPrintID: json['FingerPrintID'],
      FingerPrintLevel: json['FingerPrintLevel'],
    );
// final String FileName;
// final String FileType;
// final String FingerPrintID;
// final String FingerPrintLevel;
// final String HdnKey;
// final String IDNumber;
// final String MainClientId;
// final String MobileType;
// final String NewUser;
// final String OldPassword;
// final String Password;
// final String Password2;
// final String RegistrationId;
// final String SessionID;
// final String TokenID;
// final String TouchToken;
// final String TradingNo;
// final Map UploadFile;
// final String UserIPAddress;
// final String UserName;
// final String ValidityDate;
// final String WebCode;
// final String isAuthorizeOnly;
//
// UserInfo({this.FileName,this.FileType,this.FingerPrintID,this.FingerPrintLevel,
// this.HdnKey,this.IDNumber,this.MainClientId,this.MobileType,this.NewUser,this.OldPassword,
//   this.Password,this.Password2,this.RegistrationId,this.SessionID,this.TokenID,this.TouchToken,
//   this.TradingNo,this.UploadFile,this.UserIPAddress,this.UserName,this.ValidityDate,
//   this.WebCode,this.isAuthorizeOnly
// });
//
//
// factory UserInfo.fromJson(Map<String,dynamic>json){
//   return UserInfo(
//    FileName: json['FileName'],
//     FileType: json['FileType'],
//     FingerPrintID: json['FingerPrintID'],
//     FingerPrintLevel: json['FingerPrintLevel'],
//     HdnKey: json['HdnKey'],
//     IDNumber: json['IDNumber'],
//     MainClientId: json['MainClientId'],
//     MobileType: json['MobileType'],
//     NewUser: json['NewUser'],
//     OldPassword: json['OldPassword'],
//     Password:json['Password'],
//     Password2: json['Password2'],
//     RegistrationId: json['RegistrationId'],
//     SessionID: json['SessionID'],
//     TokenID: json['TokenID'],
//     TouchToken: json['TouchToken'],
//     TradingNo: json['TradingNo'],
//     UploadFile: json['UploadFile'],
//     UserIPAddress: json['UserIPAddress'],
//     UserName: json['UserName'],
//     ValidityDate: json['ValidityDate'],
//     WebCode: json['WebCode'],
//     isAuthorizeOnly:json['isAuthorizeOnly'],
//   );
//
//
//
  }
}