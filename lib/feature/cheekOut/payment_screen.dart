import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_button.dart';
import 'package:lms_user_app/controller/payment_controller.dart';
import 'package:lms_user_app/core/helper/help_me.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      builder: (paymentController) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'payment_gateway'.tr,
              style: robotoRegular,
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      InAppWebView(
                        key: paymentController.webViewKey,
                        initialUrlRequest:
                            paymentController.makePaymentRequest(),
                        initialUserScripts:
                            UnmodifiableListView<UserScript>([]),
                        initialOptions: paymentController.options,
                        pullToRefreshController:
                            paymentController.pullToRefreshController,
                        onWebViewCreated: (controller) {
                          paymentController.webViewController = controller;
                        },
                        onLoadStart: (controller, url) {
                          printLog("------payment onLoadStart(): ${url!}");
                          if (url.path.contains('/complete-order')) {
                            paymentController.isPaymentSuccessUpdate(true);
                          }
                        },
                        androidOnPermissionRequest:
                            (controller, origin, resources) async {
                          return PermissionRequestResponse(
                              resources: resources,
                              action: PermissionRequestResponseAction.GRANT);
                        },
                        shouldOverrideUrlLoading:
                            (controller, navigationAction) async {
                          return NavigationActionPolicy.ALLOW;
                        },
                        onLoadStop: (controller, url) async {
                          printLog("------payment onLoadStop(): $url");
                          if (url == paymentController.successUri()) {
                            // Get.offAllNamed(RouteHelper.paymentConfirm);
                          }
                          paymentController.isLoadingUpdate(false);
                          paymentController.pullToRefreshController
                              .endRefreshing();
                          paymentController.webViewController!
                              .evaluateJavascript(
                                  source: "javascript:(function() { "
                                      "var order = document.getElementById('order_btn');"
                                      "order.parentNode.removeChild(order);"
                                      "})()")
                              .then((value) => debugPrint(
                                  'Page finished loading Javascript'))
                              .catchError((onError) => debugPrint('$onError'));

                          paymentController.webViewController!
                              .evaluateJavascript(
                                  source: "javascript:(function() { "
                                      "var shipping = document.getElementById('shipping_btn');"
                                      "shipping.parentNode.removeChild(shipping);"
                                      "})()")
                              .then((value) => debugPrint(
                                  'Page finished loading Javascript'))
                              .catchError((onError) => debugPrint('$onError'));
                        },
                        onLoadError: (controller, url, code, message) {
                          paymentController.pullToRefreshController
                              .endRefreshing();
                        },
                        onProgressChanged: (controller, progress) {
                          paymentController.progressUpdate(progress);

                          if (progress == 100) {
                            paymentController.pullToRefreshController
                                .endRefreshing();
                          }
                        },
                        onUpdateVisitedHistory:
                            (controller, url, androidIsReload) {},
                        onConsoleMessage: (controller, consoleMessage) {
                          printLog(
                              "-----payment console message: ${consoleMessage.message}");
                        },
                      ),
                      /* paymentController.isLoading
                          ? const Center(child: LoaderWidget())
                          : Container(),*/
                      Positioned(
                        bottom: 100,
                        child: Column(
                          children: [
                            paymentController.showButton
                                ? SizedBox(
                                    width: 160,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Get.toNamed(RouteHelper.dashboardScreen);
                                      },
                                      child: const Text("Continue Shopping"),
                                    ),
                                  )
                                : Container(),
                            paymentController.showButton
                                ? SizedBox(
                                    width: 160,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Get.toNamed(RouteHelper.categoryContent);
                                      },
                                      child: const Text('View Order'),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                if(paymentController.isPaymentSuccess)
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: CustomButton(
                    height: 40, width: 200,
                    buttonText: 'start_learning'.tr,
                    onPressed: () => Get.offAllNamed(RouteHelper.getMainRoute("payment_screen")),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
