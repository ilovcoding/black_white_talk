main(List<String> args) {
  RegExp homeNum = RegExp(r'^[0-9]*$');
  print(homeNum.hasMatch(''));
}