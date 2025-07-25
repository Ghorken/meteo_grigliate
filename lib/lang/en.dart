import 'dart:math';

import 'package:meteo_grigliate/lang/strings.dart';

class En implements Strings {
  @override
  String get title => 'Barbecue weather';

  @override
  String get previousWeek => 'Previous week';

  @override
  String get nextWeek => 'Next week';

  @override
  String get today => 'Today';

  @override
  String get easterMonday => 'Yesterday was sunny, tomorrow will be sunny, but today is Easter Monday';

  @override
  String barbecueTime() {
    final List<String> grigliataTexts = [
      'It\'s always barbecue time, the sun hides in you!',
      'Barbecue is an art, and the sun is our master!',
      'The air today is made of 22% oxygen and 78% barbecue smell!',
    ];

    return grigliataTexts[Random().nextInt(grigliataTexts.length)];
  }

  @override
  String get shareWithFriends => 'Tell it to all your friends';

  @override
  String shareText(String formattedDate) {
    return 'This is the meteo for the $formattedDate';
  }

  @override
  String get info => 'Infos';

  @override
  String get bugRequest => 'Do you want to discover our others app, signal a bug or make a feature request?';

  @override
  String get join => 'Come visit us on';

  @override
  String get discord => 'https://discord.gg/D9GNQQFYMG';

  @override
  String get email => 'smithingthings@gmail.com';

  @override
  String get support => 'Support request';

  @override
  String get urlError => 'Error on opening';

  @override
  String get sendEmail => 'Or send us an email at';
}
