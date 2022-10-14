import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_functions.dart';
import 'package:ox21/select_location.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/customtextfield.dart';

import 'constants/colors.dart';
import 'constants/image_urls.dart';
import 'constants/sized_box.dart';
import 'package:flutter_translate/flutter_translate.dart';

class Select_language extends StatefulWidget {
  static const String id = "language";
  const Select_language({Key? key}) : super(key: key);

  @override
  State<Select_language> createState() => _Select_languageState();
}

class _Select_languageState extends State<Select_language> {
  bool load = false;
  TextEditingController searchController = TextEditingController();
  String? selectedLanguage;



  getLanguages() async {
    setState(() {
      load = true;
    });
    languages = await Webservices.getList(ApiUrls.getLanguages);
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      appBar: load
          ? null
          : appBar(context: context,implyLeading: false, actions: [
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ParagraphText(
                        text: translate("select_language.selectLang"),
                        fontSize: 18,
                        fontFamily: 'bold',
                      ),
                    ),
                    vSizedBox,
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      child: CustomTextFieldlabel(
                        labeltext: translate("select_language.searchInLang"),
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
                          child:languages.length==0?Center(child: Text(translate("select_language.noData"))): ListView.builder(
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
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     ParagraphText(
                      //       text: 'By proceeding, you agree to these ',
                      //       color: MyColors.lighttext,
                      //       fontSize: 12,
                      //       fontFamily: 'regular',
                      //     ),
                      //     ParagraphText(
                      //       text: 'Term and Conditions.',
                      //       color: MyColors.primaryColor,
                      //       fontSize: 12,
                      //       fontFamily: 'regular',
                      //     ),
                      //   ],
                      // ),
                      vSizedBox2,
                      RoundEdgedButton(
                        text: translate("select_language.continueBtn"),
                        textColor: Colors.white,
                        color:selectedLanguage==null?Colors.grey.shade300: MyColors.primaryColor,
                        borderRadius: 12,
                        width: MediaQuery.of(context).size.width - 32,
                        fontSize: 16,
                        horizontalMargin: 16,
                        fontfamily: 'medium',
                        onTap:selectedLanguage==null?null: () async{

                          setState(() {
                            load = true;
                          });
                          var response = await Webservices.postData(url: ApiUrls.updateUserLanguage, request: {
                            "id": userId,
                            "language": selectedLanguage,
                            // "language": languages[index]['id'].toString(),
                          }, context: context);
                          if(response['status']==1){
                            await updateSharedPreferenceFromServer();
                            await Navigator.pushReplacementNamed(context, Select_location.id);
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
