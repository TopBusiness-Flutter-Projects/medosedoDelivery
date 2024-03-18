import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medosedoDelivery/controller/order_controller.dart';
import 'package:medosedoDelivery/controller/profile_controller.dart';
import 'package:medosedoDelivery/controller/splash_controller.dart';
import 'package:medosedoDelivery/utill/images.dart';
import 'package:medosedoDelivery/view/base/confirmation_dialog.dart';
import 'package:medosedoDelivery/view/base/custom_image.dart';
import 'package:medosedoDelivery/view/base/flutter_custom_switch.dart';

class OnlineOfflineButton extends StatelessWidget {
  final bool showProfileImage;
  const OnlineOfflineButton({Key? key, this.showProfileImage = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
      return GetBuilder<OrderController>(builder: (orderController) {
        return (profileController.profileModel != null &&
                orderController.currentOrders != null)
            ? FlutterCustomSwitch(
                width: MediaQuery.of(context).size.width / 4.5,
                height: showProfileImage
                    ? MediaQuery.of(context).size.width / 12
                    : MediaQuery.of(context).size.width / 12,
                valueFontSize: 12,
                showOnOff: true,
                activeText: 'online'.tr,
                inactiveText: 'offline'.tr,
                activeColor:
                    Theme.of(context).colorScheme.outline.withOpacity(.25),
                activeTextColor:
                    Theme.of(context).colorScheme.outline.withOpacity(.75),
                activeToggleBorder: Border.all(
                    color: showProfileImage
                        ? Theme.of(context).colorScheme.outline
                        : Theme.of(context).primaryColor,
                    width: 2),
                toggleSize: MediaQuery.of(context).size.width / 16,
                inactiveToggleBorder: Border.all(
                    color: showProfileImage
                        ? Theme.of(context).hintColor
                        : Theme.of(context).primaryColor,
                    width: 2),
                activeIcon: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CustomImage(
                    image:
                        '${Get.find<SplashController>().baseUrls!.reviewImageUrl}/delivery-man/${Get.find<ProfileController>().profileModel!.image}',
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
                inactiveIcon: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CustomImage(
                    image:
                        '${Get.find<SplashController>().baseUrls!.reviewImageUrl}/delivery-man/${Get.find<ProfileController>().profileModel!.image}',
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
                value: profileController.profileModel!.isActive == 1
                    ? true
                    : false,
                onToggle: (bool isActive) async {
                  Get.dialog(ConfirmationDialog(
                    icon: Images.logo,
                    description: profileController.profileModel!.isActive == 1
                        ? 'are_you_sure_to_offline'.tr
                        : 'are_you_sure_to_online'.tr,
                    onYesPressed: () {
                      if (isActive) {
                        profileController.profileStatusChange(context, 1);
                      } else {
                        profileController.profileStatusChange(context, 0);
                      }
                    },
                  ));
                },
              )
            : const SizedBox();
      });
    });
  }
}
