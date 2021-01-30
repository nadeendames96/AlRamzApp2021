List getData = [];
Entries(e) {
  MapEntry entry = e.entries.firstWhere(
      (element) => element.key == 'Type' && element.value == 'MRS',
      orElse: () => null);
  if (entry != null) {
    getData.add(e['DescE']);
  }
}
