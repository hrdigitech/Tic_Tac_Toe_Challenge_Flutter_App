import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tic_tac_toe/views/utils/ImageUtils.dart';
import '../../provider/SettingController.dart';
import '../helper/GoogleADHelper.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    GoogleAdsHelper.googleAdsHelper.showBannerAd();
    super.initState();
  }

  final SettingsController settingsController =
      Get.put(SettingsController()); // Initialize controller

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImagePath + HomePageBG,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              h * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * 0.02,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    size: h * 0.03,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Settings",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: h * 0.024,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      "Volume",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: h * 0.024,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      "You can change the volume on or off.",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: h * 0.016,
                        ),
                      ),
                    ),
                    trailing: Obx(
                      () => IconButton(
                        onPressed: () {
                          settingsController.toggleVolume();
                        },
                        icon: Icon(
                          settingsController.isVolumeOn.value
                              ? Icons.volume_down
                              : Icons.volume_off,
                          size: h * 0.04,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      "App Version",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: h * 0.024,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      "Your app version :- 3.0.6",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: h * 0.016,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      "Quiet the App",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: h * 0.024,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      "Are You Sure to Exit the Tic Tac Toe Challenge App.",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: h * 0.016,
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        exit(0);
                      },
                      icon: Icon(
                        Icons.exit_to_app,
                        size: h * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    "Manage By : HR DigiTech🇮🇳",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: h * 0.018,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: h * 0.06,
        child: AdWidget(
          ad: GoogleAdsHelper.googleAdsHelper.bannerAd!,
        ),
      ),
    );
  }
}
