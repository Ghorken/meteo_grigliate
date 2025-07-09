import 'dart:io';

import 'package:meteo_grigliate/lang/en.dart';
import 'package:meteo_grigliate/lang/it.dart';

abstract class Strings {
  String get title;
  String get previousWeek;
  String get nextWeek;
  String get today;
  String get barbecueTime;
  String get shareWithFriends;
  String shareText(String day, String month, String year);
  String get info;
  String get bugRequest;
  String get join;
  String get urlError;
  String get discord;
}

Strings get strings {
  if (Platform.localeName.contains("it")) {
    return It();
  } else {
    return En();
  }
}
