
class GetSymbolTradesObject {
  String exchange;
  String lastUpdateTime;
  String marketType;
  String netChange;
  String netChgPerc;
  String precision;
  String price;
  String sellBuyFlag;
  String symbol;
  String symbolA;
  String symbolE;
  String tradeTime;
  String volume;

  GetSymbolTradesObject(
      {this.exchange,
        this.lastUpdateTime,
        this.marketType,
        this.netChange,
        this.netChgPerc,
        this.precision,
        this.price,
        this.sellBuyFlag,
        this.symbol,
        this.symbolA,
        this.symbolE,
        this.tradeTime,
        this.volume});

 factory GetSymbolTradesObject.fromJson(Map<String, dynamic> json) =>GetSymbolTradesObject(
    exchange : json['Exchange'],
    lastUpdateTime : json['LastUpdateTime'],
    marketType : json['MarketType'],
    netChange : json['NetChange'],
    netChgPerc : json['NetChgPerc'],
    precision : json['Precision'],
    price : json['Price'],
    sellBuyFlag : json['SellBuyFlag'],
    symbol : json['Symbol'],
    symbolA : json['SymbolA'],
    symbolE : json['SymbolE'],
    tradeTime : json['TradeTime'],
    volume : json['Volume'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Exchange'] = this.exchange;
    data['LastUpdateTime'] = this.lastUpdateTime;
    data['MarketType'] = this.marketType;
    data['NetChange'] = this.netChange;
    data['NetChgPerc'] = this.netChgPerc;
    data['Precision'] = this.precision;
    data['Price'] = this.price;
    data['SellBuyFlag'] = this.sellBuyFlag;
    data['Symbol'] = this.symbol;
    data['SymbolA'] = this.symbolA;
    data['SymbolE'] = this.symbolE;
    data['TradeTime'] = this.tradeTime;
    data['Volume'] = this.volume;
    return data;
  }
}