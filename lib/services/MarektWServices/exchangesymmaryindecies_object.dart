
import 'dart:convert';

ExchangeMArketIndexiesObject exchangeMarketObjectFromJson(String str) => ExchangeMArketIndexiesObject.fromJson(json.decode(str));

String exchangeMarketObjectToJson(ExchangeMArketIndexiesObject data) => json.encode(data.toJson());

class ExchangeMArketIndexiesObject {
  String currentValue;
  String exchangeID;
  String high;
  String lastUpdateTime;
  String low;
  String nameA;
  String nameE;
  var netChange;
  var netChangePerc;
  String previousValue;
  String sector;
  String turnOver;
  String volume;

  ExchangeMArketIndexiesObject(
      {this.currentValue,
        this.exchangeID,
        this.high,
        this.lastUpdateTime,
        this.low,
        this.nameA,
        this.nameE,
        this.netChange,
        this.netChangePerc,
        this.previousValue,
        this.sector,
        this.turnOver,
        this.volume});

 factory ExchangeMArketIndexiesObject.fromJson(Map<String, dynamic> json)=>ExchangeMArketIndexiesObject(
     currentValue : json['CurrentValue'],
     exchangeID : json['ExchangeID'],
     high : json['High'],
     lastUpdateTime : json['LastUpdateTime'],
     low : json['Low'],
     nameA : json['NameA'],
     nameE : json['NameE'],
     netChange : json['NetChange'],
     netChangePerc : json['NetChangePerc'],
     previousValue : json['PreviousValue'],
     sector : json['Sector'],
     turnOver : json['TurnOver'],
     volume : json['Volume'],
 );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CurrentValue'] = this.currentValue;
    data['ExchangeID'] = this.exchangeID;
    data['High'] = this.high;
    data['LastUpdateTime'] = this.lastUpdateTime;
    data['Low'] = this.low;
    data['NameA'] = this.nameA;
    data['NameE'] = this.nameE;
    data['NetChange'] = this.netChange;
    data['NetChangePerc'] = this.netChangePerc;
    data['PreviousValue'] = this.previousValue;
    data['Sector'] = this.sector;
    data['TurnOver'] = this.turnOver;
    data['Volume'] = this.volume;
    return data;
  }
}