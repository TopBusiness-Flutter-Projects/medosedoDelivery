import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:medosedoDelivery/controller/menu_controller.dart';
import 'package:medosedoDelivery/controller/order_controller.dart';
import 'package:medosedoDelivery/helper/notification_helper.dart';
import 'package:medosedoDelivery/utill/color_resources.dart';
import 'package:medosedoDelivery/utill/dimensions.dart';
import 'package:medosedoDelivery/utill/images.dart';
import 'package:medosedoDelivery/utill/styles.dart';
import 'package:medosedoDelivery/view/base/animated_custom_dialog.dart';
import 'package:medosedoDelivery/view/base/confirmation_dialog.dart';
import 'package:medosedoDelivery/view/base/custom_botom_navy_bar.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  const DashboardScreen({Key? key, required this.pageIndex}) : super(key: key);
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    Get.find<BottomMenuController>().selectHomePage(first: false);
    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin!.initialize(initializationsSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("onMessage: ${message.data}");
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin, false);
      if (message != null) {
        Get.find<OrderController>().getCurrentOrders(context);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("onMessageOpenedApp: ${message.data}");
      if (message != null) {
        Get.find<OrderController>().getCurrentOrders(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onWillPop(context);
        return true;
      },
      child: GetBuilder<BottomMenuController>(builder: (menuController) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body:
              PageStorage(bucket: bucket, child: menuController.currentScreen!),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: menuController.currentTab,
            showElevation: true,
            animationDuration: const Duration(milliseconds: 500),
            itemCornerRadius: 24,
            curve: Curves.ease,
            items: [
              _barItem(Images.homeIcon, 'home'.tr, 0, menuController),
              _barItem(Images.orderIcon, 'order_history'.tr, 1, menuController),
              _barItem(Images.chatIcon, 'message'.tr, 2, menuController),
              _barItem(Images.notificationMenuIcon, 'notification'.tr, 3,
                  menuController),
              _barItem(Images.profileIcon, 'profile'.tr, 4, menuController),
            ],
            onItemSelected: (int index) {
              if (index == 0) {
                menuController.selectHomePage();
              } else if (index == 1) {
                menuController.selectOrderHistoryScreen();
              } else if (index == 2) {
                menuController.selectConversationScreen();
              } else if (index == 3) {
                menuController.selectNotificationScreen();
              } else if (index == 4) {
                menuController.selectProfileScreen();
              }
            },
          ),
        );
      }),
    );
  }

  BottomNavyBarItem _barItem(String icon, String label, int index,
      BottomMenuController menuController) {
    return BottomNavyBarItem(
      activeColor: Theme.of(context).primaryColor,
      textAlign: TextAlign.center,
      icon: index == menuController.currentTab
          ? const SizedBox()
          : SizedBox(
              width: Dimensions.iconSizeMenu,
              child: Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Image.asset(icon,
                    color: index == menuController.currentTab
                        ? ColorResources.colorWhite
                        : ColorResources.colorGrey),
              )),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: Dimensions.iconSizeMedium,
              child: Image.asset(icon,
                  color: index == menuController.currentTab
                      ? ColorResources.colorWhite
                      : ColorResources.colorGrey)),
          Flexible(
            fit: FlexFit.tight,
            child: Text(label,
                maxLines: 1,
                style: rubikRegular.copyWith(
                    color: index == menuController.currentTab
                        ? Colors.white
                        : ColorResources.colorGrey,
                    fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

Future<bool> _onWillPop(BuildContext context) async {
  showAnimatedDialog(
      context,
      ConfirmationDialog(
        icon: Images.logOut,
        title: 'exit_app'.tr,
        description: 'do_you_want_to_exit_the_app'.tr,
        onYesPressed: () {
          SystemNavigator.pop();
        },
      ),
      isFlip: true);

  return true;
}
