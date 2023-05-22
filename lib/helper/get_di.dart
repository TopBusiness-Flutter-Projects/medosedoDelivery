import 'dart:convert';


import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:medosedoDelivery/controller/auth_controller.dart';
import 'package:medosedoDelivery/controller/chat_controller.dart';
import 'package:medosedoDelivery/controller/language_controller.dart';
import 'package:medosedoDelivery/controller/localization_controller.dart';
import 'package:medosedoDelivery/controller/location_controller.dart';
import 'package:medosedoDelivery/controller/menu_controller.dart';
import 'package:medosedoDelivery/controller/notification_controller.dart';
import 'package:medosedoDelivery/controller/onboarding_controller.dart';
import 'package:medosedoDelivery/controller/order_controller.dart';
import 'package:medosedoDelivery/controller/profile_controller.dart';
import 'package:medosedoDelivery/controller/rider_controller.dart';
import 'package:medosedoDelivery/controller/splash_controller.dart';
import 'package:medosedoDelivery/controller/theme_controller.dart';
import 'package:medosedoDelivery/controller/tracker_controller.dart';
import 'package:medosedoDelivery/controller/wallet_controller.dart';
import 'package:medosedoDelivery/data/api/api_client.dart';
import 'package:medosedoDelivery/data/model/response/language_model.dart';
import 'package:medosedoDelivery/data/repository/RiderRepo.dart';
import 'package:medosedoDelivery/data/repository/auth_repo.dart';
import 'package:medosedoDelivery/data/repository/chat_repo.dart';
import 'package:medosedoDelivery/data/repository/language_repo.dart';
import 'package:medosedoDelivery/data/repository/notification_repo.dart';
import 'package:medosedoDelivery/data/repository/onboarding_repo.dart';
import 'package:medosedoDelivery/data/repository/order_repo.dart';
import 'package:medosedoDelivery/data/repository/profile_repo.dart';
import 'package:medosedoDelivery/data/repository/splash_repo.dart';
import 'package:medosedoDelivery/data/repository/tracker_repo.dart';
import 'package:medosedoDelivery/data/repository/wallet_repo.dart';
import 'package:medosedoDelivery/utill/app_constants.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUri, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => OnBoardingRepo());
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => TrackerRepo(apiClient: Get.find(), sharedPreferences:  Get.find()));
  Get.lazyPut(() => ChatRepo(apiClient: Get.find(), sharedPreferences:  Get.find()));
  Get.lazyPut(() => NotificationRepo(apiClient: Get.find(), sharedPreferences:  Get.find()));
  Get.lazyPut(() => WalletRepo(apiClient: Get.find()));
  Get.lazyPut(() => RiderRepo(apiClient: Get.find()));


  // Controller
  Get.lazyPut(() => OnBoardingController(onboardingRepo: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => ProfileController(profileRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: sharedPreferences));
  Get.lazyPut(() => LocationController(sharedPreferences: sharedPreferences));
  Get.lazyPut(() => TrackerController(trackerRepo: Get.find()));
  Get.lazyPut(() => RiderController(riderRepo : Get.find()));
  Get.lazyPut(() => ChatController(chatRepo: Get.find()));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
  Get.lazyPut(() => WalletController(walletRepo: Get.find()));
  Get.lazyPut(() => BottomMenuController());


  // Retrieving localized data
  Map<String, Map<String, String>> _languages = {};
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = {};
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
  }
  return _languages;
}
