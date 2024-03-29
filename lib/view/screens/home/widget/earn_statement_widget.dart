import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:medosedoDelivery/controller/profile_controller.dart';
import 'package:medosedoDelivery/controller/splash_controller.dart';
import 'package:medosedoDelivery/helper/price_converter.dart';
import 'package:medosedoDelivery/utill/dimensions.dart';
import 'package:medosedoDelivery/utill/styles.dart';
import 'package:medosedoDelivery/view/base/calculation_widget.dart';
import 'package:medosedoDelivery/view/base/custom_image.dart';
import 'package:medosedoDelivery/view/screens/wallet/wallet_screen.dart';

class EarnStatementWidget extends StatelessWidget {
  const EarnStatementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GetBuilder<ProfileController>(builder: (profileController) {
        return Container(
          height: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.paddingSizeDefault),
                  bottomRight: Radius.circular(Dimensions.paddingSizeDefault))),
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor.withOpacity(.05),
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(500))))),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.paddingSizeExtraLarge),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColorLight
                                          .withOpacity(.25),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CustomImage(
                                          image:
                                              '${Get.find<SplashController>().baseUrls!.reviewImageUrl}/delivery-man/${Get.find<ProfileController>().profileImage}',
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.cover))),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        Dimensions.paddingSizeSmall, 0, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Get.find<ProfileController>()
                                                    .profileModel !=
                                                null
                                            ? Text(
                                                '${'hi'.tr}, ${Get.find<ProfileController>().profileModel!.fName ?? ''} ${Get.find<ProfileController>().profileModel!.lName}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: rubikRegular.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: Dimensions
                                                        .fontSizeDefault),
                                              )
                                            : const SizedBox(),
                                      ],
                                    )),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // const Text(''),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          Dimensions.paddingSizeSmall,
                                          0,
                                          0,
                                          Dimensions.paddingSizeSmall),
                                      child: Text(
                                        ' ${PriceConverter.convertPrice(Get.find<ProfileController>().profileModel!.currentBalance)}',
                                        style: rubikMedium.copyWith(
                                            color: Colors.white,
                                            fontSize:
                                                Dimensions.fontSizeExtraLarge),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          Dimensions.paddingSizeSmall,
                                          0,
                                          0,
                                          Dimensions.paddingSizeDefault),
                                      child: Text(
                                        'current_balance'.tr,
                                        style: rubikRegular.copyWith(
                                            color: Colors.white,
                                            fontSize: Dimensions.fontSizeLarge),
                                      )),
                                ],
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(height: Dimensions.paddingSizeDefault),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 4,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CalculationWidget(
                              title: 'cash_in_hand'.tr,
                              amount:
                                  profileController.profileModel!.cashInHand,
                              isTotalAmount: true),
                          CalculationWidget(
                            title: 'pending_withdraw'.tr,
                            amount:
                                profileController.profileModel!.pendingWithdraw,
                          ),
                          CalculationWidget(
                              title: 'withdrawn'.tr,
                              amount: profileController
                                  .profileModel!.totalWithdraw),
                          CalculationWidget(
                            title: 'withdrawable_balance'.tr,
                            amount: profileController
                                .profileModel!.withdrawableBalance,
                            isWithdrawable: true,
                            onTap: () => Get.to(const WalletScreen()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    ]);
  }
}
