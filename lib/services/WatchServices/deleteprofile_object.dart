class DeleteProfileObject {
  String profileID;
  List<String> symbols;
  String webCode;

  DeleteProfileObject({this.profileID, this.symbols, this.webCode});

  factory DeleteProfileObject.fromJson(Map<String, dynamic> json)=>DeleteProfileObject(
    profileID : json['ProfileID'],
    symbols : json['Symbols'].cast<String>(),
    webCode : json['WebCode'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProfileID'] = this.profileID;
    data['Symbols'] = this.symbols;
    data['WebCode'] = this.webCode;
    return data;
  }
}