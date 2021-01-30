class ExchangeMArketChartObject {
  String avgPrice;
  String close;
  var date;
  String DateT;
  String high;
  String low;
  String name;
  String open;
  String value;
  String volume;

  ExchangeMArketChartObject.cons(this.DateT, this.close);
  ExchangeMArketChartObject.consvolume(this.close);

  ExchangeMArketChartObject(
      {this.avgPrice,
      this.close,
      this.date,
      this.DateT,
      this.high,
      this.low,
      this.name,
      this.open,
      this.value,
      this.volume});

  factory ExchangeMArketChartObject.fromJson(Map<String, dynamic> json) {
    return ExchangeMArketChartObject(
      avgPrice: json['AvgPrice'],
      close: json['Close'],
      date: json['Date'],
      DateT: json['DateT'],
      high: json['High'],
      low: json['Low'],
      name: json['Name'],
      open: json['Open'],
      value: json['Value'],
      volume: json['Volume'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AvgPrice'] = this.avgPrice;
    data['Close'] = this.close;
    data['Date'] = this.date;
    date['DateT'] = this.DateT;
    data['High'] = this.high;
    data['Low'] = this.low;
    data['Name'] = this.name;
    data['Open'] = this.open;
    data['Value'] = this.value;
    data['Volume'] = this.volume;
    return data;
  }
}
