import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/defaultvalues/staticvalues.dart';

Entries(e) {
  MapEntry entry = e.entries
      .firstWhere((element) => element.key == 'ExchangeID', orElse: () => null);
  List exchangesID = [];
  if (e['ExchangeID'].toString().isNotEmpty) {
    exchangesID.add(e['ExchangeID']);
  }
  StaticValues.market = exchangesID[0];
  MapEntry entry2 = e.entries.firstWhere(
      (element) => element.key == 'ExchangeNameE',
      orElse: () => null);
  List exchangeNameEn = [];
  if (e['ExchangeNameE'].toString().isNotEmpty) {
    exchangeNameEn.add(e['ExchangeNameE']);
    StaticValues.marketNameE = exchangeNameEn[0];
  }

  MapEntry entry3 = e.entries
      .firstWhere((element) => element.key == 'TurnOver', orElse: () => null);
  List turnovers = [];
  if (e['TurnOver'].toString().isNotEmpty) {
    turnovers.add(e['TurnOver']);
  }
  // StaticValues.turnover = turnovers[0];
  MapEntry entry4 = e.entries.firstWhere(
      (element) => element.key == 'CurrentValue',
      orElse: () => null);
  List currentValues = [];
  if (e['CurrentValue'].toString().isNotEmpty) {
    currentValues.add(e['CurrentValue']);
  }
  // StaticValues.currentValue = currentValues[0];
  MapEntry entry5 = e.entries
      .firstWhere((element) => element.key == 'NetChange', orElse: () => null);
  List netChanges = [];
  if (e['NetChange'].toString().isNotEmpty) {
    netChanges.add(e['NetChange']);
  }
  StaticValues.netChange = netChanges[0];
  MapEntry entry6 = e.entries.firstWhere(
      (element) => element.key == 'NetChangePerc',
      orElse: () => null);
  List netChangesPrec = [];
  if (e['NetChangePerc'].toString().isNotEmpty) {
    netChangesPrec.add(e['NetChangePerc']);
  }
  StaticValues.netChangePrec = netChangesPrec[0];
  MapEntry entry7 = e.entries.firstWhere(
      (element) => element.key == 'TotalExecuted',
      orElse: () => null);
  List trades = [];
  if (e['TotalExecuted'].toString().isNotEmpty) {
    trades.add(e['TotalExecuted']);
  }
  StaticValues.trades = trades[0];
  MapEntry entry8 = e.entries.firstWhere(
      (element) => element.key == 'SymbolsTraded',
      orElse: () => null);
  List symbolTrades = [];
  if (e['SymbolsTraded'].toString().isNotEmpty) {
    symbolTrades.add(e['SymbolsTraded']);
  }
  StaticValues.symbolTrades = symbolTrades[0];
  MapEntry entry9 = e.entries
      .firstWhere((element) => element.key == 'Volume', orElse: () => null);
  List volume = [];
  if (e['Volume'].toString().isNotEmpty) {
    volume.add(e['Volume']);
  }
  StaticValues.volume = volume[0];
  MapEntry entry10 = e.entries
      .firstWhere((element) => element.key == 'SymbolsUP', orElse: () => null);
  List symbolUps = [];
  if (e['SymbolsUP'].toString().isNotEmpty) {
    volume.add(e['SymbolsUP']);
  }
  StaticValues.symbolUps = symbolUps[0];
  MapEntry entry11 = e.entries.firstWhere(
      (element) => element.key == 'SymbolsDown',
      orElse: () => null);
  List symbolDns = [];
  if (e['SymbolsDown'].toString().isNotEmpty) {
    volume.add(e['SymbolsDown']);
  }
  StaticValues.symbolDns = symbolDns[0];
  MapEntry entry12 = e.entries.firstWhere(
      (element) => element.key == 'SymbolsUnChange',
      orElse: () => null);
  List symbolNoChnage = [];
  if (e['SymbolsUnChange'].toString().isNotEmpty) {
    volume.add(e['SymbolsUnChange']);
  }
  StaticValues.noChange = symbolNoChnage[0];
  MapEntry entry13 = e.entries.firstWhere(
      (element) => element.key == 'BuyCashFlowPerc',
      orElse: () => null);
  List netFolws = [];
  if (e['BuyCashFlowPerc'].toString().isNotEmpty) {
    netFolws.add(e['BuyCashFlowPerc']);
  }
  StaticValues.netFlows = netFolws[0];
  StaticValues.cashMap = netFolws[0];
}
