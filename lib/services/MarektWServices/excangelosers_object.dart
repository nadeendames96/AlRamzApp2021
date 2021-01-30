class ExchnageLossersMarketObject {
  String avgPrice;
  String bidPrice;
  String bidVolume;
  String buyCashFlowPerc;
  String closePrice;
  String dayRange;
  String exchange;
  String executed;
  String highPrice;
  String indicator;
  String lastTradePrice;
  String lastTradeVolume;
  String lastUpdateTime;
  String losses;
  String lowPrice;
  String mBO;
  String mBOF;
  String mBP;
  String mBPF;
  String marketType;
  String maxPrice;
  String minPrice;
  String netChange;
  String netChangePerc;
  String offerPrice;
  String offerVolume;
  String openPrice;
  String pE;
  String precision;
  String sNameAr;
  String sNameEn;
  String sectorCode;
  String symbol;
  String symbolCapital;
  String symbolID;
  String symbolNameA;
  String symbolNameE;
  String topPrice;
  String totalBidVolume;
  String totalOfferVolume;
  String totalValue;
  String totalVolume;
  String wk52High;
  String wk52Low;
  String wk52Range;

  ExchnageLossersMarketObject(
      {this.avgPrice,
      this.bidPrice,
      this.bidVolume,
      this.buyCashFlowPerc,
      this.closePrice,
      this.dayRange,
      this.exchange,
      this.executed,
      this.highPrice,
      this.indicator,
      this.lastTradePrice,
      this.lastTradeVolume,
      this.lastUpdateTime,
      this.losses,
      this.lowPrice,
      this.mBO,
      this.mBOF,
      this.mBP,
      this.mBPF,
      this.marketType,
      this.maxPrice,
      this.minPrice,
      this.netChange,
      this.netChangePerc,
      this.offerPrice,
      this.offerVolume,
      this.openPrice,
      this.pE,
      this.precision,
      this.sNameAr,
      this.sNameEn,
      this.sectorCode,
      this.symbol,
      this.symbolCapital,
      this.symbolID,
      this.symbolNameA,
      this.symbolNameE,
      this.topPrice,
      this.totalBidVolume,
      this.totalOfferVolume,
      this.totalValue,
      this.totalVolume,
      this.wk52High,
      this.wk52Low,
      this.wk52Range});

  factory ExchnageLossersMarketObject.fromJson(Map<String, dynamic> json) =>
      ExchnageLossersMarketObject(
          avgPrice: json['AvgPrice'],
          bidPrice: json['BidPrice'],
          bidVolume: json['BidVolume'],
          buyCashFlowPerc: json['BuyCashFlowPerc'],
          closePrice: json['ClosePrice'],
          dayRange: json['DayRange'],
          exchange: json['Exchange'],
          executed: json['Executed'],
          highPrice: json['HighPrice'],
          indicator: json['Indicator'],
          lastTradePrice: json['LastTradePrice'],
          lastTradeVolume: json['LastTradeVolume'],
          lastUpdateTime: json['LastUpdateTime'],
          losses: json['Losses'],
          lowPrice: json['LowPrice'],
          mBO: json['MBO'],
          mBOF: json['MBO_F'],
          mBP: json['MBP'],
          mBPF: json['MBP_F'],
          marketType: json['MarketType'],
          maxPrice: json['MaxPrice'],
          minPrice: json['MinPrice'],
          netChange: json['NetChange'],
          netChangePerc: json['NetChangePerc'],
          offerPrice: json['OfferPrice'],
          offerVolume: json['OfferVolume'],
          openPrice: json['OpenPrice'],
          pE: json['PE'],
          precision: json['Precision'],
          sNameAr: json['SNameAr'],
          sNameEn: json['SNameEn'],
          sectorCode: json['SectorCode'],
          symbol: json['Symbol'],
          symbolCapital: json['SymbolCapital'],
          symbolID: json['SymbolID'],
          symbolNameA: json['SymbolNameA'],
          symbolNameE: json['SymbolNameE'],
          topPrice: json['TopPrice'],
          totalBidVolume: json['TotalBidVolume'],
          totalOfferVolume: json['TotalOfferVolume'],
          totalValue: json['TotalValue'],
          totalVolume: json['TotalVolume'],
          wk52High: json['wk52High'],
          wk52Low: json['wk52Low'],
          wk52Range: json['wk52Range']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AvgPrice'] = this.avgPrice;
    data['BidPrice'] = this.bidPrice;
    data['BidVolume'] = this.bidVolume;
    data['BuyCashFlowPerc'] = this.buyCashFlowPerc;
    data['ClosePrice'] = this.closePrice;
    data['DayRange'] = this.dayRange;
    data['Exchange'] = this.exchange;
    data['Executed'] = this.executed;
    data['HighPrice'] = this.highPrice;
    data['Indicator'] = this.indicator;
    data['LastTradePrice'] = this.lastTradePrice;
    data['LastTradeVolume'] = this.lastTradeVolume;
    data['LastUpdateTime'] = this.lastUpdateTime;
    data['Losses'] = this.losses;
    data['LowPrice'] = this.lowPrice;
    data['MBO'] = this.mBO;
    data['MBO_F'] = this.mBOF;
    data['MBP'] = this.mBP;
    data['MBP_F'] = this.mBPF;
    data['MarketType'] = this.marketType;
    data['MaxPrice'] = this.maxPrice;
    data['MinPrice'] = this.minPrice;
    data['NetChange'] = this.netChange;
    data['NetChangePerc'] = this.netChangePerc;
    data['OfferPrice'] = this.offerPrice;
    data['OfferVolume'] = this.offerVolume;
    data['OpenPrice'] = this.openPrice;
    data['PE'] = this.pE;
    data['Precision'] = this.precision;
    data['SNameAr'] = this.sNameAr;
    data['SNameEn'] = this.sNameEn;
    data['SectorCode'] = this.sectorCode;
    data['Symbol'] = this.symbol;
    data['SymbolCapital'] = this.symbolCapital;
    data['SymbolID'] = this.symbolID;
    data['SymbolNameA'] = this.symbolNameA;
    data['SymbolNameE'] = this.symbolNameE;
    data['TopPrice'] = this.topPrice;
    data['TotalBidVolume'] = this.totalBidVolume;
    data['TotalOfferVolume'] = this.totalOfferVolume;
    data['TotalValue'] = this.totalValue;
    data['TotalVolume'] = this.totalVolume;
    data['wk52High'] = this.wk52High;
    data['wk52Low'] = this.wk52Low;
    data['wk52Range'] = this.wk52Range;
    return data;
  }
}
