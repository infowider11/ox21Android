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
      appBar: appBar(context: context, title: 'My Coins'),
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
                                        SubHeadingText(text: 'Wallet Balance'),
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
                                                SubHeadingText(text: 'JIN'),
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
                                                SubHeadingText(text: '1.00 BTC'),
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
                      text: 'Convert BTC To JIN',
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
                                    Center(child: SubHeadingText(text: 'Convert BTC to Jin')),
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
                                                SubHeadingText(text: 'JIN'),
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
                                                SubHeadingText(text: '1.00 BTC'),
                                                vSizedBox05,
                                                ParagraphText(text: '≈${oneBtcToJIN.toStringAsFixed(2)} JIN', color: MyColors.black54Color,),
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

                                        SubHeadingText(text: 'Enter BTC Amount'),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SubHeadingText(text: userData!['btc_wallet'].toString() + ' BTC'),
                                            ParagraphText(text: '(Available BTC)', color: MyColors.primaryColor,)
                                          ],
                                        ),
                                      ],
                                    ),
                                    CustomTextField(controller: amountController, hintText: 'Enter Btc amount to convert in JIN', keyboardType: TextInputType.number,),
                                    vSizedBox2,
                                    RoundEdgedButton(
                                      text: 'Convert',
                                      onTap: ()async{
                                        FocusScope.of(context).requestFocus(new FocusNode());
                                        if(amountController.text==''){

                                          showSnackbar(context, 'Please type valid amount');
                                        }else if(double.parse(amountController.text)>double.parse(userData!['btc_wallet'].toString())){
                                          showSnackbar(context, 'Oops!! You don\'t have sufficient balance');
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
                      text: 'Convert BTC To OX21 Points',
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
                                    Center(child: SubHeadingText(text: 'Convert BTC to OX21 Points')),
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
                                                SubHeadingText(text: 'Points'),
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
                                                SubHeadingText(text: '1.00 BTC'),
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

                                        SubHeadingText(text: 'Enter BTC Amount'),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SubHeadingText(text: userData!['btc_wallet'].toString() + ' BTC'),
                                            ParagraphText(text: '(Available BTC)', color: MyColors.primaryColor,)
                                          ],
                                        ),
                                      ],
                                    ),
                                    CustomTextField(controller: amountController, hintText: 'Enter Btc amount to convert in JIN', keyboardType: TextInputType.number,),
                                    vSizedBox2,
                                    RoundEdgedButton(
                                      text: 'Convert',
                                      onTap: ()async{
                                        FocusScope.of(context).requestFocus(new FocusNode());
                                        if(amountController.text==''){

                                          showSnackbar(context, 'Please type valid amount');
                                        }else if(double.parse(amountController.text)>double.parse(userData!['btc_wallet'].toString())){
                                          showSnackbar(context, 'Oops!! You don\'t have sufficient balance');
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
                      text: 'Buy OX21 Points Test purchase',
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
                      text: 'Buy OX21 Points',
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
