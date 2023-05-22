import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:medosedoDelivery/controller/splash_controller.dart';
import 'package:medosedoDelivery/utill/dimensions.dart';
import 'package:medosedoDelivery/view/base/custom_home_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class HtmlViewerScreen extends StatelessWidget {
  final bool isPrivacyPolicy;
  const HtmlViewerScreen({Key key, @required this.isPrivacyPolicy}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String _data = isPrivacyPolicy ?
    Get.find<SplashController>().configModel.privacyPolicy :
    Get.find<SplashController>().configModel.termsConditions;

    return Scaffold(
      appBar: CustomRiderAppBar(title: isPrivacyPolicy ? 'privacy_policy'.tr : 'terms_and_condition'.tr, isBack: true,),

      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).cardColor,

        child: SingleChildScrollView(
          padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
          physics: const BouncingScrollPhysics(),
          child: HtmlWidget(_data,
            key: Key(isPrivacyPolicy ? 'privacy_policy' : 'terms_and_condition'),
            onTapUrl: (String url) {
              launchUrl(Uri.parse(url));
              return;
            },
          ),
        ),
      ),
    );
  }
}