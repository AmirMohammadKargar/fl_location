String formatedTime({required int timeInSecond}) {
  var sec = timeInSecond % 60;
  var min = (timeInSecond / 60).floor();
  var minute = min.toString().length <= 1 ? '0$min' : '$min';
  var second = sec.toString().length <= 1 ? '0$sec' : '$sec';
  return '$minute : $second';
}
