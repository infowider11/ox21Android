import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/packages/lib/search_map_location.dart';
import 'package:ox21/packages/lib/utils/google_search/place_type.dart';
import 'package:ox21/select_channels.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/tab.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/colors.dart';
import 'constants/global_functions.dart';
import 'constants/image_urls.dart';
import 'constants/sized_box.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import'package:flutter_translate/flutter_translate.dart';
class Select_location extends StatefulWidget {
  static const String id = "location";
  const Select_location({Key? key}) : super(key: key);

  @override
  State<Select_location> createState() => _Select_locationState();
}

class _Select_locationState extends State<Select_location> {
  String? countryValue;
  String? stateValue;
  String? cityValue;
  bool load = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      appBar: load
          ? null
          : appBar(context: context, actions: [
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    MyImages.logowelcom,
                    width: 35,
                    height: 40,
                    fit: BoxFit.fitHeight,
                  ))
            ]),
      body: load
          ? CustomLoader()
          : Stack(
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ParagraphText(
                              text:translate("Select_location.selectLocation"),
                              fontSize: 18,
                              fontFamily: 'bold',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: GestureDetector(
                              onTap: ()async{
                                SharedPreferences sharedPreference = await SharedPreferences.getInstance();
                                sharedPreference.setString('skippedLocation', 'true');
                                Navigator.pushReplacementNamed(context, SelectChannelPage.id);
                              },
                              child: SubHeadingText(
                                text: translate("Select_location.skip"),
                              ),
                            ),
                          )
                        ],
                      ),
                      vSizedBox,
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
                      vSizedBox2,
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: SelectState(
                      //     // decoration: InputDecoration(
                      //     //     border: OutlineInputBorder(
                      //     //         borderRadius:
                      //     //         const BorderRadius.all(Radius.circular(4.0))),
                      //     //     contentPadding: EdgeInsets.all(5.0)),
                      //     // spacing: 25.0,
                      //     onCountryChanged: (value) {
                      //       setState(() {
                      //         countryValue = value;
                      //       });
                      //     },
                      //     // onCountryTap: () => displayMsg('You\'ve tapped on countries!'),
                      //     onStateChanged: (value) {
                      //       setState(() {
                      //         stateValue = value;
                      //       });
                      //     },
                      //     // onStateTap: () => displayMsg('You\'ve tapped on states!'),
                      //     onCityChanged: (value) {
                      //       setState(() {
                      //         cityValue = value;
                      //       });
                      //     },
                      //     // onCityTap: () => displayMsg('You\'ve tapped on cities!'),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SearchLocation(
                          iconColor: Colors.grey,
                          apiKey: MyGlobalConstants.kGoogleApiKey,
                          height: 36,
                          placeType: PlaceType.cities,
                          placeholder:  translate("Select_location.selectText"),
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
                            }
                          },
                        ),
                      ),
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
                        text: translate("Select_location.continueBtn"),
                        textColor: Colors.white,
                        color: cityValue == null
                            ? Colors.grey.shade300
                            : MyColors.primaryColor,
                        borderRadius: 12,
                        width: MediaQuery.of(context).size.width - 32,
                        fontSize: 16,
                        horizontalMargin: 16,
                        fontfamily: 'medium',
                        onTap: cityValue == null
                            ? null
                            : () async {
                                setState(() {
                                  load = true;
                                });
                                var response = await Webservices.postData(
                                    url: ApiUrls.updateAddress,
                                    request: {
                                      "id": userId,
                                      "country": countryValue,
                                      "city": cityValue,
                                      "province": stateValue,
                                      // "language": languages[index]['id'].toString(),
                                    },
                                    context: context);
                                if (response['status'] == 1) {
                                  await updateSharedPreferenceFromServer();
                                  await Navigator.pushNamed(
                                      context, SelectChannelPage.id);
                                }
                                setState(() {
                                  load = false;
                                });
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
