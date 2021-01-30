class MarketObjectByID {
  String buyCashFlowPerc;
  String currentValue;
  String dayRange;
  String exchangeID;
  String exchangeNameA;
  String exchangeNameE;
  String exchangeType;
  String high;
  String lastUpdateTime;
  String low;
  String netChange;
  String netChangePerc;
  String statusCode;
  String symbolsDown;
  String symbolsTraded;
  String symbolsUP;
  String symbolsUnChange;
  String totalExecuted;
  String turnOver;
  String volume;
  int wk52High;
  int wk52Low;
  String wk52Range;

  MarketObjectByID(
      {this.buyCashFlowPerc,
      this.currentValue,
      this.dayRange,
      this.exchangeID,
      this.exchangeNameA,
      this.exchangeNameE,
      this.exchangeType,
      this.high,
      this.lastUpdateTime,
      this.low,
      this.netChange,
      this.netChangePerc,
      this.statusCode,
      this.symbolsDown,
      this.symbolsTraded,
      this.symbolsUP,
      this.symbolsUnChange,
      this.totalExecuted,
      this.turnOver,
      this.volume,
      this.wk52High,
      this.wk52Low,
      this.wk52Range});

  factory MarketObjectByID.fromJson(Map<String, dynamic> json) =>
      MarketObjectByID(
          buyCashFlowPerc: json['BuyCashFlowPerc'],
          currentValue: json['CurrentValue'],
          dayRange: json['DayRange'],
          exchangeID: json['ExchangeID'],
          exchangeNameA: json['ExchangeNameA'],
          exchangeNameE: json['ExchangeNameE'],
          exchangeType: json['ExchangeType'],
          high: json['High'],
          lastUpdateTime: json['LastUpdateTime'],
          low: json['Low'],
          netChange: json['NetChange'],
          netChangePerc: json['NetChangePerc'],
          statusCode: json['StatusCode'],
          symbolsDown: json['SymbolsDown'],
          symbolsTraded: json['SymbolsTraded'],
          symbolsUP: json['SymbolsUP'],
          symbolsUnChange: json['SymbolsUnChange'],
          totalExecuted: json['TotalExecuted'],
          turnOver: json['TurnOver'],
          volume: json['Volume'],
          wk52High: json['wk52High'],
          wk52Low: json['wk52Low'],
          wk52Range: json['wk52Range']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BuyCashFlowPerc'] = this.buyCashFlowPerc;
    data['CurrentValue'] = this.currentValue;
    data['DayRange'] = this.dayRange;
    data['ExchangeID'] = this.exchangeID;
    data['ExchangeNameA'] = this.exchangeNameA;
    data['ExchangeNameE'] = this.exchangeNameE;
    data['ExchangeType'] = this.exchangeType;
    data['High'] = this.high;
    data['LastUpdateTime'] = this.lastUpdateTime;
    data['Low'] = this.low;
    data['NetChange'] = this.netChange;
    data['NetChangePerc'] = this.netChangePerc;
    data['StatusCode'] = this.statusCode;
    data['SymbolsDown'] = this.symbolsDown;
    data['SymbolsTraded'] = this.symbolsTraded;
    data['SymbolsUP'] = this.symbolsUP;
    data['SymbolsUnChange'] = this.symbolsUnChange;
    data['TotalExecuted'] = this.totalExecuted;
    data['TurnOver'] = this.turnOver;
    data['Volume'] = this.volume;
    data['wk52High'] = this.wk52High;
    data['wk52Low'] = this.wk52Low;
    data['wk52Range'] = this.wk52Range;
    return data;
  }
}
