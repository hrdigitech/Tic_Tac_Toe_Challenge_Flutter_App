import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tic_tac_toe/views/utils/ColorUtils.dart';
import 'package:tic_tac_toe/views/utils/ImageUtils.dart';
import 'package:tic_tac_toe/views/utils/VariableUtils.dart';

import '../helper/GoogleADHelper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    GoogleAdsHelper.googleAdsHelper.showBannerAd();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Stack(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * 0.08,
                ),
                Container(
                  height: h * 0.05,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        ImagePath + HomePageDesign,
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                Container(
                  height: h * 0.42,
                  width: w * 0.8,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: w * 0.008,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(
                      h * 0.02,
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        ImagePath + AppIcon,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.08,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('RobotPlayerPage');
                  },
                  child: AnimatedContainer(
                    transform: Matrix4.identity()..scale(scale),
                    duration: const Duration(milliseconds: 200),
                    height: h * 0.06,
                    width: w * 0.6,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(h * 0.05),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.kPrimary,
                          AppColors.kBlack,
                        ],
                      ),
                      boxShadow: glowing
                          ? [
                              BoxShadow(
                                color: AppColors.kPrimary.withOpacity(0.6),
                                spreadRadius: w * 0.002,
                                blurRadius: h * 0.032,
                                offset: Offset(-w * 0.04, 0),
                              ),
                              BoxShadow(
                                color: AppColors.kBlack.withOpacity(0.6),
                                spreadRadius: w * 0.002,
                                blurRadius: h * 0.032,
                                offset: Offset(w * 0.04, 0),
                              ),
                              BoxShadow(
                                color: AppColors.kPrimary.withOpacity(0.2),
                                spreadRadius: h * 0.032,
                                blurRadius: h * 0.064,
                                offset: Offset(-w * 0.04, 0),
                              ),
                              BoxShadow(
                                color: AppColors.kBlack.withOpacity(0.2),
                                spreadRadius: h * 0.032,
                                blurRadius: h * 0.064,
                                offset: Offset(w * 0.04, 0),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: w * 0.04,
                        ),
                        Text(
                          "Single Player",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: h * 0.024,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('MultiPlayerPage');
                  },
                  child: AnimatedContainer(
                    transform: Matrix4.identity()..scale(scale),
                    duration: const Duration(milliseconds: 200),
                    height: h * 0.06,
                    width: w * 0.6,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(h * 0.05),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.kPrimary,
                          AppColors.kBlack,
                        ],
                      ),
                      boxShadow: glowing
                          ? [
                              BoxShadow(
                                color: AppColors.kPrimary.withOpacity(0.6),
                                spreadRadius: w * 0.002,
                                blurRadius: h * 0.032,
                                offset: Offset(-w * 0.04, 0),
                              ),
                              BoxShadow(
                                color: AppColors.kBlack.withOpacity(0.6),
                                spreadRadius: w * 0.002,
                                blurRadius: h * 0.032,
                                offset: Offset(w * 0.04, 0),
                              ),
                              BoxShadow(
                                color: AppColors.kPrimary.withOpacity(0.2),
                                spreadRadius: h * 0.032,
                                blurRadius: h * 0.064,
                                offset: Offset(-w * 0.04, 0),
                              ),
                              BoxShadow(
                                color: AppColors.kBlack.withOpacity(0.2),
                                spreadRadius: h * 0.032,
                                blurRadius: h * 0.064,
                                offset: Offset(w * 0.04, 0),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.supervised_user_circle_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: w * 0.04,
                        ),
                        Text(
                          "Multiple Player",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: h * 0.024,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('SettingPage');
                  },
                  child: AnimatedContainer(
                    transform: Matrix4.identity()..scale(scale),
                    duration: const Duration(milliseconds: 200),
                    height: h * 0.06,
                    width: w * 0.6,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(h * 0.05),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.kPrimary,
                          AppColors.kBlack,
                        ],
                      ),
                      boxShadow: glowing
                          ? [
                              BoxShadow(
                                color: AppColors.kPrimary.withOpacity(0.6),
                                spreadRadius: w * 0.002,
                                blurRadius: h * 0.032,
                                offset: Offset(-w * 0.04, 0),
                              ),
                              BoxShadow(
                                color: AppColors.kBlack.withOpacity(0.6),
                                spreadRadius: w * 0.002,
                                blurRadius: h * 0.032,
                                offset: Offset(w * 0.04, 0),
                              ),
                              BoxShadow(
                                color: AppColors.kPrimary.withOpacity(0.2),
                                spreadRadius: h * 0.032,
                                blurRadius: h * 0.064,
                                offset: Offset(-w * 0.04, 0),
                              ),
                              BoxShadow(
                                color: AppColors.kBlack.withOpacity(0.2),
                                spreadRadius: h * 0.032,
                                blurRadius: h * 0.064,
                                offset: Offset(w * 0.04, 0),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: w * 0.04,
                        ),
                        Text(
                          "Setting",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: h * 0.024,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
