class ExchangeObjectSignalR {
  String exchangeID;
  String nameA;
  String nameE;
  String currentValue;
  String volume;
  String turnOver;
  String totalExecuted;
  String netChange;
  String netChangePerc;
  String high;
  String low;
  String statusCode;
  String exchangeType;
  String symbolsTraded;
  String symbolsUP;
  String symbolsDown;
  String symbolsUnChange;
  String buyCashFlowPerc;
  String netMoneyFlow;
  String lastUpdateTime;
  String dayRange;
  String wk52Range;
  var wk52High;
  var wk52Low;

  ExchangeObjectSignalR(
      {this.exchangeID,
      this.nameA,
      this.nameE,
      this.currentValue,
      this.volume,
      this.turnOver,
      this.totalExecuted,
      this.netChange,
      this.netChangePerc,
      this.high,
      this.low,
      this.statusCode,
      this.exchangeType,
      this.symbolsTraded,
      this.symbolsUP,
      this.symbolsDown,
      this.symbolsUnChange,
      this.buyCashFlowPerc,
      this.netMoneyFlow,
      this.lastUpdateTime,
      this.dayRange,
      this.wk52Range,
      this.wk52High,
      this.wk52Low});

  factory ExchangeObjectSignalR.fromJson(Map<String, dynamic> json) =>
      ExchangeObjectSignalR(
          exchangeID: json['ExchangeID'],
          nameA: json['NameA'],
          nameE: json['NameE'],
          currentValue: json['CurrentValue'],
          volume: json['Volume'],
          turnOver: json['TurnOver'],
          totalExecuted: json['TotalExecuted'],
          netChange: json['NetChange'],
          netChangePerc: json['NetChangePerc'],
          high: json['High'],
          low: json['Low'],
          statusCode: json['StatusCode'],
          exchangeType: json['ExchangeType'],
          symbolsTraded: json['SymbolsTraded'],
          symbolsUP: json['SymbolsUP'],
          symbolsDown: json['SymbolsDown'],
          symbolsUnChange: json['SymbolsUnChange'],
          buyCashFlowPerc: json['BuyCashFlowPerc'],
          netMoneyFlow: json['NetMoneyFlow'],
          lastUpdateTime: json['LastUpdateTime'],
          dayRange: json['DayRange'],
          wk52Range: json['wk52Range'],
          wk52High: json['wk52High'],
          wk52Low: json['wk52Low']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ExchangeID'] = this.exchangeID;
    data['ExchangeNameA'] = this.nameA;
    data['ExchangeNameE'] = this.nameE;
    data['CurrentValue'] = this.currentValue;
    data['Volume'] = this.volume;
    data['TurnOver'] = this.turnOver;
    data['TotalExecuted'] = this.totalExecuted;
    data['NetChange'] = this.netChange;
    data['NetChangePerc'] = this.netChangePerc;
    data['High'] = this.high;
    data['Low'] = this.low;
    data['StatusCode'] = this.statusCode;
    data['ExchangeType'] = this.exchangeType;
    data['SymbolsTraded'] = this.symbolsTraded;
    data['SymbolsUP'] = this.symbolsUP;
    data['SymbolsDown'] = this.symbolsDown;
    data['SymbolsUnChange'] = this.symbolsUnChange;
    data['BuyCashFlowPerc'] = this.buyCashFlowPerc;
    data['NetMoneyFlow'] = this.netMoneyFlow;
    data['LastUpdateTime'] = this.lastUpdateTime;
    data['DayRange'] = this.dayRange;
    data['wk52Range'] = this.wk52Range;
    data['wk52High'] = this.wk52High;
    data['wk52Low'] = this.wk52Low;
    return data;
  }
}
