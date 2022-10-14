import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/complete_domain_purchase_page.dart';
import 'package:ox21/pages/complete_top_banner_payment_page.dart';
import 'package:ox21/pages/domain_purchase_successful.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:flutter_translate/flutter_translate.dart';
enum PurchaseCurrency{
  coins, btc, usd, jin
}
class Cart extends StatefulWidget {
  static const String id = "cart";
  final Map<String, dynamic> domainData;
  final double totalCost;
  final PurchaseCurrency purchaseCurrency;
  // final int coins;
  const Cart({
    Key? key,
    required this.domainData,
    // required this.coins,
    required this.totalCost,
    required this.purchaseCurrency
  }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  TextEditingController searchController = TextEditingController();
  bool load = false;
  String price = '';
  getConversionRate()async{
    setState(() {
       load = true;
    });
    if(widget.purchaseCurrency==PurchaseCurrency.btc){
      String conversionRate = await Webservices.getLiveConversionRateBTCToUSD();
      price = ((double.parse(widget.domainData['usdCost'].toString()))/double.parse(conversionRate)).toStringAsFixed(2);
      print('the proce is $price');
      if(price=='0.00'){
        showSnackbar(context, translate("cart.smallAount"));
        Navigator.pop(context);
      }
    }
    else{
      price = widget.purchaseCurrency==PurchaseCurrency.usd?widget.domainData['usdCost'].toString():widget.purchaseCurrency==PurchaseCurrency.jin?widget.domainData['jinCost'].toString():widget.domainData['coins'].toString();

    }
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getConversionRate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context: context,
          title: translate("cart.yourCart"),
          titleColor: MyColors.primaryColor),
      body:load?CustomLoader(): Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ParagraphText(
                        text: translate("cart.items"),
                        fontFamily: 'bold',
                        fontSize: 12,
                        color: Color(0xFF525252),
                      ),
                      ParagraphText(
                        text:translate("cart.items"),
                        fontFamily: 'bold',
                        fontSize: 12,
                        color: Color(0xFF525252),
                      ),
                    ],
                  ),
                  vSizedBox4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                           ParagraphText(
                            text: translate("cart.domainName"),
                            fontFamily: 'medium',
                            fontSize: 14,
                            color: MyColors.primaryColor,
                          ),
                          ParagraphText(
                            text: '${widget.domainData['domain']}',
                            fontFamily: 'bold',
                            fontSize: 14,
                            color: MyColors.primaryColor,
                          ),
                        ],
                      ),
                      ParagraphText(
                          text: widget.purchaseCurrency==PurchaseCurrency.jin?
                          '${widget.domainData['jinCost']} ${translate("cart.jin")}':widget.purchaseCurrency==PurchaseCurrency.btc?'${price} BTC':'${widget.domainData['usdCost']} ${translate("cart.USD")}',
                          fontFamily: 'bold',
                          fontSize: 14,
                          color: MyColors.primaryColor),
                    ],
                  ),
                  vSizedBox4,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         ParagraphText(text: 'Top Banner Ad', fontFamily: 'medium', fontSize: 14, color: MyColors.primaryColor,),
                  //         ParagraphText(text: 'Page 5, Spa/Beauty', fontFamily: 'medium', fontSize: 12, color: MyColors.primaryColor,),
                  //       ],
                  //     ),
                  //     ParagraphText(text: '500 JIN', fontFamily: 'bold', fontSize: 14,color: MyColors.primaryColor),
                  //   ],
                  // ),
                  vSizedBox2,
                  Divider(
                    height: 25,
                    thickness: 2,
                    color: MyColors.blackColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ParagraphText(
                        text:translate("cart.totalPrice"),
                        fontFamily: 'bold',
                        fontSize: 14,
                        color: Color(0xFF525252),
                      ),
                      ParagraphText(
                          text:
                          widget.purchaseCurrency==PurchaseCurrency.btc?'$price BTC':
                              widget.purchaseCurrency==PurchaseCurrency.jin?
                              '${widget.domainData['jinCost']} ${translate("cart.jin")}':
                          '${widget.domainData['usdCost']} ${translate("cart.USD")}',
                          fontFamily: 'bold',
                          fontSize: 14,
                          color: MyColors.primaryColor),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ParagraphText(
                        text:translate("cart.myOX21"),
                        fontFamily: 'bold',
                        fontSize: 14,
                        color: Color(0xFF525252),
                      ),
                      ParagraphText(
                          text: '${widget.totalCost.toStringAsFixed(0)}',
                          fontFamily: 'bold',
                          fontSize: 14,
                          color: MyColors.primaryColor),
                    ],
                  ),
                ],
              ),
            ),
            vSizedBox2,
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  if(widget.purchaseCurrency!=PurchaseCurrency.usd)
                  RoundEdgedButton(
                    text: translate("cart.confirm"),
                    textColor: Colors.white,
                    color: MyColors.secondary,
                    fontfamily: 'medium',
                    onTap: ()async{
                      setState(() {
                        load = true;
                      });

                      int randomId = Random().nextInt(999999);
                      print(randomId);
                      Map<String,dynamic> request = {
                        "domain":widget.domainData['domain'],
                        // "domain": "qwew",
                        "user_id":userId,
                        "payment_by":widget.purchaseCurrency==PurchaseCurrency.coins?"points":widget.purchaseCurrency==PurchaseCurrency.jin?"jin":widget.purchaseCurrency==PurchaseCurrency.btc?"btc":"usd",
                        "usd_cost":"0",
                        "jin_cost":widget.purchaseCurrency==PurchaseCurrency.jin?"${widget.domainData['jinCost']}":"0",
                        "btc_cost":widget.purchaseCurrency==PurchaseCurrency.btc?price:'0',
                        "orderID":randomId.toString()
                      };

                      var response = await Webservices.postData(url: ApiUrls.buyDomain, request: request, context: context);
                      if(response['status']==1){
                        // push(context: context, screen: screen)
                        showSnackbar(context, response['message']);
                        Navigator.popUntil(context, (route) => route.isFirst);
                        if(response['data']['payment_status'].toString()=='1'){
                          push(context: MyGlobalKeys.navigatorKey.currentContext!, screen: DomainPurchaseSuccessfulPage(domainData: response['data']));
                        }else{
                          push(context: context, screen: CompleteDomainPaymentPage(purchaseData: response['data']));
                        }

                      }

                      setState(() {
                        load = false;
                      });
                    },
                  ),



                  // vSizedBox2,
                  // RoundEdgedButton(
                  //   text: 'Purchase with My OX21 Coins',
                  //   isSolid: false,
                  //   textColor: Colors.white,
                  //   color: MyColors.secondary,
                  //   fontfamily: 'medium',
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
