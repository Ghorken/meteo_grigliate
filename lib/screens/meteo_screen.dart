import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:meteo_grigliate/screens/info_screen.dart';
import 'package:meteo_grigliate/lang/strings.dart';
import 'package:meteo_grigliate/themes/themes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class MeteoScreen extends StatefulWidget {
  const MeteoScreen({super.key});

  @override
  State<MeteoScreen> createState() => _MeteoScreenState();
}

class _MeteoScreenState extends State<MeteoScreen> {
  late DateTime firstWeekDay;
  bool isLoading = false;
  late int selectedDayIndex;
  final ScreenshotController _screenshotController = ScreenshotController();
  late BannerAd _bannerAd;
  bool _isBannerReady = false;

  // Lista immagini asset
  final List<String> grigliataImages = ['assets/grigliata/grigliata1.jpg', 'assets/grigliata/grigliata2.jpg', 'assets/grigliata/grigliata3.jpg', 'assets/grigliata/grigliata4.jpg'];
  final CarouselSliderController _carouselSliderController = CarouselSliderController();

  @override
  void initState() {
    setState(() {
      firstWeekDay = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
      selectedDayIndex = DateTime.now().weekday - 1;
    });

    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/9214589741',
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner fallito: $error');
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDays = getCurrentWeekDays(firstWeekDay);
    String monthYear = DateFormat.yMMMM(Platform.localeName).format(firstWeekDay);
    String capitalizedMonthYear = "${monthYear[0].toUpperCase()}${monthYear.substring(1)}";

    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        title: Text(strings.title),
        centerTitle: true,
        backgroundColor: Themes.appBarColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoScreen()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 20.0,
                  children: [
                    Screenshot(
                      controller: _screenshotController,
                      child: Container(
                        color: Themes.backgroundColor,
                        child: Column(
                          spacing: 20.0,
                          children: [
                            // Mese e anno con i pulsanti
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(onPressed: () => changeYear(-1), icon: const Icon(Icons.fast_rewind)),
                                IconButton(onPressed: () => changeMonth(-1), icon: const Icon(Icons.chevron_left)),
                                Text(capitalizedMonthYear, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                IconButton(onPressed: () => changeMonth(1), icon: const Icon(Icons.chevron_right)),
                                IconButton(onPressed: () => changeYear(1), icon: const Icon(Icons.fast_forward)),
                              ],
                            ),

                            // Giorni della settimana
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:
                                  weekDays.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    DateTime day = entry.value;

                                    bool isSelected = selectedDayIndex == index;

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedDayIndex = index;
                                          isLoading = true;
                                        });

                                        Future.delayed(const Duration(milliseconds: 500), () {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        });
                                      },
                                      child: Container(
                                        width: 50, // larghezza fissa
                                        height: 60,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(color: isSelected ? Colors.orange.shade300 : Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            Text(DateFormat.EEEEE(Platform.localeName).format(day), style: const TextStyle(fontWeight: FontWeight.bold)),
                                            Text(day.day.toString()),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),

                            // Cambia settimana
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(onPressed: () => changeWeek(-1), child: Text(strings.previousWeek)),
                                ElevatedButton(onPressed: () => changeWeek(1), child: Text(strings.nextWeek)),
                              ],
                            ),

                            // Imposta ad oggi
                            ElevatedButton(onPressed: resetToToday, child: Text(strings.today)),

                            // Immagine del sole
                            isLoading ? const CircularProgressIndicator() : Icon(Icons.wb_sunny, size: 150, color: Colors.orange),

                            // Scritta personalizzata
                            Center(child: Text(strings.barbecueTime, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), textAlign: TextAlign.center)),
                          ],
                        ),
                      ),
                    ),

                    ElevatedButton.icon(onPressed: shareScreenshot, icon: const Icon(Icons.share), label: Text(strings.shareWithFriends)),

                    CarouselSlider(
                      items:
                          grigliataImages.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(color: Colors.amber),
                                  child: Image.asset(i, fit: BoxFit.cover),
                                );
                              },
                            );
                          }).toList(),
                      carouselController: _carouselSliderController,
                      options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isBannerReady) SizedBox(height: _bannerAd.size.height.toDouble(), width: _bannerAd.size.width.toDouble(), child: AdWidget(ad: _bannerAd)),
        ],
      ),
    );
  }

  void changeWeek(int offset) {
    setState(() {
      firstWeekDay = firstWeekDay.add(Duration(days: offset * 7));
    });
  }

  void changeMonth(int offset) {
    setState(() {
      firstWeekDay = DateTime(firstWeekDay.year, firstWeekDay.month + offset, firstWeekDay.day);
    });
  }

  void changeYear(int offset) {
    setState(() {
      firstWeekDay = DateTime(firstWeekDay.year + offset, firstWeekDay.month, firstWeekDay.day);
    });
  }

  void resetToToday() {
    setState(() {
      firstWeekDay = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
      selectedDayIndex = DateTime.now().weekday - 1;
      isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  List<DateTime> getCurrentWeekDays(DateTime firstWeekDay) {
    return List.generate(7, (index) => firstWeekDay.add(Duration(days: index)));
  }

  void shareScreenshot() async {
    final image = await _screenshotController.capture();
    if (image == null) return;

    final directory = await getTemporaryDirectory();
    final imagePath = await File('${directory.path}/condivisione.png').create();
    await imagePath.writeAsBytes(image);

    final DateTime selectedDay = firstWeekDay.add(Duration(days: selectedDayIndex));

    String day = selectedDay.day.toString();
    String month = DateFormat.MMMM(Platform.localeName).format(selectedDay);
    String capitalizedMonth = "${month[0].toUpperCase()}${month.substring(1)}";
    String year = selectedDay.year.toString();

    SharePlus.instance.share(ShareParams(files: [XFile(imagePath.path)], text: strings.shareText('$day $capitalizedMonth $year')));
  }
}
