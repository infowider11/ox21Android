import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/complete_top_banner_payment_page.dart';
import 'package:ox21/pages/qr_code_page.dart';
import 'package:ox21/select_location.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/top_banner_bid_country.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/customtextfield.dart';

import 'constants/colors.dart';
import 'constants/global_constants.dart';
import 'constants/global_functions.dart';
import 'constants/image_urls.dart';
import 'constants/sized_box.dart';
import 'package:flutter_translate/flutter_translate.dart';
class TopBannerLanguagePage extends StatefulWidget {
  static const String id="topbannerlang";

  TopBannerLanguagePage({Key? key,}) : super(key: key);

  @override
  State<TopBannerLanguagePage> createState() => _TopBannerLanguagePageState();
}

class _TopBannerLanguagePageState extends State<TopBannerLanguagePage> {


  bool load = false;
  TextEditingController searchController = TextEditingController();
  String? selectedLanguage;



  getLanguages() async {
    setState(() {
      load = true;
    });
    Response response= await Webservices.getData(ApiUrls.checkPreviousPendingTopBannerPurchase + userId);
    if(response.statusCode==200){
      var jsonResponse = jsonDecode(response.body);
      if(jsonResponse['status'].toString()=='1'){
        languages = await Webservices.getList(ApiUrls.getLanguages);
        setState(() {
          load = false;
        });
      }else if(jsonResponse['status'].toString()=='2'){
        Map<String, dynamic> purchaseData = jsonResponse['data'];
        pushReplacement(context: context, screen: CompleteTopBannerPaymentPage(purchaseData: purchaseData,));
      }
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    getLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      appBar:load
          ? null
          :  appBar(context: context,
          title: translate("top_banner_purchase_bid_language.title"),
          titleColor: MyColors.primaryColor
      ),
      body: load
          ? CustomLoader()
          :  Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ParagraphText(text: translate("top_banner_purchase_bid_language.selectLang"),
                  fontSize: 18,
                  fontFamily: 'bold',
                ),
              ),
              vSizedBox,
              Padding(
                padding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: CustomTextFieldlabel(
                  labeltext: translate("top_banner_purchase_bid_language.searchInLang"),
                  controller: searchController,
                  hintText: 'labeltext',
                  left: 16,
                  fontsize: 12,
                  hintcolor: MyColors.inputbordercolor,
                  // suffixIcon: MyImages.voicesearch,
                  bgColor: Color(0xFFF2F2F2),
                  border: Border.all(color: MyColors.strokelabel),
                  icon: Icons.search,
                  borderRadius: 16,
                  paddingsuffix: 14,
                  onChanged: (value){
                    setState(() {

                    });
                  },
                ),
              ),
              vSizedBox2,
              Expanded(
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  // margin: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      border: Border(
                          top: BorderSide(
                            color: Color(0xFFF2F2F2),
                          ))),
                  child: Container(
                    // height: 400,
                    child:languages.length==0?Center(child: Text(translate("top_banner_purchase_bid_language.noData"))): ListView.builder(
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        if(languages[index]['name'].toString().toLowerCase().contains(searchController.text.toLowerCase()))
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: ()async{
                              selectedLanguage = languages[index]['id'].toString();
                              setState(() {

                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ParagraphText(
                                      text: '${languages[index]['name']}',
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    vSizedBox,
                                    ParagraphText(
                                      text: '${languages[index]['name']}',
                                      fontSize: 11,
                                      color: Colors.black,
                                    ),
                                    Divider(
                                      indent: 0,
                                      height: 16,
                                    ),
                                  ],
                                ),
                                if(selectedLanguage==languages[index]['id'].toString())
                                  Image.asset(MyImages.check_green, height: 40, fit: BoxFit.fitHeight,),
                              ],
                            ),
                          );
                        return Container();
                      },
                    ),
                  ),
                ),
              ),

            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                vSizedBox2,
                RoundEdgedButton(
                  text:translate("Select_location.continueBtn"),
                  textColor: Colors.white,
                  color:selectedLanguage==null?Colors.grey.shade300: MyColors.primaryColor,
                  borderRadius: 12,
                  width: MediaQuery.of(context).size.width - 32,
                  fontSize: 16,
                  verticalPadding: 20,
                  horizontalMargin: 16,
                  fontfamily: 'medium',
                  onTap:selectedLanguage==null?null: () async{

                    setState(() {
                      load = true;
                    });
                    // var response = await Webservices.postData(url: ApiUrls.updateUserLanguage, request: {
                    //   "id": userId,
                    //   "language": selectedLanguage,
                    // }, context: context);
                    // if(response['status']==1){
                    //   await updateSharedPreferenceFromServer();
                    //   await Navigator.pushReplacementNamed(context, Select_location.id);
                    // }

                    var request = {
                      "language": selectedLanguage
                    };
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TopBannerBidCountryPage(request: request,)));
                    setState(() {
                      load = false;
                    });


                  },
                  // onTap: (){
                  //   Navigator.pushNamed(context, top_banner_bid_country.id);
                  // },
                ),
                vSizedBox2,
              ],
            ),
          )
        ],
      ),
    );
  }
}
