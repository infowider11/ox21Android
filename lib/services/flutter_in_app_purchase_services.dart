import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

import '../constants/sized_box.dart';
/// sampled purchased product id : android.test.purchased
class FlutterInAppPurchaseServices{

  static late StreamSubscription<List<PurchaseDetails>> _subscription;
   Future<void> initData()async{
    final Stream purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription = (purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    }) as StreamSubscription<List<PurchaseDetails>>);
  }
  Set<String> _kIds = <String>{
    // 'android.test.purchased',
  };
  late ProductDetailsResponse response;

   Future<bool> getInAppPurchaseRequirements(String productId) async {
    print('inside in app purchase requirements');
    // _kIds.add(templates[index].productId);
    _kIds.add(productId);
    // _kIds.add('android.test.purchased');

    print(_kIds);

    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      print('is not available');
      return false;
      // await ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('is not available'))
      // );
      // The store cannot be reached or accessed. Update the UI accordingly.
    } else {
      print('is available');
    }
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      print('inside on done');
      _subscription.cancel();
    }, onError: (error) {
      print('inside on error $error');
      // handle error here.
    }) as StreamSubscription<List<PurchaseDetails>>;
    // _subscription.;_subscription
    response = await InAppPurchase.instance.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      print(response.notFoundIDs);
      print('the product is not found');
      return false;
      // await ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('${response.notFoundIDs} is not found'))
      // );
    }
    print('the response is: $response');
    print(response.productDetails);
    // print(response.productDetails[0].toString());
    // print(response.productDetails[0].description);
    // print(response.productDetails[0].price);
    // print(response.productDetails[0].title);
    return true;
    // await ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('${response.notFoundIDs} is not found'))
    // );
  }

   void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // show pending ui
        // _showPendingUI();
        print('pending ui');
        // await ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('pending ui'))
        // );

      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          print('handle error ${purchaseDetails.error}');
          // await ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text('handle error ${purchaseDetails.error}'))
          // );
          // _handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = true;
          // bool valid = await _verifyPurchase(purchaseDetails);
          // if (valid) {
          //   // print('deliver product');
          //   // await ScaffoldMessenger.of(context).showSnackBar(
          //   //     SnackBar(content: Text('deliver product'))
          //   // );
          //   // _deliverProduct(purchaseDetails);
          // } else {
          //   await ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(content: Text('invalid purchase ${purchaseDetails}')));
          //   // _handleInvalidPurchase(purchaseDetails);
          // }
        }
        if (purchaseDetails.pendingCompletePurchase) {

          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

   Future<String> payAndDownload(BuildContext context) async {
    // widget.showLoading(true);
    String transactionId = '0';
    if (response.productDetails.length == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upcoming,
                        color: Colors.green,
                        size: 120,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'This Product will be available soon',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          );
        },
      );
    } else {
      // Navigator.pop(context, 'buy');

      List<ProductDetails> _products = [];
      final ProductDetails productDetails = response.productDetails[0];
      print('the product is ${productDetails.toString()}');

      print(productDetails.description);
      print(productDetails.title);
      print(productDetails.id);
      // Saved earlier from queryProductDetails().
      final PurchaseParam purchaseParam =
      PurchaseParam(productDetails: productDetails);
      // if (_isConsumable(productDetails)) {
      bool itemPurchased = await InAppPurchase.instance.buyConsumable(
        purchaseParam: purchaseParam,
      );
      // } else {
      // InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
      // }
      var s = await InAppPurchase.instance.purchaseStream.first;
      print('the in app purchase stream is: ${s.length}');
      // print(s);
      int i=0;
      s.toSet().forEach((purchaseDetails) async {
        print('The data is of ----------------${i}');
        i++;
        print(purchaseDetails.toString());
        print(purchaseDetails.productID);
        print(purchaseDetails.status);
        print(purchaseDetails.transactionDate);
        print(' the verification data is ');
        print(purchaseDetails.verificationData.serverVerificationData);
        print(purchaseDetails.verificationData.localVerificationData);
        print(purchaseDetails.toString());

        transactionId = purchaseDetails.purchaseID??'';
        print('the transactionId is $transactionId ______________');
        print('fkk ${purchaseDetails.toString()}');

        print(purchaseDetails.verificationData.source);

        if (purchaseDetails.status == PurchaseStatus.purchased) {
          var request ={
            'user_id': userId,
            'points': '240',
            'transaction_id': transactionId
          };
          var jsonResponse = await Webservices.postData(url: ApiUrls.add_points_by_in_app_purchase, request: request, context: context);
          // presentToast("Coming soon!");

          await showDialog(
            context: context,
            builder: (context) {
              print('hellloooo1o');
              return Dialog(
                child: Stack(
                  children: [
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: MyColors.primaryColor,
                            size: 120,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                              'Success',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          vSizedBox,
                          Text(
                           'Points purchase successful',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Text(
                          //   ';sdljfk;s',
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //       fontSize: 12, fontWeight: FontWeight.w300),
                          // ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 20,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          );
          print(' i ma here ');
          try{
            // widget.showLoading(false);
          }catch(e){
            print('Error in catch block 54 $e');
          }
          print('hurtrrya');
          // SQLServices sqlServices = SQLServices();
          // widget.templateModal.purchased = 1;
          // sqlServices.updateTemplate(widget.templateModal);
          // setState(() {
          //
          // });

        } else if (purchaseDetails.status == PurchaseStatus.canceled) {
          showSnackbar(context,'The Purchase was Cancelled');
          // widget.showLoading(false);
        } else if (purchaseDetails.status == PurchaseStatus.error) {
          showSnackbar(context,'Purchase cancelled due to an error');
          // widget.showLoading(false);
        } else if (purchaseDetails.status == PurchaseStatus.pending) {
          showSnackbar(context,'Purchase is Pending');
          // widget.showLoading(false);
        } else {
          showSnackbar(context,'Please try Again Later');
          // widget.showLoading(false);
        }
      });

      // presentToast('Coming Soon !');
      // showDialog<void>(context: context, builder: (context) => dialog);
    }
    print('the transactionId is $transactionId');
    print(transactionId);
    return transactionId;
  }


  // static void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
  //   purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
  //     if (purchaseDetails.status == PurchaseStatus.pending) {
  //       showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'Purchase status is Pendings');
  //     } else {
  //       if (purchaseDetails.status == PurchaseStatus.error) {
  //         // _handleError(purchaseDetails.error!);
  //         showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'Purchase status has some error ${purchaseDetails.error?.message}');
  //       } else if (purchaseDetails.status == PurchaseStatus.purchased ||
  //           purchaseDetails.status == PurchaseStatus.restored) {
  //         bool valid = await _verifyPurchase(purchaseDetails);
  //         if (valid) {
  //           // _deliverProduct(purchaseDetails);
  //         } else {
  //           _handleInvalidPurchase(purchaseDetails);
  //         }
  //       }
  //       if (purchaseDetails.pendingCompletePurchase) {
  //         await InAppPurchase.instance
  //             .completePurchase(purchaseDetails);
  //       }
  //     }
  //   });
  // }
}