
import 'package:get/get.dart';
import 'package:medosedoDelivery/controller/splash_controller.dart';
import 'package:medosedoDelivery/view/base/custom_snackbar.dart';
import 'package:medosedoDelivery/view/screens/auth/login_screen.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<SplashController>().removeSharedData();
      // ignore: prefer_const_constructors
      Get.to(() => LoginScreen());
    }else {
      showCustomSnackBar(response.statusText);
    }
  }
}