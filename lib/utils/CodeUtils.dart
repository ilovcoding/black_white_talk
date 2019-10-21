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