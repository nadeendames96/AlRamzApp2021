import 'package:flutter/material.dart';

import 'file:///C:/Users/FIT/AndroidStudioProjects/AlRamz/AlRamz2020/alramz/lib/styles/textstyle.dart';

class LengthWord extends StatelessWidget {
  String word = '';

  LengthWord(this.word);

  Widget build(BuildContext context) {
    return wordFormate(this.word);
  }

  wordFormate(String word) {
    if (word.length > 28) {
      word = word.substring(0, 29);
      return Text(
        word + '...',
        style: TextStyleApplied.Text,
      );
    }
    return Text(
      word,
      style: TextStyleApplied.Text,
    );
  }
}
