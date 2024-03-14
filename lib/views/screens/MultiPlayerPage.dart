import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/TicTacToeGame.dart';
import 'package:tic_tac_toe/views/helper/GoogleADHelper.dart';
import 'package:tic_tac_toe/views/utils/ColorUtils.dart';
import 'package:tic_tac_toe/views/utils/ImageUtils.dart';
import 'package:tic_tac_toe/views/utils/VariableUtils.dart';
import 'package:tic_tac_toe/views/widgets/TicTactoeCell.dart';

class MultiPlayerPage extends StatefulWidget {
  const MultiPlayerPage({Key? key}) : super(key: key);

  @override
  _MultiPlayerPageState createState() => _MultiPlayerPageState();
}

class _MultiPlayerPageState extends State<MultiPlayerPage> {
  @override
  void initState() {
    GoogleAdsHelper.googleAdsHelper.showInterstitialAd();
    GoogleAdsHelper.googleAdsHelper.showBannerAd();
    super.initState();
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
                image: AssetImage(
                  ImagePath + HomePageBG,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * 0.08,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: w * 0.02,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Provider.of<TicTacToeGame>(context, listen: false)
                            .restartGame();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: h * 0.036,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('SettingPage');
                        Provider.of<TicTacToeGame>(context, listen: false)
                            .restartGame();
                        GoogleAdsHelper.googleAdsHelper.interstitialAd!.show();
                        GoogleAdsHelper.googleAdsHelper.showInterstitialAd();
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: h * 0.036,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Container(
                  height: h * 0.04,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        ImagePath + MultiPlayerDesign,
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: h * 0.02,
                    right: h * 0.02,
                  ),
                  child: Consumer<TicTacToeGame>(
                    builder: (context, game, child) {
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (!game.isGameOver &&
                                  game.board[index] == TicTacToeCell.empty) {
                                game.playMove(index);
                              }
                            },
                            child: Container(
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
                                          color: AppColors.kPrimary
                                              .withOpacity(0.6),
                                          spreadRadius: w * 0.002,
                                          blurRadius: h * 0.032,
                                          offset: Offset(-w * 0.04, 0),
                                        ),
                                        BoxShadow(
                                          color:
                                              AppColors.kBlack.withOpacity(0.6),
                                          spreadRadius: w * 0.002,
                                          blurRadius: h * 0.032,
                                          offset: Offset(w * 0.04, 0),
                                        ),
                                        BoxShadow(
                                          color: AppColors.kPrimary
                                              .withOpacity(0.2),
                                          spreadRadius: h * 0.032,
                                          blurRadius: h * 0.064,
                                          offset: Offset(-w * 0.04, 0),
                                        ),
                                        BoxShadow(
                                          color:
                                              AppColors.kBlack.withOpacity(0.2),
                                          spreadRadius: h * 0.032,
                                          blurRadius: h * 0.064,
                                          offset: Offset(w * 0.04, 0),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Center(
                                child: Text(
                                  game.board[index].symbol,
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    color: game.board[index] == TicTacToeCell.x
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                Consumer<TicTacToeGame>(
                  builder: (context, game, child) {
                    if (game.isGameOver) {
                      String imagePath;
                      String message;

                      if (game.resultMessage == 'O wins!') {
                        imagePath = ImagePath + Owon;
                        message = 'O Wins!';
                      } else if (game.resultMessage == 'X wins!') {
                        imagePath = ImagePath + Xwon;
                        message = 'X Wins!';
                      } else if (game.resultMessage == 'Draw!') {
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
                      return SizedBox();
                    }
                  },
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Provider.of<TicTacToeGame>(context, listen: false)
                        .restartGame();
                    GoogleAdsHelper.googleAdsHelper.interstitialAd!.show();
                    GoogleAdsHelper.googleAdsHelper.showInterstitialAd();
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
                          Icons.restart_alt,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: w * 0.04,
                        ),
                        Text(
                          "Restart",
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
                  height: h * 0.02,
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
