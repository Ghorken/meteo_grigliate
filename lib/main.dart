import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meteo_grigliate/lang/strings.dart';
import 'package:meteo_grigliate/screens/meteo_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:meteo_grigliate/themes/themes.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'package:rive/rive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(Platform.localeName, null);

  await RiveFile.initialize();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: strings.title,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: SplashScreen.navigate(
        name: 'assets/animations/anvil.riv',
        next: (context) => MeteoScreen(),
        until: () => Future.delayed(const Duration(milliseconds: 500)),
        loopAnimation: 'Martellata',
        backgroundColor: Themes.backgroundColor,
        fit: BoxFit.contain,
      ),
      debugShowCheckedModeBanner: false,
      color: Themes.backgroundColor,
    );
  }
}
