import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/TicTacToeGame.dart';
import 'package:tic_tac_toe/views/screens/ClassicGamePage.dart';
import 'package:tic_tac_toe/views/screens/HomePage.dart';
import 'package:tic_tac_toe/views/screens/MultiPlayerPage.dart';
import 'package:tic_tac_toe/views/screens/RobotPlayerPage.dart';
import 'package:tic_tac_toe/views/screens/SettingPage.dart';
import 'package:tic_tac_toe/views/screens/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    runApp(
      const MyApp(),
    );
  });
  // await MobileAds.instance.initialize();
  // GoogleAdsHelper.googleAdsHelper.loadAppOpenAd();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TicTacToeGame(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'SplashScreen',
        routes: {
          'SplashScreen': (context) => SplashScreen(),
          '/': (context) => HomePage(),
          'MultiPlayerPage': (context) => const MultiPlayerPage(),
          'RobotPlayerPage': (context) => const RobotPlayerPage(),
          'ClassicGamePage': (context) => const ClassicGamePage(),
          'SettingPage': (context) => const SettingPage(),
        },
      ),
    );
  }
}
