import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tic_tac_toe/views/utils/ColorUtils.dart';
import 'package:tic_tac_toe/views/utils/ImageUtils.dart';
import 'package:tic_tac_toe/views/widgets/TicTactoeCell.dart';

import '../../provider/TicTacToeGameController.dart';
import '../helper/GoogleADHelper.dart';

class RobotPlayerPage extends StatefulWidget {

  RobotPlayerPage({super.key});

  @override
  State<RobotPlayerPage> createState() => _RobotPlayerPageState();
}

class _RobotPlayerPageState extends State<RobotPlayerPage> {
  final TicTacToeGameController controller = Get.put(TicTacToeGameController(Get.find()));

  @override
  void initState() {
    super.initState();
    GoogleAdsHelper.googleAdsHelper.showBannerAd();
  }

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
                image: AssetImage(ImagePath + HomePageBG),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: h * 0.08),
                Row(
                  children: [
                    SizedBox(width: w * 0.02),
                    IconButton(
                      onPressed: () {
                        Get.back();
                        controller.restartGame();
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white, size: h * 0.036),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.toNamed('SettingPage');
                        controller.restartGame();
                        GoogleAdsHelper.googleAdsHelper.interstitialAd!.show();
                      },
                      icon: Icon(Icons.settings, color: Colors.white, size: h * 0.036),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.02),
                Container(
                  height: h * 0.04,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagePath + SinglePlayerDesign),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: h * 0.02),
                  child:GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return Obx(() {
                          return GestureDetector(
                          onTap: () {
                            if (!controller.isGameOver.value &&
                                controller.board[index] == TicTacToeCell.empty) {
                              controller.playMove(index);
                              if (!controller.isGameOver.value && !controller.isBoardFull) {
                                controller.robotPlayMove();
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(h * 0.05),
                              gradient: LinearGradient(
                                colors: [AppColors.kPrimary, AppColors.kBlack],
                              ),
                              boxShadow: controller.board[index] != TicTacToeCell.empty
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
                              ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                controller.board[index].symbol,
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: controller.board[index] == TicTacToeCell.x
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                SizedBox(height: h * 0.03),
                Obx(() {
                  if (controller.isGameOver.value) {
                    String imagePath;
                    String message;

                    if (controller.resultMessage == 'O wins!') {
                      imagePath = ImagePath + Owon;
                      message = 'O Wins!';
                    } else if (controller.resultMessage == 'X wins!') {
                      imagePath = ImagePath + Xwon;
                      message = 'X Wins!';
                    } else if (controller.resultMessage == 'Draw!') {
                      imagePath = ImagePath + DrawGame;
                      message = 'It\'s a Draw!';
                    } else {
                      imagePath = ImagePath + ErrorGame;
                      message = 'Error!';
                    }

                    return Container(
                      height: h * 0.04,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
                const Spacer(),
                InkWell(
                  onTap: () {
                    controller.restartGame();
                    if (controller.restartCounter.value % 3 == 0) {
                      GoogleAdsHelper.googleAdsHelper.interstitialAd!.show();
                    }
                  },
                  child: Container(
                    height: h * 0.06,
                    width: w * 0.6,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(h * 0.05),
                      gradient: LinearGradient(colors: [AppColors.kPrimary, AppColors.kBlack]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.restart_alt, color: Colors.white),
                        SizedBox(width: w * 0.04),
                        Text(
                          "Restart",
                          style: TextStyle(color: Colors.white, fontSize: h * 0.024),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: h * 0.03),
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
