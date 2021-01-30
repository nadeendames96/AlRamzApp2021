class IndexObject {
  String exchangeID;
  String nameE;
  String nameA;
  String currentValue;
  String previousValue;
  String netChange;
  String netChangePerc;
  String high;
  String low;
  String sector;
  String turnOver;
  String volume;
  String lastUpdateTime;

  IndexObject(
      {this.exchangeID,
      this.nameE,
      this.nameA,
      this.currentValue,
      this.previousValue,
      this.netChange,
      this.netChangePerc,
      this.high,
      this.low,
      this.sector,
      this.turnOver,
      this.volume,
      this.lastUpdateTime});

  IndexObject.fromJson(Map<String, dynamic> json) {
    exchangeID = json['ExchangeID'];
    nameE = json['NameE'];
    nameA = json['NameA'];
    currentValue = json['CurrentValue'];
    previousValue = json['PreviousValue'];
    netChange = json['NetChange'];
    netChangePerc = json['NetChangePerc'];
    high = json['High'];
    low = json['Low'];
    sector = json['Sector'];
    turnOver = json['TurnOver'];
    volume = json['Volume'];
    lastUpdateTime = json['LastUpdateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ExchangeID'] = this.exchangeID;
    data['NameE'] = this.nameE;
    data['NameA'] = this.nameA;
    data['CurrentValue'] = this.currentValue;
    data['PreviousValue'] = this.previousValue;
    data['NetChange'] = this.netChange;
    data['NetChangePerc'] = this.netChangePerc;
    data['High'] = this.high;
    data['Low'] = this.low;
    data['Sector'] = this.sector;
    data['TurnOver'] = this.turnOver;
    data['Volume'] = this.volume;
    data['LastUpdateTime'] = this.lastUpdateTime;
    return data;
  }
}
