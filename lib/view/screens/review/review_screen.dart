import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medosedoDelivery/controller/profile_controller.dart';
import 'package:medosedoDelivery/data/model/response/order_model.dart';
import 'package:medosedoDelivery/view/base/custom_home_app_bar.dart';
import 'package:medosedoDelivery/view/base/custom_loader.dart';
import 'package:medosedoDelivery/view/base/no_data_screen.dart';
import 'package:medosedoDelivery/view/screens/review/widget/filter_button.dart';
import 'package:medosedoDelivery/view/screens/review/widget/review_list.dart';

class ReviewScreen extends StatefulWidget {
  final OrderModel? orderModel;
  const ReviewScreen({Key? key, this.orderModel}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final ScrollController _scrollController = ScrollController();
   String? type;

  @override
  void initState() {
    super.initState();
    Get.find<ProfileController>().getReviewList(1);
    type = Get.find<ProfileController>().reviewTypeList.first;


  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
      return Scaffold(
        appBar: CustomRiderAppBar(title: 'my_reviews'.tr,isBack: true,),
        body: Column(children: [
          FilterButtonWidget(
            isBorder: true,
            items: profileController.reviewTypeList,
            type: type,
            onSelected: (_type){

            type = _type;
            profileController.update();
            profileController.setSelectedReviewType = _type;
            Get.find<ProfileController>().getReviewList(1);


          },),

          !profileController.isLoading && profileController.reviewModel != null?
          (profileController.reviewModel!.review != null && profileController.reviewModel!.review!.isNotEmpty) ?
          Expanded(child: ReviewListView(profileController: profileController, scrollController: _scrollController)) :
          const NoDataScreen(): Expanded(child: CustomLoader(height: Get.height-300,)),
        ]),
      );
    }
    );
  }
}
