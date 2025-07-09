import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:meteo_grigliate/lang/strings.dart';
import 'package:meteo_grigliate/screens/meteo_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(Platform.localeName, null);
  MobileAds.instance.initialize();

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
    return MaterialApp(title: strings.title, theme: ThemeData(primarySwatch: Colors.orange), home: const MeteoScreen(), debugShowCheckedModeBanner: false);
  }
}
