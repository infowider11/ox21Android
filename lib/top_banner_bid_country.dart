import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/packages/lib/utils/google_search/place_type.dart';
import 'package:ox21/packages/lib/widget/search_widget.dart';
import 'package:ox21/select_channels.dart';
import 'package:ox21/top_banner_bid_chennels.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/customtextfield.dart';

import 'constants/colors.dart';
import 'constants/global_constants.dart';
import 'constants/image_urls.dart';
import 'constants/sized_box.dart';
import 'package:flutter_translate/flutter_translate.dart';
class TopBannerBidCountryPage extends StatefulWidget {
  // static const String id="contry";
  Map<String, dynamic> request;
  TopBannerBidCountryPage({Key? key, required this.request}) : super(key: key);

  @override
  State<TopBannerBidCountryPage> createState() => _TopBannerBidCountryPageState();
}

class _TopBannerBidCountryPageState extends State<TopBannerBidCountryPage> {
  String? countryValue;
  String? stateValue;
  String? cityValue;
  bool load = false;

  @override
  Widget build(BuildContext context) {
    print(widget.request);
    TextEditingController emailcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      appBar: load
          ? null
          :  appBar(context: context,
         title:translate("walletpage.title"), titleColor: MyColors.primaryColor
      ),
      body:load
          ? CustomLoader()
          :  Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ParagraphText(text:translate("walletpage.selectLocation"),
                        fontSize: 18,
                        fontFamily: 'bold',
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>top_banner_chennel(request: widget.request,)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SubHeadingText(text: translate("walletpage.skip"),color: MyColors.primaryColor,),
                      ),
                    )
                  ],
                ),
                vSizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SearchLocation(
                    iconColor: Colors.grey,
                    apiKey: MyGlobalConstants.kGoogleApiKey,
                    height: 36,
                    placeType: PlaceType.cities,
                    placeholder: translate("walletpage.selectText"),
                    onSelected: (place) {
                      print('the place is ${place.fullJSON}');
                      List data = place.fullJSON['description']
                          .toString()
                          .split(", ");
                      print(data);
                      if (data.length > 2) {
                        cityValue = data[0];
                        stateValue = data[1];
                        countryValue = data[2];
                        setState(() {});
                      }else if (data.length==2){
                        cityValue = data[0];
                        countryValue = data[1];
                      }
                    },
                    onClearIconPress: (){
                      countryValue = null;
                      stateValue = null;
                      cityValue = null;
                    },
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                //   child: CustomTextFieldlabel(
                //     labeltext: 'Country',
                //     controller: emailcontroller,
                //     hintText: 'Country',
                //     left: 16,
                //     fontsize: 16,
                //     hintcolor: MyColors.inputbordercolor,
                //     suffixIcon: MyImages.search,
                //     bgColor: Color(0xFFF2F2F2),
                //     border: Border.all(color: Color(0xFFAAAAAA)),
                //     borderRadius: 8,
                //     paddingsuffix: 18,
                //   ),
                // ),
                // vSizedBox,
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                //   child: CustomTextFieldlabel(
                //     labeltext: 'City',
                //     controller: emailcontroller,
                //     hintText: 'City',
                //     left: 16,
                //     fontsize: 16,
                //     hintcolor: MyColors.inputbordercolor,
                //     suffixIcon: MyImages.search,
                //     bgColor: Color(0xFFF2F2F2),
                //     border: Border.all(color: Color(0xFFAAAAAA)),
                //     borderRadius: 8,
                //     paddingsuffix: 18,
                //   ),
                // ),
                // vSizedBox,
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                //   child: CustomTextFieldlabel(
                //     labeltext: 'Province',
                //     controller: emailcontroller,
                //     hintText: 'Province',
                //     left: 16,
                //     fontsize: 16,
                //     hintcolor: MyColors.inputbordercolor,
                //     suffixIcon: MyImages.search,
                //     bgColor: Color(0xFFF2F2F2),
                //     border: Border.all(color: Color(0xFFAAAAAA)),
                //     borderRadius: 8,
                //     paddingsuffix: 18,
                //   ),
                // ),

              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                RoundEdgedButton(
                  text: translate("walletpage.continueBtn"),
                  textColor: Colors.white,
                  color:cityValue==null?MyColors.inactiveButtonColor: MyColors.primaryColor,
                  borderRadius: 12,
                  width: MediaQuery.of(context).size.width - 32,
                  fontSize: 16,
                  verticalPadding: 20,
                  horizontalMargin: 16,
                  fontfamily: 'medium',
                  onTap:countryValue==null?null: (){
                    widget.request['city']=cityValue;
                    widget.request['country'] = countryValue;
                    widget.request['state'] = stateValue;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>top_banner_chennel(request: widget.request,)));
                    // Navigator.pushNamed(context, top_banner_chennel.id);
                  },
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
