import 'dart:math';

import 'package:meteo_grigliate/lang/strings.dart';

class It implements Strings {
  @override
  String get title => 'Meteo grigliate';

  @override
  String get previousWeek => 'Settimana precedente';

  @override
  String get nextWeek => 'Settimana successiva';

  @override
  String get today => 'Oggi';

  @override
  String get easterMonday => 'Ieri c\'era il sole, domani ci sarà il sole, ma oggi è Pasquetta';

  @override
  String barbecueTime() {
    final List<String> grigliataTexts = [
      'È sempre tempo per una grigliata, perché il sole è dentro di te!',
      'La grigliata è un\'arte, e il sole è il nostro maestro!',
      'L’aria oggi è composta per il 22% di ossigeno e per il 78% di profumo di grigliata!',
    ];

    return grigliataTexts[Random().nextInt(grigliataTexts.length)];
  }

  @override
  String get shareWithFriends => 'Fallo sapere anche agli amici';

  @override
  String shareText(String formattedDate) {
    return 'Questo è il meteo per il $formattedDate';
  }

  @override
  String get info => 'Informazioni';

  @override
  String get bugRequest => 'Vuoi scoprire le altre nostre app, segnalare bug o richiedere feature?';

  @override
  String get join => 'Vieni a trovarci su';

  @override
  String get discord => 'https://discord.gg/D9GNQQFYMG';

  @override
  String get email => 'smithingthings@gmail.com';

  @override
  String get support => 'Richiesta supporto';

  @override
  String get urlError => 'Impossibile aprire';

  @override
  String get sendEmail => 'O inviaci una mail a';
}
