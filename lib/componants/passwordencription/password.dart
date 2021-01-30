import 'dart:math';

class Encription {
  // static bool isNaN(String value) {
  //   if (value == null) {
  //     print(value);
  //     return false;
  //   }
  //   // double num = double.parse(value);
  //   // print(num.toString());
  //   // print(int.tryParse(value));
  //
  //   else {
  //     print(value);
  //    if(double.tryParse(value) != null){
  //      return true;
  //    }
  //    else{
  //      return false;
  //    }
  //
  //   }
  // }

  static String _isNAN = 'NaN';
  static bool isTrue = false;
  static bool isNaN(value) {
    if (value == null) {
      return false;
    } else {
      int num = int.tryParse(value);
      if (!(num == null)) {
        isTrue = false;
      } else {
        isTrue = true;
      }
      if (isTrue == true) {
        value = _isNAN;
        print(value);
      } else {
        value = value;
        print(value);
      }
    }
    return isTrue;
  }

  static var _keyStr =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
  static encryptedString(input) {
    var svalue = encode(input, 's');
    var bvalue = encode(svalue[0], 'b');
    var gen = generate(3);
    input = bvalue[0] + gen + svalue[1];
    print('input Enc');
    print(input);
    return input;
  }

  static generate(n) {
    var add = 1,
        max = 12 -
            add; // 12 is the min safe number Math.random() can generate without it starting to pad the end with zeros.

    if (n > max) {
      return generate(max) + generate(n - max);
    }
    Random _random = Random();
    max = pow(10, n + add);
    var min = max / 10; // Math.pow(10, n) basically
    var com = max - min + 1;
    var number = ((_random.nextInt(com.toInt()) + min).floor()).toString();

    return "!" + ("" + number.toString()).substring(add);
  }

  static _utf8_encode(String string) {
    string = string.replaceAll('/\r\n/g', "\n");
    var utftext = "";

    for (int n = 0; n < string.length; n++) {
      var c = string[n].codeUnitAt(0);
      if (c < 128) {
        utftext += String.fromCharCode(c);
      } else if ((c > 127) && (c < 2048)) {
        utftext += String.fromCharCode((c >> 6) | 192);
        utftext += String.fromCharCode((c & 63) | 128);
      } else {
        utftext += String.fromCharCode((c >> 12) | 224);
        utftext += String.fromCharCode(((c >> 6) & 63) | 128);
        utftext += String.fromCharCode((c & 63) | 128);
      }
    }
    return utftext;
  }

  static encode(String input, type) {
    String output = "";
    var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
    var i = 0;
    if (type == 'b')
      input = _utf8_encode("**" + input);
    else
      input = _utf8_encode(input);
    while (i < input.length) {
      if (i < input.length) {
        chr1 = input[i++].codeUnitAt(0);
      } else {
        chr1 = 'NaN';
      }
      if (i < input.length) {
        chr2 = input[i++].codeUnitAt(0);
      } else {
        chr2 = 'NaN';
      }
      if (i < input.length) {
        chr3 = input[i++].codeUnitAt(0);
      } else {
        chr3 = 'NaN';
      }
      if (chr1 != 'NaN') {
        enc1 = chr1 >> 2;
      } else {
        enc1 = 0;
      }
      if (chr2 != 'NaN') {
        enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
      } else {
        enc2 = ((chr1 & 3) << 4);
      }
      if (chr2 != 'NaN' && chr3 != 'NaN') {
        enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
      } else if (chr2 != 'NaN') {
        enc3 = ((chr2 & 15) << 2);
      } else if (chr3 != 'NaN') {
        enc3 = (chr3 >> 6);
      } else {
        enc3 += 0;
      }
      if (chr3 != 'NaN') {
        enc4 = chr3 & 63;
      } else {
        enc4 = 0;
      }
      if (isNaN(chr2.toString())) {
        enc3 = enc4 = 64;
      } else if (isNaN(chr3.toString())) {
        enc4 = 64;
      }
      output = output +
          _keyStr[enc1] +
          _keyStr[enc2] +
          _keyStr[enc3] +
          _keyStr[enc4];
    }
    var retValue = ['', ''];
    Random _random = Random();
    if (type == 'b') {
      retValue[0] = output +
          (_random.nextInt(10)).floor().toString() +
          (_random.nextInt(10)).floor().toString();
      retValue[1] = "";
      return retValue;
    } else {
      int len = output.length;
      len ~/= 2;
      retValue[1] = output.substring(0, len); //key

      output = output.substring(len, output.length);

      retValue[0] = output;

      return retValue;
    }
  }
}
