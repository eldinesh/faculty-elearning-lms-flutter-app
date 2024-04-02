// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lms_user_app/feature/conversation/controller/conversation_controller.dart';
// import 'package:lms_user_app/utils/dimensions.dart';
// import 'package:lms_user_app/utils/images.dart';
// import 'package:lms_user_app/utils/styles.dart';

// class CreateChannelDialog extends StatefulWidget {
//   final String? referenceId;
//   final String? customerID;
//   final String? serviceManId;
//   final String? providerId;

//   const CreateChannelDialog(
//       {super.key,
//         this.referenceId,
//         this.customerID,
//         this.serviceManId,
//         this.providerId,
//       });

//   @override
//   State<CreateChannelDialog> createState() => _ProductBottomSheetState();
// }

// class _ProductBottomSheetState extends State<CreateChannelDialog> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //if(ResponsiveHelper.isDesktop(context))
//       return  Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
//         insetPadding: const EdgeInsets.all(30),
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         child: pointerInterceptor(),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       );
//     return pointerInterceptor();
//   }

//   pointerInterceptor(){
//     String imageBaseUrl = "";
//     return Container(
//         width: Dimensions.paddingSizeSmall,
//         margin: const EdgeInsets.symmetric(horizontal: 0),
//         padding: const EdgeInsets.only(
//             left: Dimensions.paddingSizeDefault,
//             bottom: Dimensions.paddingSizeDefault),
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardColor,
//           borderRadius: const BorderRadius.only(
//             topRight: Radius.circular(20),
//             topLeft: Radius.circular(20),
//             bottomLeft: Radius.circular(0),
//             bottomRight: Radius.circular(0),
//           ),
//         ),
//         child: GetBuilder<ConversationController>(
//             initState: (state){
//               Get.find<ConversationController>().getChannelListBasedOnReferenceId(1,widget.referenceId!);
//             },
//             builder: (conversationController) {
//               return SingleChildScrollView(
//                 child: Column(

//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//                         child: Container(
//                           height: 35, width: 35, alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white70.withOpacity(0.6),
//                               boxShadow:Get.isDarkMode?null: [
//                                 BoxShadow(
//                                   color: Colors.grey[300]!,
//                                   blurRadius: 2,
//                                   spreadRadius: 1,
//                                 )
//                               ]
//                           ),
//                           child: InkWell(
//                               onTap: () => Get.back(),
//                               child: const Icon(
//                                 Icons.close,
//                                 color: Colors.black54,
//                               )
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           right: Dimensions.paddingSizeDefault,
//                           top:  Dimensions.paddingSizeDefault,
//                         ),
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text('create_channel_with_provider'.tr,style: robotoBold,),
//                               const SizedBox(height: Dimensions.paddingSizeLarge,),

//                               Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     if(widget.providerId == null)
//                                       TextButton(
//                                         onPressed:(){
//                                           String name = "name";
//                                           String image = Images.logo;
//                                           Get.find<ConversationController>().createChannel(
//                                               widget.providerId!,
//                                               widget.referenceId!,
//                                               name: name,
//                                               image: image
//                                           );
//                                         },
//                                         style: TextButton.styleFrom(
//                                           backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3),
//                                           minimumSize:  const Size(Dimensions.paddingSizeLarge, 40),
//                                           padding:  const EdgeInsets.symmetric(
//                                               vertical: Dimensions.paddingSizeSmall,
//                                               horizontal: Dimensions.paddingSizeLarge
//                                           ),
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(Dimensions.paddingSizeLarge),
//                                           ),
//                                         ),
//                                         child: Text('provider'.tr,
//                                           textAlign: TextAlign.center,
//                                           style: robotoBold.copyWith(
//                                               color: Theme.of(context).textTheme.bodyLarge!.color),
//                                         ),
//                                       ),
//                                     const SizedBox(width: Dimensions.paddingSizeSmall),
//                                     if(widget.serviceManId == null)
//                                       TextButton(
//                                         onPressed:(){
//                                           String name = "firstName";
//                                           String image = Images.logo;
//                                           Get.find<ConversationController>().createChannel(
//                                               widget.serviceManId!,
//                                               widget.referenceId!,
//                                               name: name,
//                                               image: image
//                                           );
//                                         },
//                                         style: TextButton.styleFrom(
//                                           backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3),
//                                           minimumSize:  const Size(Dimensions.paddingSizeLarge, 40),
//                                           padding:  const EdgeInsets.symmetric(
//                                               vertical: Dimensions.paddingSizeSmall,
//                                               horizontal: Dimensions.paddingSizeSmall
//                                           ),
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
//                                           ),
//                                         ),
//                                         child: Text(
//                                           'service_man'.tr, textAlign: TextAlign.center,
//                                           style: robotoBold.copyWith(
//                                               color: Theme.of(context).textTheme.bodyLarge!.color),
//                                         ),
//                                       ),
//                                   ],
//                               ),
//                               const SizedBox(height: Dimensions.paddingSizeSmall),
//                             ],
//                         ),
//                       ),
//                     ],
//                 ),
//               );
//             },
//         ),
//     );
//   }
// }
