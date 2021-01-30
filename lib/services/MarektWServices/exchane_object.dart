import 'dart:convert';

ExchangeMarketObject exchangeMarketObjectFromJson(String str) =>
    ExchangeMarketObject.fromJson(json.decode(str));

String exchangeMarketObjectToJson(ExchangeMarketObject data) =>
    json.encode(data.toJson());

class ExchangeMarketObject {
  ExchangeMarketObject({
    this.buyCashFlowPerc,
    this.currentValue,
    this.exchangeId,
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
    this.symbolsUp,
    this.symbolsUnChange,
    this.totalExecuted,
    this.turnOver,
    this.volume,
  });
  ExchangeMarketObject.cons(
      {this.symbolsUp, this.symbolsDown, this.symbolsUnChange});

  String buyCashFlowPerc;
  String currentValue;
  String exchangeId;
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
  String symbolsUp;
  String symbolsUnChange;
  String totalExecuted;
  String turnOver;
  String volume;

  factory ExchangeMarketObject.fromJson(Map<String, dynamic> json) =>
      ExchangeMarketObject(
        buyCashFlowPerc: json["BuyCashFlowPerc"],
        currentValue: json["CurrentValue"],
        exchangeId: json["ExchangeID"],
        exchangeNameA: json["ExchangeNameA"],
        exchangeNameE: json["ExchangeNameE"],
        exchangeType: json["ExchangeType"],
        high: json["High"],
        lastUpdateTime: json["LastUpdateTime"],
        low: json["Low"],
        netChange: json["NetChange"],
        netChangePerc: json["NetChangePerc"],
        statusCode: json["StatusCode"],
        symbolsDown: json["SymbolsDown"],
        symbolsTraded: json["SymbolsTraded"],
        symbolsUp: json["SymbolsUP"],
        symbolsUnChange: json["SymbolsUnChange"],
        totalExecuted: json["TotalExecuted"],
        turnOver: json["TurnOver"],
        volume: json["Volume"],
      );

  Map<String, dynamic> toJson() => {
        "BuyCashFlowPerc": buyCashFlowPerc,
        "CurrentValue": currentValue,
        "ExchangeID": exchangeId,
        "ExchangeNameA": exchangeNameA,
        "ExchangeNameE": exchangeNameE,
        "ExchangeType": exchangeType,
        "High": high,
        "LastUpdateTime": lastUpdateTime,
        "Low": low,
        "NetChange": netChange,
        "NetChangePerc": netChangePerc,
        "StatusCode": statusCode,
        "SymbolsDown": symbolsDown,
        "SymbolsTraded": symbolsTraded,
        "SymbolsUP": symbolsUp,
        "SymbolsUnChange": symbolsUnChange,
        "TotalExecuted": totalExecuted,
        "TurnOver": turnOver,
        "Volume": volume,
      };

  @override
  String toString() {
    return 'ExchangeMarketObject{buyCashFlowPerc: $buyCashFlowPerc, currentValue: $currentValue, exchangeId: $exchangeId, exchangeNameA: $exchangeNameA, exchangeNameE: $exchangeNameE, exchangeType: $exchangeType, high: $high, lastUpdateTime: $lastUpdateTime, low: $low, netChange: $netChange, netChangePerc: $netChangePerc, statusCode: $statusCode, symbolsDown: $symbolsDown, symbolsTraded: $symbolsTraded, symbolsUp: $symbolsUp, symbolsUnChange: $symbolsUnChange, totalExecuted: $totalExecuted, turnOver: $turnOver, volume: $volume}';
  }
}
