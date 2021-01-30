class ExchangeSummaryMarket {
  final List<String> exchangeSummaryMarket;

  ExchangeSummaryMarket({this.exchangeSummaryMarket});

  factory ExchangeSummaryMarket.fromJson(List<dynamic> json) {
    return ExchangeSummaryMarket(
      exchangeSummaryMarket: json != null ? new List<String>.from(json) : null,
    );
  }

  List<dynamic> toJson() {
    List<dynamic> data = new List<String>();
    if (this.exchangeSummaryMarket != null) {
      data = this.exchangeSummaryMarket;
    }
    return data;
  }
}
