import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medosedoDelivery/controller/localization_controller.dart';
import 'package:medosedoDelivery/controller/splash_controller.dart';
import 'package:medosedoDelivery/utill/dimensions.dart';
import 'package:medosedoDelivery/utill/styles.dart';

class CalculationWidget extends StatelessWidget {
  final String? title;
  final double? amount;
  final bool isTotalAmount;
  final bool isWithdrawable;
  final Function? onTap;
  const CalculationWidget(
      {Key? key,
      this.title,
      this.amount,
      this.isTotalAmount = false,
      this.isWithdrawable = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Padding(
        padding: EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 2.5,
              padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(.5)),
                borderRadius:
                    BorderRadius.circular(Dimensions.paddingSizeSmall),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                          '${Get.find<SplashController>().myCurrency!.symbol} ${NumberFormat.compact().format(amount)}',
                          style: rubikBold.copyWith(
                              color: Colors.white,
                              fontSize: Dimensions.fontSizeLarge)),
                    ),
                    Text(
                      title!,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: rubikRegular.copyWith(
                          color: Colors.white,
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ],
                ),
              ),
            ),
            isWithdrawable
                ? Container(
                    transform: Get.find<LocalizationController>().isLtr
                        ? Matrix4.translationValues(-25, -25, 0)
                        : Matrix4.translationValues(25, -25, 0),
                    child: Icon(
                      CupertinoIcons.arrow_right_circle_fill,
                      size: Dimensions.iconSizeLarge,
                      color: Get.isDarkMode
                          ? Theme.of(context).hintColor.withOpacity(.5)
                          : Colors.white,
                    ))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
