import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  width: 57,
                  child: Image.asset(
                    Images.splash,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("#254DH5S68HE",
                      style: robotoSemiBold.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: Dimensions.fontSizeSmall
                      ),
                    ),
                    Text("11-02-2023 05:45 pm",
                      style: robotoSemiBold.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: Dimensions.fontSizeSmall
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeSmall,
                ),
                userInfoWidget(context,'Name'.tr,"Jonsina Vikta"),
                userInfoWidget(context,'email'.tr,"jonsina@gmail.com"),
                userInfoWidget(context,'phone'.tr,"012345678910"),
                userInfoWidget(context,'payment_type'.tr,"bKash"),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColorLight,
                        width: 1,
                      )
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 35,
                        color: Theme.of(context).primaryColorLight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Product",
                              style: robotoSemiBold.copyWith(
                                  color: Theme.of(context).textTheme.bodyLarge!.color,
                                  fontSize: Dimensions.fontSizeSmall
                              ),
                            ),
                            SizedBox(
                              width: 220,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Sub Total",
                                    style: robotoSemiBold.copyWith(
                                        color: Theme.of(context).textTheme.bodyLarge!.color,
                                        fontSize: Dimensions.fontSizeSmall
                                    ),
                                  ),
                                  Text("Quantity",
                                    style: robotoSemiBold.copyWith(
                                        color: Theme.of(context).textTheme.bodyLarge!.color,
                                        fontSize: Dimensions.fontSizeSmall
                                    ),
                                  ),
                                  Text("Total",
                                    style: robotoSemiBold.copyWith(
                                        color: Theme.of(context).textTheme.bodyLarge!.color,
                                        fontSize: Dimensions.fontSizeSmall
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                        itemBuilder: (context, index){
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.paddingSizeSmall,
                                      right: Dimensions.paddingSizeSmall,
                                      top: index==0 ? Dimensions.paddingSizeSmall:0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text("Mathematics with Animated Video ",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: robotoRegular.copyWith(
                                              color: Theme.of(context).textTheme.bodyLarge!.color,
                                              fontSize: Dimensions.fontSizeSmall
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 220,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("\$205.00",
                                              style: robotoRegular.copyWith(
                                                  color: Theme.of(context).textTheme.bodyLarge!.color,
                                                  fontSize: Dimensions.fontSizeSmall
                                              ),
                                            ),
                                            Text("01",
                                              style: robotoRegular.copyWith(
                                                  color: Theme.of(context).textTheme.bodyLarge!.color,
                                                  fontSize: Dimensions.fontSizeSmall
                                              ),
                                            ),
                                            Text("\$205.00",
                                              style: robotoRegular.copyWith(
                                                  color: Theme.of(context).textTheme.bodyLarge!.color,
                                                  fontSize: Dimensions.fontSizeSmall
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Theme.of(context).primaryColorLight,
                                  thickness: 1,
                                ),
                              ],
                            );
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width/2.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('sub_total'.tr,
                                      style: robotoRegular.copyWith(
                                          color: Theme.of(context).textTheme.bodyLarge!.color,
                                          fontSize: Dimensions.fontSizeSmall
                                      ),
                                    ),
                                    Text("\$761.50",
                                      style: robotoRegular.copyWith(
                                          color: Theme.of(context).textTheme.bodyLarge!.color,
                                          fontSize: Dimensions.fontSizeSmall
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: Dimensions.paddingSizeSmall,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width/2.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('discount'.tr,
                                      style: robotoRegular.copyWith(
                                          color: Theme.of(context).textTheme.bodyLarge!.color,
                                          fontSize: Dimensions.fontSizeSmall
                                      ),
                                    ),
                                    Text("\$00.00",
                                      style: robotoRegular.copyWith(
                                          color: Theme.of(context).textTheme.bodyLarge!.color,
                                          fontSize: Dimensions.fontSizeSmall
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: Dimensions.paddingSizeSmall,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width/2.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('coupon'.tr,
                                      style: robotoRegular.copyWith(
                                          color: Theme.of(context).textTheme.bodyLarge!.color,
                                          fontSize: Dimensions.fontSizeSmall
                                      ),
                                    ),
                                    Text("\$00.00",
                                      style: robotoRegular.copyWith(
                                          color: Theme.of(context).textTheme.bodyLarge!.color,
                                          fontSize: Dimensions.fontSizeSmall
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width/2.2,
                                  child: const Divider()),
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width/2.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('total'.tr,
                                      style: robotoSemiBold.copyWith(
                                        color: Theme.of(context).textTheme.bodyLarge!.color,
                                        fontSize: Dimensions.fontSizeSmall
                                      ),
                                    ),
                                    Text("\$761.50",
                                      style: robotoSemiBold.copyWith(
                                          color: Theme.of(context).textTheme.bodyLarge!.color,
                                          fontSize: Dimensions.fontSizeSmall
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: Dimensions.paddingSizeSmall,),
                            ],
                          ),
                        ),
                      )

                    ],
                  ),
                ),

                Container(
                  //height: 118,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.02),
                  child: Row(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Text('Seller Information',
                              style: robotoSemiBold.copyWith(
                                  color: Theme.of(context).textTheme.bodyLarge!.color,
                                  fontSize: Dimensions.fontSizeSmall
                              ),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            userInfoWidget(context,'Name'.tr,"Gupal Vikta"),
                            const SizedBox(height: Dimensions.paddingSizeMint),
                            userInfoWidget(context,'email'.tr,"jonsina@gmail.com"),
                            const SizedBox(height: Dimensions.paddingSizeMint),
                            userInfoWidget(context,'phone'.tr,"012345678910"),
                            const SizedBox(height: Dimensions.paddingSizeMint),
                            userInfoWidget(context,'payment_type'.tr,"bKash"),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2-20,
                        height: 120,
                        alignment: Alignment.bottomLeft,
                        child:  Text("address: Lake CityConcord Khilkhet Dhaka-1229",
                          style: robotoRegular.copyWith(
                              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                              fontSize: Dimensions.fontSizeSmall
                          ),
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget userInfoWidget(context,String title,String info){
    return Column(
      children: [
        Text("$title: $title",
          style: robotoRegular.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
              fontSize: Dimensions.fontSizeSmall
          ),
        )
      ],
    );
  }
}
