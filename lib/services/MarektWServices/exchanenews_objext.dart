class ExchangesMarketsNewsObject {
  String marketID;
  String newsDate;
  String newsDescA;
  String newsDescE;
  String notifyID;
  String symbol;

  ExchangesMarketsNewsObject(
      {this.marketID,
        this.newsDate,
        this.newsDescA,
        this.newsDescE,
        this.notifyID,
        this.symbol});

 factory ExchangesMarketsNewsObject.fromJson(Map<String, dynamic> json)=>ExchangesMarketsNewsObject(
    marketID : json['MarketID'],
    newsDate : json['NewsDate'],
    newsDescA :json['NewsDescA'],
    newsDescE : json['NewsDescE'],
    notifyID : json['NotifyID'],
    symbol : json['Symbol'],
  );


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MarketID'] = this.marketID;
    data['NewsDate'] = this.newsDate;
    data['NewsDescA'] = this.newsDescA;
    data['NewsDescE'] = this.newsDescE;
    data['NotifyID'] = this.notifyID;
    data['Symbol'] = this.symbol;
    return data;
  }
}