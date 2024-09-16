import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tic_tac_toe/provider/SettingController.dart';
import 'package:tic_tac_toe/provider/TicTacToeGameController.dart';
import 'package:tic_tac_toe/views/screens/HomePage.dart';
import 'package:tic_tac_toe/views/screens/MultiPlayerPage.dart';
import 'package:tic_tac_toe/views/screens/RobotPlayerPage.dart';
import 'package:tic_tac_toe/views/screens/SettingPage.dart';
import 'package:tic_tac_toe/views/screens/SplashScreen.dart';
import 'package:tic_tac_toe/views/helper/GoogleADHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  GoogleAdsHelper.googleAdsHelper.loadAppOpenAd();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    runApp(
      const MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'SplashScreen',
      initialBinding: BindingsBuilder(() {
        // Put the SettingsController first before TicTacToeGameController
        Get.put(SettingsController());
        Get.put(TicTacToeGameController(Get.find<SettingsController>()));
      }),
      routes: {
        'SplashScreen': (context) => SplashScreen(),
        '/': (context) => HomePage(),
        'MultiPlayerPage': (context) => MultiPlayerPage(),
        'RobotPlayerPage': (context) => RobotPlayerPage(),
        'SettingPage': (context) => const SettingPage(),
      },
    );
  }
}
