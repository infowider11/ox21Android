import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/terms_and_conditions_page.dart';
import 'package:ox21/pages/terms_page.dart';
import 'package:ox21/widgets/buttons.dart';

import '../constants/colors.dart';
import '../constants/sized_box.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';

// enum SingingCharacter{ lafayette, jefferson, hello, option }


class Select_Audience extends StatefulWidget {
  static const String id="Select_Audience";
  bool ageRestricted;
  bool madeForKids;
  Select_Audience({Key? key, required this.ageRestricted, required this.madeForKids}) : super(key: key);

  @override
  State<Select_Audience> createState() => _Select_AudienceState();
}

class _Select_AudienceState extends State<Select_Audience> {
  // bool isChecked = true;
  // SingingCharacter? _character = SingingCharacter.lafayette;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context,[widget.madeForKids, widget.ageRestricted]);
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFeaedf6),
        appBar: appBar(context: context, title: 'Select audience', titleColor: MyColors.secondary, toolbarHeight: 50),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox2,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: ParagraphText(text: 'Is this video made for kids?', fontSize: 16, ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                        child:
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color:  Colors.black.withOpacity(0.3),
                              fontWeight:FontWeight.w400,
                              fontSize: 12,
                              // letterSpacing: letterspaceing?? 0,
                              // overflow: overflow,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                  "regardless of your location, you\'re legally required to comply with the "),
                              TextSpan(
                                text: "children\'s Online Privacy Protection Act (COPPA)",
                                style: TextStyle(
                                  color: MyColors.primaryColor
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () => {
                                  push(context: context, screen: PrivacyPolicyPage()),
                                },
                              ),
                              TextSpan(
                                  text: "and/or other laws. you\'re required to tell us whether your videos are made for kids"
                              )

                            ],),

                        ),
                      ),
                      vSizedBox2,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Radio<bool>(
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              activeColor: MyColors.secondary,
                              focusColor: MyColors.whiteColor,
                              value: true,
                              groupValue: widget.madeForKids,
                              onChanged: (value) {
                                setState(() {
                                  widget.madeForKids = true;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: ParagraphText(
                              text: 'Yes It\'s made for kids',
                              color: MyColors.heading, fontSize: 14, fontFamily: 'regular',
                            ),
                          ),
                        ],
                      ),
                      vSizedBox,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Radio<bool>(
                              visualDensity: VisualDensity.compact,
                              // materialTapTargetSize:
                              // MaterialTapTargetSize.shrinkWrap,
                              activeColor: MyColors.secondary,
                              focusColor: MyColors.whiteColor,
                              value: false,
                              groupValue: widget.madeForKids,
                              onChanged: ( value) {
                                setState(() {
                                  widget.madeForKids = false;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: ParagraphText(
                              text: 'No, It\'s not made for kids',
                              color: MyColors.heading, fontSize: 14, fontFamily: 'regular',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(height: 50,thickness: 1, color: Color(0xFF8ebfe0), indent: 0,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: ParagraphText(text: 'Age Restriction (advanced)', fontSize: 16, ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                        child: ParagraphText(text: 'Do you want to restrict your video to an adult audience?', fontSize: 16, ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                        child: ParagraphText(text: 'Age restricted videos are not shown in certain areas of youtube. these video may have limited or no ads monetization',
                          fontSize: 12, color: Colors.black.withOpacity(0.3), ),
                      ),
                      vSizedBox2,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Radio(
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              activeColor: MyColors.secondary,
                              focusColor: MyColors.whiteColor,
                              value: true,
                              groupValue: widget.ageRestricted,
                              onChanged: (value) {
                                setState(() {
                                  widget.ageRestricted = true;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: ParagraphText(
                              text: 'Yes, restrict my video to over 18',
                              color: MyColors.heading, fontSize: 14, fontFamily: 'regular',
                            ),
                          ),
                        ],
                      ),
                      vSizedBox,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Radio(
                              visualDensity: VisualDensity.compact,
                              // materialTapTargetSize:
                              // MaterialTapTargetSize.shrinkWrap,
                              activeColor: MyColors.secondary,
                              focusColor: MyColors.whiteColor,
                              value: false,
                              groupValue: widget.ageRestricted,
                              onChanged: (value) {
                                setState(() {
                                  widget.ageRestricted = false;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: ParagraphText(
                                text: 'No, don\'t restrict my video to viewers over 18',
                                color: MyColors.heading, fontSize: 14, fontFamily: 'regular',
                              ),
                            ),
                          ),
                        ],
                      ),
                      vSizedBox2,
                      RoundEdgedButton(
                        text: 'UPLOAD VIDEO',
                        textColor: Colors.white,
                        color: MyColors.secondary,
                        borderRadius: 30,
                        height: 45,
                        fontfamily: 'regular',
                        onTap: (){
                          Navigator.pop(context,[widget.madeForKids, widget.ageRestricted]);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
