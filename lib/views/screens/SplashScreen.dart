import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/ImageUtils.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4), () {
      Get.offAllNamed('/');
    });
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: h * 0.26,
            ),
            Container(
              height: h * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ImagePath + AppIcon,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Text(
              "Tic Tac Toe Challenge",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: h * 0.032,
                ),
              ),
            ),
            SizedBox(
              height: h * 0.34,
            ),
            Text(
              "Manage By : HR DigiTech🇮🇳",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: h * 0.016,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
