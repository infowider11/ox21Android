import 'dart:convert';

import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/complete_top_banner_payment_page.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:uuid/uuid.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../widgets/CustomTexts.dart';
import 'package:intl/intl.dart';
import '../widgets/appbar.dart';
import '../widgets/buttons.dart';
import 'my_subscribed_channels_page.dart';
import 'package:flutter_translate/flutter_translate.dart';
class SelectPageNumberPage extends StatefulWidget {
  Map<String,dynamic> request;
  SelectPageNumberPage({Key? key, required this.request}) : super(key: key);

  @override
  _SelectPageNumberPageState createState() => _SelectPageNumberPageState();
}

class _SelectPageNumberPageState extends State<SelectPageNumberPage> {

  List bidders = [];
  List priceList = [];
  bool load = false;

  Map? selectedPricing;
  String? resalePrice;
  int? selectedPageNumber;



  getPriceList()async{
    setState(() {
      load = true;
    });
    priceList = await Webservices.getList(ApiUrls.getPriceList);
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getPriceList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:load?null: appBar(context: context, title:translate("select_page_number_page.title")),
      body:load?CustomLoader(): Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox2,
              Row(
                children: [
                  ParagraphText(text:translate("select_page_number_page.selectedChannel")),
                  SubHeadingText(text: widget.request['channelName']??translate("select_page_number_page.mm")),
                ],
              ),
              vSizedBox2,
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(
                          MyImages.spaBeauty,
                        ),
                        fit: BoxFit.cover)),
              ),
              vSizedBox2,
              Container(
                height: 32,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SubHeadingText(text: translate("select_page_number_page.selectPage"), fontSize: 12,),
                    hSizedBox,
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: priceList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: ()async{
                              setState(() {
                                load = true;
                              });
                              // selectedPageNumber = priceList[index]['page_number'];
                            try{
                              widget.request['page_number'] = priceList[index]['page_number'].toString();
                            }catch(e){
                              print('sfjdkls $e' );
                            }
                              String requestString= '${widget.request['language']},${widget.request['country']},${widget.request['state']},${widget.request['city']},${widget.request['channel']},${priceList[index]['page_number']}';

                              print(' the request string is $requestString');
                              Crypt hashedPass = Crypt.sha256(
                                  requestString,
                                  salt: MyGlobalConstants.passwordSalt);
                              var response = await Webservices.getData(ApiUrls.checkbannerStatus + hashedPass.hash + '&user_id=$userId');

                              if(response.statusCode==200){
                                Map<String, dynamic> jsonResponse = jsonDecode(response.body);
                                if(jsonResponse['status'].toString()=='1'){
                                  selectedPricing = priceList[index];
                                  resalePrice=null;

                                  bidders = await Webservices.getList(ApiUrls.getBiddersList + hashedPass.hash);
                                  print('the bidders are $bidders');
                                }else if(jsonResponse['status'].toString()=='3'){
                                  // resalePrice =jsonResponse['data']['sell_price'].toString();
                                  resalePrice=null;
                                }else if(jsonResponse['status'].toString()=='4'){
                                  resalePrice =jsonResponse['data']['sell_price'].toString();
                                  selectedPricing = priceList[index];
                                  bidders = await Webservices.getList(ApiUrls.getBiddersList + hashedPass.hash);
                                }else{
                                  resalePrice=null;
                                  setState(() {
                                    load = false;
                                  });
                                  showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, translate("select_page_number_page.notAvailable"));
                                }

                              }

                              setState(() {
                                load = false;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              // height: 16,
                              width: 32,
                              decoration: BoxDecoration(
                                color:
                               selectedPricing!=null ?selectedPricing!['id']==priceList[index]['id']? MyColors.secondary : Colors.grey : Colors.grey,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Text(
                                  '${priceList[index]['page_number']}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color:Colors.white
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              vSizedBox2,

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainHeadingText(
                          text: translate("select_page_number_page.pricing"),
                          color: MyColors.secondary,
                        ),
                        SubHeadingText(
                          text: (resalePrice??(selectedPricing==null?'0':widget.request['country']!=null? selectedPricing!['local_price'].toString(): selectedPricing!['global_price'].toString())) + ' BTC',
                          color: MyColors.black54Color,
                          fontSize: 18,
                        ),
                      ],
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: RoundEdgedButton(
                      textColor: Colors.white,
                      text:translate("select_page_number_page.purchaseNow"),
                      color:selectedPricing==null?MyColors.inactiveButtonColor: MyColors.secondary,
                      fontSize: 12,
                      fontfamily: 'medium',
                      onTap:selectedPricing==null?null: ()async{
                        setState(() {
                          load = true;
                        });
                        print(' the pricing is $selectedPricing');
                        String requestString= '${widget.request['language']},${widget.request['country']},${widget.request['state']},${widget.request['city']},${widget.request['channel']},${selectedPricing!['page_number']}';

                        print(' the request string is $requestString');
                        Crypt hashedPass = Crypt.sha256(
                            requestString,
                            salt: MyGlobalConstants.passwordSalt);
                        Uuid uuid = Uuid();


                        String typedPhrase = uuid.v5(
                            Uuid.NAMESPACE_URL,translate("select_page_number_page.fight"));
                        print(typedPhrase);
                        var request = {
                          "user_id": userId.toString(),
                          "uuid": typedPhrase.toString(),
                          "price":resalePrice?? (widget.request['city']==null?selectedPricing!['global_price'].toString():selectedPricing!['local_price'].toString()),
                          "hash": hashedPass.hash,
                          // "token_id": widget.request['channel'].toString(),
                          "language":widget.request['language'],
                          // "country": widget.request['country'],
                          // "state": widget.request['state'],
                          // "city":widget.request['city'],
                          "channel": widget.request['channel'],
                          "page_number":widget.request['page_number'],
                        };
                        // if(widget.request['country']!=null){
                        //   request['country']= widget.request['country']??'';
                        // }
                        // if(widget.request['state']!=null){
                        //   request['state']= widget.request['state']??'';
                        // }
                        if(widget.request['city']!=null){
                          request['city']= widget.request['city']??'';
                          request['state']= widget.request['state']??'';
                          request['country']= widget.request['country']??'';
                        }
                        //




                        // the requesst for http://ox21nft.xyz/api/buy_banner is {user_id: 171, uuid: 3982377d-193f-5b3c-b249-bbf09072c042, price: 80, hash: J.Ch/oFP8SVVOM9y02GhhkalNrIbbdPLlayxHpJcbRB}
                        // I/flutter (23746): i am here
                        // [log] the response for http://ox21nft.xyz/api/buy_banner is {status: 1, message: Please payment with in 24 hours, data: {hash: J.Ch/oFP8SVVOM9y02GhhkalNrIbbdPLlayxHpJcbRB, uuid: 3982377d-193f-5b3c-b249-bbf09072c042, user_id: 171, price: 80, orderID: 523107, expire_time: 1652439911}}




                        // "user_id":4,
                        // "uuid":"3982377d-193f-5b3c-b249-bbf09072c042",
                        // "price":20.36,
                        // "hash":"3982377d-193f-5b3c-b249-bbf09072c042"
                      Map<String, dynamic> jsonResponse =   await Webservices.postData(url: ApiUrls.buyBanner, request: request, context: context);

                        if(jsonResponse['status'].toString()=='1'){
                          Navigator.popUntil(context, (route) => route.isFirst);
                          if(jsonResponse['data']['payment_status'].toString()=='1'){
                            showSnackbar(context, translate("select_page_number_page.successfully"));
                          }else{
                            push(context: MyGlobalKeys.navigatorKey.currentContext!, screen: CompleteTopBannerPaymentPage(purchaseData: jsonResponse['data']));
                          }
                        }else{
                          setState(() {
                            load = false;
                          });
                        }


                        // Navigator.pushNamed(context, MySubscribedChannels.id);
                      },
                    ),
                  ),
                ],
              ),
              vSizedBox2,
              CustomDivider(),
              SubHeadingText(text:translate("select_page_number_page.topBidders")),
              vSizedBox2,
              bidders.length==0?
                  Center(child: ParagraphText(text: translate("select_page_number_page.noBidder"),),):
              ListView.builder(
                itemCount: bidders.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: MyColors.secondary.withOpacity(0.2),
                      gradient: LinearGradient(colors: [
                        Color(0xFFF6F6F6),
                        Color(0xFF42E8E0),
                      ]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        // Container(
                        //   height: 60,
                        //   width: 60,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(60),
                        //       image: DecorationImage(
                        //           image: AssetImage(
                        //             MyImages.femaleAvatar,
                        //           ),
                        //           fit: BoxFit.cover)),
                        // ),
                        hSizedBox,
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SubHeadingText(
                                text: '${bidders[index]['uuid']}',
                                color: MyColors.hintcolor,
                              ),
                              // ParagraphText(
                              //   text: 'abc',
                              //   color: MyColors.hintcolor,
                              // )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ParagraphText(
                                text: '${DateFormat.yMMMMEEEEd().format(DateTime.parse(bidders[index]['created_at']))}',
                                color: MyColors.black54Color,
                              ),
                              // SubHeadingText(
                              //   text: '1200 OX21coins',
                              //   color: MyColors.secondary,
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
