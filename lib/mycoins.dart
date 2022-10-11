import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/buy_refreshment_page.dart';
import 'package:ox21/pages/cash_coins_page.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/flutter_in_app_purchase_services.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';

import 'constants/colors.dart';
import 'constants/global_functions.dart';
import 'constants/image_urls.dart';
import 'constants/sized_box.dart';
import'package:flutter_translate/flutter_translate.dart';
class MyCoinsPage extends StatefulWidget {
  static const String id = "mycoins";
  const MyCoinsPage({Key? key}) : super(key: key);

  @override
  State<MyCoinsPage> createState() => _MyCoinsPageState();
}

class _MyCoinsPageState extends State<MyCoinsPage> {
  bool load = false;

  // int coins = 0;
  getUserDetails() async {
    setState(() {
      load = true;
    });
    await updateSharedPreferenceFromServer();
    await getPrice();
    // coins = (await updateSharedPreferenceFromServer())['points'] ?? 0;
    // print('khdfklshndfklj $coins');
    setState(() {
      load = false;
    });
  }

  String btcConversionPrice = '0';
  getPrice() async{
    await updateSharedPreferenceFromServer();
    btcConversionPrice = await Webservices.getLiveConversionRateBTCToUSD();

  }

  @override
  void initState() {
    // TODO: implement initState
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title:translate("myCoins.title")),
      body: load
          ? CustomLoader()
          : Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  // color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16)),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 16,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFFf1f1f1), width: 0.5),
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                MyImages.twemoji_coineyecross,
                                height: 60,
                                fit: BoxFit.fitHeight,
                              ),
                              vSizedBox,
                              ParagraphText(
                                text: '${userData!['points']} Coins',
                                fontSize: 24,
                                fontFamily: 'bold',
                                color: MyColors.primaryColor,
                              ),
                              CustomDivider(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SubHeadingText(text:translate("myCoins.title")),
                                        SubHeadingText(text: '${double.parse(userData!['btc_wallet'].toString()).toStringAsFixed(2)} BTC', color: MyColors.primaryColor,),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              CustomDivider(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white, borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Image.asset(
                                            MyImages.jinLogo,
                                            fit: BoxFit.fitHeight,
                                            height: 40,
                                          ),
                                        ),
                                        hSizedBox,
                                        Expanded(
                                            flex: 12,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SubHeadingText(text: translate("myCoins.jin")),
                                                vSizedBox05,
                                                ParagraphText(text: '${double.parse(userData!['jin_wallet'].toString()).toStringAsFixed(0)} JIN', color: MyColors.black54Color,),
                                              ],
                                            )
                                        ),
                                        Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                SubHeadingText(text:translate("myCoins.1BTC")),
                                                vSizedBox05,
                                                ParagraphText(text: '≈${(double.parse(btcConversionPrice)/6).toStringAsFixed(2)} JIN', color: MyColors.black54Color,),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              vSizedBox2,
                              // ParagraphText(text: '@domainName',fontSize: 14,fontFamily: 'medium',color: MyColors.primaryColor,),
                            ],
                          ),
                        ),
                      ],
                    ),
                    vSizedBox2,
                  vSizedBox,
                    RoundEdgedButton(
                      text: translate("myCoins.convertB2J"),
                      isSolid: false,
                      textColor: Colors.white,
                      color: MyColors.secondary,
                      fontfamily: 'medium',
                      onTap: () async {
                        setState(() {
                          load = true;
                        });
                        String conversionRate = await Webservices.getLiveConversionRateBTCToUSD();
                        TextEditingController amountController = TextEditingController();
                        double oneBtcToJIN = double.parse(conversionRate)/6;
                        setState(() {
                          load = false;
                        });
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              height: 300 + MediaQuery.of(context).viewInsets.bottom,
                              // margin: viewInset,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                color: MyColors.whiteColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                )
                              ),
                              child: Scaffold(
                                backgroundColor: MyColors.whiteColor,
                                body: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(child: SubHeadingText(text: translate("myCoins.convertB2J"))),
                                    vSizedBox,
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Image.asset(
                                            MyImages.jinLogo,
                                            fit: BoxFit.fitHeight,
                                            height: 40,
                                          ),
                                        ),
                                        hSizedBox,
                                        Expanded(
                                            flex: 12,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SubHeadingText(text: translate("myCoins.jin")),
                                                vSizedBox05,
                                                ParagraphText(text: '${double.parse(userData!['jin_wallet'].toString()).toStringAsFixed(0)} ${translate("myCoins.jin")}', color: MyColors.black54Color,),
                                              ],
                                            )
                                        ),
                                        Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                SubHeadingText(text:translate("myCoins.1BTC")),
                                                vSizedBox05,
                                                ParagraphText(text: '≈${oneBtcToJIN.toStringAsFixed(2)} ${translate("myCoins.jin")}', color: MyColors.black54Color,),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                    vSizedBox2,
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        SubHeadingText(text: translate("myCoins.enterAmount")),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SubHeadingText(text: userData!['btc_wallet'].toString() + ' BTC'),
                                            ParagraphText(text: translate("myCoins.availableBtc"), color: MyColors.primaryColor,)
                                          ],
                                        ),
                                      ],
                                    ),
                                    CustomTextField(controller: amountController, hintText:translate("myCoins.amountCon"), keyboardType: TextInputType.number,),
                                    vSizedBox2,
                                    RoundEdgedButton(
                                      text:translate("myCoins.convert"),
                                      onTap: ()async{
                                        FocusScope.of(context).requestFocus(new FocusNode());
                                        if(amountController.text==''){

                                          showSnackbar(context, translate("myCoins.alertValidAmount"));
                                        }else if(double.parse(amountController.text)>double.parse(userData!['btc_wallet'].toString())){
                                          showSnackbar(context,translate("myCoins.alertInsuff"));
                                        }else{
                                          var request = {
                                            "user_id":userId,
                                            "btc_amount":amountController.text,
                                            "type":"btc_to_jin"
                                          };

                                          var response = await Webservices.postData(url: ApiUrls.conver_btc, request: request, context: context);
                                          if(response['status']==1){
                                            Navigator.pop(context);
                                            showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, '${response['message']}',);
                                            await updateSharedPreferenceFromServer();
                                            setState(() {

                                            });
                                          }


                                        }
                                      },
                                    )

                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        setState(() {
                          load = false;
                        });
                      },
                    ),
                    vSizedBox,
                    RoundEdgedButton(
                      text:translate("myCoins.convertB2O"),
                      textColor: Colors.white,
                      color: MyColors.secondary,
                      fontfamily: 'medium',
                      onTap: () async {
                        setState(() {
                          load = true;
                        });
                        String conversionRate = await Webservices.getLiveConversionRateBTCToUSD();
                        TextEditingController amountController = TextEditingController();
                        // double oneBtcToJIN = double.parse(conversionRate)/6;
                        setState(() {
                          load = false;
                        });
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              height: 300 + MediaQuery.of(context).viewInsets.bottom,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                  color: MyColors.whiteColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  )
                              ),
                              child: Scaffold(
                                backgroundColor: MyColors.whiteColor,
                                body: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(child: SubHeadingText(text:translate("myCoins.convertB2O"))),
                                    vSizedBox,
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Image.asset(
                                            MyImages.logo_hori,
                                            fit: BoxFit.fill,
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                        hSizedBox,
                                        Expanded(
                                            flex: 12,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SubHeadingText(text:translate("myCoins.points")),
                                                vSizedBox05,
                                                ParagraphText(text: '${userData!['points']}', color: MyColors.black54Color,),
                                              ],
                                            )
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SubHeadingText(text: translate("myCoins.1BTC")),
                                                vSizedBox05,
                                                ParagraphText(text: '≈${(240.0*double.parse(conversionRate)).toStringAsFixed(0)} Points', color: MyColors.black54Color,),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                    vSizedBox2,
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        SubHeadingText(text:translate("myCoins.enterAmount")),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SubHeadingText(text: userData!['btc_wallet'].toString() + ' BTC'),
                                            ParagraphText(text:translate("myCoins.availableBtc"), color: MyColors.primaryColor,)
                                          ],
                                        ),
                                      ],
                                    ),
                                    CustomTextField(controller: amountController, hintText:translate("myCoins.amountCon"), keyboardType: TextInputType.number,),
                                    vSizedBox2,
                                    RoundEdgedButton(
                                      text: 'Convert',
                                      onTap: ()async{
                                        FocusScope.of(context).requestFocus(new FocusNode());
                                        if(amountController.text==''){

                                          showSnackbar(context, translate("myCoins.alertValidAmount"));
                                        }else if(double.parse(amountController.text)>double.parse(userData!['btc_wallet'].toString())){
                                          showSnackbar(context,translate("myCoins.alertInsuff"));
                                        }else{
                                          var request = {
                                            "user_id":userId,
                                            "btc_amount":amountController.text,
                                            "type":"btc_to_points"
                                          };

                                          var response = await Webservices.postData(url: ApiUrls.conver_btc, request: request, context: context);
                                          if(response['status']==1){
                                            Navigator.pop(context);
                                            showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, '${response['message']}',);
                                            await updateSharedPreferenceFromServer();
                                            setState(() {

                                            });
                                          }


                                        }
                                      },
                                    )

                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        setState(() {
                          load = false;
                        });
                      },
                    ),

                    vSizedBox,
                    RoundEdgedButton(
                      text: translate("myCoins.convertO2T"),
                      textColor: Colors.white,
                      color: MyColors.secondary,
                      fontfamily: 'medium',
                      onTap: () async {
                        setState(() {
                          load = true;
                        });

                        FlutterInAppPurchaseServices inAppServices = FlutterInAppPurchaseServices();
                        // await inAppServices.initData();
                        await inAppServices.getInAppPurchaseRequirements('android.test.purchased');
                        await inAppServices.initData();
                        await inAppServices.payAndDownload(context);
                        print('my namne is manish talreja');
                        setState(() {
                          load = false;
                        });
                        Future.delayed(Duration(seconds: 2)).then((value){
                          updateSharedPreferenceFromServer().then((value){
                            setState(() {
                              print('klfklsf');
                            });
                          });
                        });

                      },
                    ),
                    vSizedBox,
                    RoundEdgedButton(
                      text:translate("myCoins.buy"),
                      textColor: Colors.white,
                      color: MyColors.secondary,
                      fontfamily: 'medium',
                      onTap: () async {
                        setState(() {
                          load = true;
                        });

                        FlutterInAppPurchaseServices inAppServices = FlutterInAppPurchaseServices();
                        // await inAppServices.initData();
                        // android.test.purchased
                        await inAppServices.getInAppPurchaseRequirements('05182805');
                        // await inAppServices.getInAppPurchaseRequirements('android.test.purchased');
                        await inAppServices.initData();
                        await inAppServices.payAndDownload(context);
                        await updateSharedPreferenceFromServer();

                        print('my namne is manish talreja');
                        setState(() {
                          load = false;
                        });
                        Future.delayed(Duration(seconds: 2)).then((value){
                          updateSharedPreferenceFromServer().then((value){
                            setState(() {
                              print('klfklsf');
                            });
                          });
                        });

                      },
                    ),
                    vSizedBox,
                  ],
                ),
              ),
            ),
    );
  }
}
