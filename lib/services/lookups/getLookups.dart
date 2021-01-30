class getLookupsObject {
  String descA;
  String descE;
  String iD;
  String type;

  getLookupsObject({this.descA, this.descE, this.iD, this.type});

 factory getLookupsObject.fromJson(Map<String, dynamic> json) =>getLookupsObject(
    descA : json['DescA'],
    descE : json['DescE'],
    iD : json['ID'],
    type : json['Type'],
 );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DescA'] = this.descA;
    data['DescE'] = this.descE;
    data['ID'] = this.iD;
    data['Type'] = this.type;
    return data;
  }
}