import 'package:flutter/material.dart';
import 'package:medosedoDelivery/controller/wallet_controller.dart';
import 'package:medosedoDelivery/data/model/response/withdraw_model.dart';
import 'package:get/get.dart';
import 'package:medosedoDelivery/helper/date_converter.dart';
import 'package:medosedoDelivery/helper/price_converter.dart';
import 'package:medosedoDelivery/utill/dimensions.dart';
import 'package:medosedoDelivery/utill/images.dart';
import 'package:medosedoDelivery/utill/styles.dart';
import 'package:medosedoDelivery/view/screens/order/widget/custom_divider.dart';

class WithdrawCardWidget extends StatelessWidget {
  final Withdraws? withdraws;
  const WithdrawCardWidget({Key? key, this.withdraws}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,Dimensions.paddingSizeSmall,Dimensions.paddingSizeDefault,Dimensions.paddingSizeSmall,),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Row(children: [
          Padding(
            padding:  EdgeInsets.only(right: Dimensions.paddingSizeSmall),
            child: SizedBox(width:Dimensions.iconSizeDefault,
                child: Image.asset(Get.find<WalletController>().selectedItem == 1?Images.withdrawn : Images.pendingWithdraw)),
          ),
          Expanded(child: Text(DateConverter.isoStringToDateTimeString(withdraws!.updatedAt!).toString(),
            style: rubikRegular.copyWith(color: Theme.of(context).hintColor,
                fontSize: Dimensions.fontSizeSmall),)),
          Container(decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(.1)

          ),
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),
            child: Text(' ${PriceConverter.convertPrice(withdraws!.amount)}',
                style: rubikMedium.copyWith(color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).colorScheme.onTertiaryContainer)),),

        ],),

        Padding(
          padding:  EdgeInsets.only(top: Dimensions.paddingSizeLarge),
          child: CustomDivider(height: .5,color: Theme.of(context).hintColor,),
        )

      ],),);
  }
}
