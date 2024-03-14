import 'dart:developer';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdsHelper {
  GoogleAdsHelper._();
  static final GoogleAdsHelper googleAdsHelper = GoogleAdsHelper._();

  BannerAd? bannerAd;

  void showBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      // adUnitId: "ca-app-pub-3940256099942544/9214589741", // Testing ID
      adUnitId: "ca-app-pub-8947847161570728/6326499881",
      listener: BannerAdListener(
          onAdClosed: (Ad ad){
            log("Ad Closed");
          },
          onAdFailedToLoad: (Ad ad,LoadAdError error){
            ad.dispose();
          },
          onAdLoaded: (Ad ad){
            log('Ad Loaded');
          },
          onAdOpened: (Ad ad){
            log('Ad opened');
          }
      ),
      request: const AdRequest(),

    );

    bannerAd?.load();
  }

  InterstitialAd? interstitialAd;

  void showInterstitialAd() {
    int attempt = 0;
    InterstitialAd.load(
      // adUnitId: "ca-app-pub-3940256099942544/8691691433", // Testing ID
      adUnitId: "ca-app-pub-8947847161570728/1855157430",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad){
            interstitialAd = ad;
            attempt =0;
          },
          onAdFailedToLoad: (LoadAdError error){
            attempt +1;
            interstitialAd = null;
            if(attempt<=2){
              showInterstitialAd();
            }
          }),
    );
  }

  AppOpenAd? appOpenAd;

  void loadAppOpenAd() {
    AppOpenAd.load(
      // adUnitId: "ca-app-pub-3940256099942544/9257395921", // Testing ID
      adUnitId: "ca-app-pub-8947847161570728/1799317115",
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          appOpenAd = ad;
          showAppOpenAd();
        },
        onAdFailedToLoad: (error) {
          log("AppOpenAd failed to load: $error");
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    );
  }

  void showAppOpenAd() {
    if (appOpenAd != null) {
      appOpenAd!.show();
    } else {
      print("AppOpenAd is not loaded yet. Call loadAppOpenAd() before showing.");
    }
  }
}