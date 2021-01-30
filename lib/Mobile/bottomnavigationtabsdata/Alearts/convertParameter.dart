import 'package:flutter/material.dart';

class CovertParameter extends StatelessWidget {
  String convertedParameter = '';

  CovertParameter(this.convertedParameter);

  @override
  Widget build(BuildContext context) {
    return _convertParameters(this.convertedParameter);
  }

  _convertParameters(String parameter) {
    if (parameter == 'Last Price') {
      parameter = 'MW_LAST_TRADE_PRICE';
    } else if (parameter == 'High Price') {
      parameter = 'MW_HIGH_PRICE';
    } else if (parameter == 'Low Price') {
      parameter = 'MW_LOW_PRICE';
    } else if (parameter == 'Bid Price') {
      parameter = 'MW_MAX_PRICE';
    } else if (parameter == 'Offer Price') {
      parameter = 'MW_MIN_PRICE';
    } else if (parameter == 'Net Change') {
      parameter = 'MW_NET_CHANGE';
    } else if (parameter == 'Net Change %') {
      parameter = 'Net_Change_per';
    } else if (parameter == 'Average Price') {
      parameter = 'MW_AVERAGE_PRICE';
    } else if (parameter == 'Total Value') {
      parameter = 'MW_LAST_TRADE_VOL';
    } else if (parameter == 'Total Volume') {
      parameter = 'MW_TOTAL_VOLUME';
    }
  }
}
