class WathChart {
  String avgPrice;
  String close;
  String date;
  String high;
  String low;
  String name;
  String open;
  String value;
  String volume;

  WathChart(
      {this.avgPrice,
        this.close,
        this.date,
        this.high,
        this.low,
        this.name,
        this.open,
        this.value,
        this.volume});

  factory WathChart.fromJson(Map<String, dynamic> json) =>WathChart(
    avgPrice :json['AvgPrice'],
    close : json['Close'],
    date : json['Date'],
    high : json['High'],
    low : json['Low'],
    name : json['Name'],
    open : json['Open'],
    value : json['Value'],
    volume : json['Volume'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AvgPrice'] = this.avgPrice;
    data['Close'] = this.close;
    data['Date'] = this.date;
    data['High'] = this.high;
    data['Low'] = this.low;
    data['Name'] = this.name;
    data['Open'] = this.open;
    data['Value'] = this.value;
    data['Volume'] = this.volume;
    return data;
  }
}