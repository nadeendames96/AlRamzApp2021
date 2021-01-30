EntriesIndex(e) {
  MapEntry entry = e.entries
      .firstWhere((element) => element.key == 'ExchangeID', orElse: () => null);
  List exchangesID = [];
  if (e['ExchangeID'].toString().isNotEmpty) {
    exchangesID.add(e['ExchangeID']);
  }
}
