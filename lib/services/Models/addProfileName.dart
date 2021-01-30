class WatchAddProfileObjects {
  String isDefault;
  String profileID;
  String profileName;
  String profileSettings;
  String userCode;

  WatchAddProfileObjects(
      {this.isDefault,
        this.profileID,
        this.profileName,
        this.profileSettings,
        this.userCode});

  factory WatchAddProfileObjects.fromJson(Map<String, dynamic> json) =>WatchAddProfileObjects(
    isDefault : json['Is_Default'],
    profileID : json['ProfileID'],
    profileName : json['ProfileName'],
    profileSettings : json['ProfileSettings'],
    userCode : json['UserCode'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Is_Default'] = this.isDefault;
    data['ProfileID'] = this.profileID;
    data['ProfileName'] = this.profileName;
    data['ProfileSettings'] = this.profileSettings;
    data['UserCode'] = this.userCode;
    return data;
  }
}