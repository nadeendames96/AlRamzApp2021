import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/defaultvalues/defaultvalues.dart';

class MarketsValues {
  static String markets = '',
      currentValues = '',
      netChanges = '',
      netChangesPrecs = '',
      marketNamesEn = '',
      turnovers = '',
      volumes = '',
      trades = '',
      symboltrades = '';
  static void Markets() async {
    markets = Statics.Market[0];
    currentValues = Statics.currentValueMarket[0];
    netChanges = Statics.netChangeValueMarket[0];
    netChangesPrecs = Statics.netChangePrecValueMarket[0];
    marketNamesEn = Statics.MarketNamweEn[0];
    turnovers = Statics.turnoverMarket[0];
    volumes = Statics.volumeMarket[0];
    trades = Statics.tradesMarket[0];
    symboltrades = Statics.symbolTradesMarket[0];
  }
}
