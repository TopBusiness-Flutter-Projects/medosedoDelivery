import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medosedoDelivery/controller/localization_controller.dart';
import 'package:medosedoDelivery/data/model/response/order_model.dart';
import 'package:medosedoDelivery/helper/date_converter.dart';
import 'package:medosedoDelivery/utill/dimensions.dart';
import 'package:medosedoDelivery/utill/images.dart';
import 'package:medosedoDelivery/utill/styles.dart';
import 'package:medosedoDelivery/view/screens/order/order_details_screen.dart';
import 'package:medosedoDelivery/view/screens/order/widget/cal_chat_widget.dart';
import 'package:medosedoDelivery/view/screens/order/widget/customer_info_widget.dart';


class OrderHistoryItemWidget extends StatelessWidget {
  final OrderModel? orderModel;
  const OrderHistoryItemWidget({Key? key, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(OrderDetailsScreen(orderModel: orderModel)),
      child: Padding(
        padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall, bottom : Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall),
        child: Container(
          padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(color: Theme.of(context).cardColor,
            boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125),
                spreadRadius: .7, blurRadius: 2, offset: const Offset(0, 1))],
            borderRadius: BorderRadius.circular(10)),


          child: Stack(
            children: [
              Positioned(
                child: Align(
                  alignment: Get.find<LocalizationController>().isLtr? Alignment.topRight: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(width: Get.find<LocalizationController>().isLtr? Get.context!.width<= 400? 160 : 170 :Get.context!.width<= 400? 140 : 150,
                      child: Column(children: [
                        Row(children: [
                          Row(
                            children: [
                              Text('${'assigned'.tr} : ',style: rubikRegular.copyWith(color: Theme.of(context).hintColor, fontSize: 13),),
                              Text(DateConverter.isoStringToLocalDateOnly(orderModel!.createdAt!), style: rubikRegular.copyWith(fontSize: 10),),
                            ],
                          ),
                           SizedBox(width: Dimensions.paddingSizeSmall),
                          SizedBox(width: Dimensions.iconSizeDefault, child: Image.asset(Images.calenderIcon,
                              color: Theme.of(context).primaryColor.withOpacity(.5)))
                        ],),
                        orderModel!.expectedDate != null?
                        Padding(
                          padding:  EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                          child: Row(
                            children: [
                              Text('${'expected_date'.tr} : ',
                                style: rubikRegular.copyWith(color: Theme.of(context).hintColor, fontSize: 10),),
                              Text(orderModel!.expectedDate!, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
                                //style: rubikRegular.copyWith(color: Theme.of(context).hintColor, fontSize: 10),),
                             // Text(orderModel.expectedDate, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
                            ],
                          ),
                        ): const SizedBox(),


                      ]),
                    ),
                  ),
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 5,top: Dimensions.paddingSizeSmall),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Expanded(
                          child: Text('${'order'.tr} #${orderModel!.id}',
                              style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge,
                                  color: Theme.of(context).colorScheme.secondary)),
                        ),



                      ]),
                    ),
                    Padding(
                      padding:  EdgeInsets.fromLTRB( Dimensions.paddingSizeDefault,
                          Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
                      child: CustomerInfoWidget(orderModel: orderModel, showCustomerImage: true),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0, -10, 0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                        child: CallAndChatWidget(orderModel: orderModel),
                      ),
                    ),

              ]),
            ],
          ),
        ),
      ),
    );
  }
}
