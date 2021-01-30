class WatchAddSymbolProfileObjects {
  String accumlossFlags;
  String avgPrice;
  String bidPrice;
  String bidVolume;
  String buyCashFlowPerc;
  String closePrice;
  String dayRange;
  String depthBuyOrder;
  String depthByPrice;
  String ePS;
  String exchange;
  String executed;
  String highPrice;
  String indicator;
  String lastTradePrice;
  String lastTradeVolume;
  String losses;
  String lowPrice;
  String marketType;
  String maxPrice;
  String minPrice;
  String netChange;
  String netChangePerc;
  String offerPrice;
  String offerVolume;
  String openPrice;
  String pE;
  String pivotPoint;
  String precision;
  String profileID;
  String resistance1;
  String resistance2;
  String sectorA;
  String sectorCode;
  String sectorE;
  String support1;
  String support2;
  String symbol;
  String symbolCapital;
  String symbolNameA;
  String symbolNameArabic;
  String symbolNameE;
  String symbolNameEnglish;
  String topPrice;
  String totalBidVolume;
  String totalOfferVolume;
  String totalValue;
  String totalVolume;
  String updateDateTime;
  String recid;
  String wk52High;
  String wk52Low;
  String wk52Range;

  WatchAddSymbolProfileObjects(
      {this.accumlossFlags,
        this.avgPrice,
        this.bidPrice,
        this.bidVolume,
        this.buyCashFlowPerc,
        this.closePrice,
        this.dayRange,
        this.depthBuyOrder,
        this.depthByPrice,
        this.ePS,
        this.exchange,
        this.executed,
        this.highPrice,
        this.indicator,
        this.lastTradePrice,
        this.lastTradeVolume,
        this.losses,
        this.lowPrice,
        this.marketType,
        this.maxPrice,
        this.minPrice,
        this.netChange,
        this.netChangePerc,
        this.offerPrice,
        this.offerVolume,
        this.openPrice,
        this.pE,
        this.pivotPoint,
        this.precision,
        this.profileID,
        this.resistance1,
        this.resistance2,
        this.sectorA,
        this.sectorCode,
        this.sectorE,
        this.support1,
        this.support2,
        this.symbol,
        this.symbolCapital,
        this.symbolNameA,
        this.symbolNameArabic,
        this.symbolNameE,
        this.symbolNameEnglish,
        this.topPrice,
        this.totalBidVolume,
        this.totalOfferVolume,
        this.totalValue,
        this.totalVolume,
        this.updateDateTime,
        this.recid,
        this.wk52High,
        this.wk52Low,
        this.wk52Range});

  WatchAddSymbolProfileObjects.fromJson(Map<String, dynamic> json) {
    accumlossFlags = json['AccumlossFlags'];
    avgPrice = json['AvgPrice'];
    bidPrice = json['BidPrice'];
    bidVolume = json['BidVolume'];
    buyCashFlowPerc = json['BuyCashFlowPerc'];
    closePrice = json['ClosePrice'];
    dayRange = json['DayRange'];
    depthBuyOrder = json['DepthBuyOrder'];
    depthByPrice = json['DepthByPrice'];
    ePS = json['EPS'];
    exchange = json['Exchange'];
    executed = json['Executed'];
    highPrice = json['HighPrice'];
    indicator = json['Indicator'];
    lastTradePrice = json['LastTradePrice'];
    lastTradeVolume = json['LastTradeVolume'];
    losses = json['Losses'];
    lowPrice = json['LowPrice'];
    marketType = json['MarketType'];
    maxPrice = json['MaxPrice'];
    minPrice = json['MinPrice'];
    netChange = json['NetChange'];
    netChangePerc = json['NetChangePerc'];
    offerPrice = json['OfferPrice'];
    offerVolume = json['OfferVolume'];
    openPrice = json['OpenPrice'];
    pE = json['PE'];
    pivotPoint = json['PivotPoint'];
    precision = json['Precision'];
    profileID = json['ProfileID'];
    resistance1 = json['Resistance1'];
    resistance2 = json['Resistance2'];
    sectorA = json['SectorA'];
    sectorCode = json['SectorCode'];
    sectorE = json['SectorE'];
    support1 = json['Support1'];
    support2 = json['Support2'];
    symbol = json['Symbol'];
    symbolCapital = json['SymbolCapital'];
    symbolNameA = json['SymbolNameA'];
    symbolNameArabic = json['SymbolNameArabic'];
    symbolNameE = json['SymbolNameE'];
    symbolNameEnglish = json['SymbolNameEnglish'];
    topPrice = json['TopPrice'];
    totalBidVolume = json['TotalBidVolume'];
    totalOfferVolume = json['TotalOfferVolume'];
    totalValue = json['TotalValue'];
    totalVolume = json['TotalVolume'];
    updateDateTime = json['UpdateDateTime'];
    recid = json['recid'];
    wk52High = json['wk52High'];
    wk52Low = json['wk52Low'];
    wk52Range = json['wk52Range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AccumlossFlags'] = this.accumlossFlags;
    data['AvgPrice'] = this.avgPrice;
    data['BidPrice'] = this.bidPrice;
    data['BidVolume'] = this.bidVolume;
    data['BuyCashFlowPerc'] = this.buyCashFlowPerc;
    data['ClosePrice'] = this.closePrice;
    data['DayRange'] = this.dayRange;
    data['DepthBuyOrder'] = this.depthBuyOrder;
    data['DepthByPrice'] = this.depthByPrice;
    data['EPS'] = this.ePS;
    data['Exchange'] = this.exchange;
    data['Executed'] = this.executed;
    data['HighPrice'] = this.highPrice;
    data['Indicator'] = this.indicator;
    data['LastTradePrice'] = this.lastTradePrice;
    data['LastTradeVolume'] = this.lastTradeVolume;
    data['Losses'] = this.losses;
    data['LowPrice'] = this.lowPrice;
    data['MarketType'] = this.marketType;
    data['MaxPrice'] = this.maxPrice;
    data['MinPrice'] = this.minPrice;
    data['NetChange'] = this.netChange;
    data['NetChangePerc'] = this.netChangePerc;
    data['OfferPrice'] = this.offerPrice;
    data['OfferVolume'] = this.offerVolume;
    data['OpenPrice'] = this.openPrice;
    data['PE'] = this.pE;
    data['PivotPoint'] = this.pivotPoint;
    data['Precision'] = this.precision;
    data['ProfileID'] = this.profileID;
    data['Resistance1'] = this.resistance1;
    data['Resistance2'] = this.resistance2;
    data['SectorA'] = this.sectorA;
    data['SectorCode'] = this.sectorCode;
    data['SectorE'] = this.sectorE;
    data['Support1'] = this.support1;
    data['Support2'] = this.support2;
    data['Symbol'] = this.symbol;
    data['SymbolCapital'] = this.symbolCapital;
    data['SymbolNameA'] = this.symbolNameA;
    data['SymbolNameArabic'] = this.symbolNameArabic;
    data['SymbolNameE'] = this.symbolNameE;
    data['SymbolNameEnglish'] = this.symbolNameEnglish;
    data['TopPrice'] = this.topPrice;
    data['TotalBidVolume'] = this.totalBidVolume;
    data['TotalOfferVolume'] = this.totalOfferVolume;
    data['TotalValue'] = this.totalValue;
    data['TotalVolume'] = this.totalVolume;
    data['UpdateDateTime'] = this.updateDateTime;
    data['recid'] = this.recid;
    data['wk52High'] = this.wk52High;
    data['wk52Low'] = this.wk52Low;
    data['wk52Range'] = this.wk52Range;
    return data;
  }
}