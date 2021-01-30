import 'package:flutter/material.dart';

class ConvertCateriaToSymbol extends StatelessWidget {
  String convertedCriteria = '';

  ConvertCateriaToSymbol(this.convertedCriteria);

  @override
  Widget build(BuildContext context) {
    return _convertedCriteria(convertedCriteria);
  }

  _convertedCriteria(String cretiriaString) {
    if (cretiriaString == 'Equals') {
      cretiriaString = 'E';
    } else if (cretiriaString == 'Not Equals') {
      cretiriaString = 'NE';
    } else if (cretiriaString == 'Greater than') {
      cretiriaString = 'GT';
    } else if (cretiriaString == 'Greater than or equals') {
      cretiriaString = 'GE';
    } else if (cretiriaString == 'Less than') {
      cretiriaString = 'LT';
    } else if (cretiriaString == 'Less than or equals') {
      cretiriaString = 'LE';
    }
  }
}
