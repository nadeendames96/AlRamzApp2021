class GetAccountSummary {
  String balance;
  String blockedBalance;
  String buyPower;
  String currentMarginLimit;
  String expectedProfitLoss;
  String facilityAmount;
  String holdingCost;
  String interestRatePerc;
  String maintMArgin;
  String maintenanceMargin;
  String marginAmount;
  String marketValue;
  String netProfitLoss;
  String realisedProfitLoss;
  String remainingBalance;
  String unUtlizedMarginAmount;
  String unpaidInterset;
  String unsettledBalance;
  String withdrowal;

  GetAccountSummary(
      {this.balance,
        this.blockedBalance,
        this.buyPower,
        this.currentMarginLimit,
        this.expectedProfitLoss,
        this.facilityAmount,
        this.holdingCost,
        this.interestRatePerc,
        this.maintMArgin,
        this.maintenanceMargin,
        this.marginAmount,
        this.marketValue,
        this.netProfitLoss,
        this.realisedProfitLoss,
        this.remainingBalance,
        this.unUtlizedMarginAmount,
        this.unpaidInterset,
        this.unsettledBalance,
        this.withdrowal});

 factory GetAccountSummary.fromJson(Map<String, dynamic> json) =>GetAccountSummary(
    balance : json['Balance'],
    blockedBalance : json['BlockedBalance'],
    buyPower : json['BuyPower'],
    currentMarginLimit : json['CurrentMarginLimit'],
    expectedProfitLoss : json['ExpectedProfitLoss'],
    facilityAmount : json['FacilityAmount'],
    holdingCost : json['HoldingCost'],
    interestRatePerc : json['InterestRatePerc'],
    maintMArgin : json['MaintMArgin'],
    maintenanceMargin : json['MaintenanceMargin'],
    marginAmount : json['MarginAmount'],
    marketValue : json['MarketValue'],
    netProfitLoss : json['NetProfitLoss'],
    realisedProfitLoss : json['RealisedProfitLoss'],
    remainingBalance : json['RemainingBalance'],
    unUtlizedMarginAmount : json['UnUtlizedMarginAmount'],
    unpaidInterset : json['UnpaidInterset'],
    unsettledBalance : json['UnsettledBalance'],
    withdrowal : json['Withdrowal'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Balance'] = this.balance;
    data['BlockedBalance'] = this.blockedBalance;
    data['BuyPower'] = this.buyPower;
    data['CurrentMarginLimit'] = this.currentMarginLimit;
    data['ExpectedProfitLoss'] = this.expectedProfitLoss;
    data['FacilityAmount'] = this.facilityAmount;
    data['HoldingCost'] = this.holdingCost;
    data['InterestRatePerc'] = this.interestRatePerc;
    data['MaintMArgin'] = this.maintMArgin;
    data['MaintenanceMargin'] = this.maintenanceMargin;
    data['MarginAmount'] = this.marginAmount;
    data['MarketValue'] = this.marketValue;
    data['NetProfitLoss'] = this.netProfitLoss;
    data['RealisedProfitLoss'] = this.realisedProfitLoss;
    data['RemainingBalance'] = this.remainingBalance;
    data['UnUtlizedMarginAmount'] = this.unUtlizedMarginAmount;
    data['UnpaidInterset'] = this.unpaidInterset;
    data['UnsettledBalance'] = this.unsettledBalance;
    data['Withdrowal'] = this.withdrowal;
    return data;
  }
}