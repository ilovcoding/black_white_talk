
import 'dart:convert';

import 'package:crypto/crypto.dart';

int getASCII(String lesson_code) {
  List codeList = lesson_code.split("--");
  int sum = 0;
  if (codeList.length == 2) {
    for (int i = 0; i < codeList[0].length; i++) {
      sum += codeList[0].codeUnitAt(i);
    }
    for (int i = 0; i < codeList[1].length; i++) {
      sum += codeList[1].codeUnitAt(i);
    }
    return sum;
  }
  return lesson_code.length;
}

String tosha256(String str){
  var key = utf8.encode('sha256-key');
  var bytes = utf8.encode(str);
  var hmacSha256 = new Hmac(sha256, key); // HMAC-SHA256
  var digest = hmacSha256.convert(bytes);
  return digest.toString();
}