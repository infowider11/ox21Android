import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ox21/tab.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customtextfield.dart';

import 'constants/colors.dart';
import 'constants/image_urls.dart';
import 'constants/sized_box.dart';
class SearchPage extends StatefulWidget {
  static const String id="search";
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      // appBar: appBar(context: context,
      //     actions: [
      //       IconButton(onPressed: (){}, icon: Image.asset(MyImages.logowelcom, width: 35, height: 40, fit: BoxFit.fitHeight,))
      //     ]
      // ),
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        leading:  GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.west_outlined, color: Colors.black,)
        ),
        leadingWidth: 30,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: CustomTextFieldlabel(
            labeltext: 'Search in Channels',
            controller: emailcontroller,
            hintText: 'labeltext',
            left: 16,
            fontsize: 12,
            hintcolor: MyColors.inputbordercolor,
            suffixIcon: MyImages.voicesearch,
            bgColor: Color(0xFFF2F2F2),
            border: Border.all(color: MyColors.strokelabel),
            icon: Icons.search,
            borderRadius: 16,
            paddingsuffix: 14,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  // margin: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ParagraphText(text: 'Popular Channels/Domains',fontFamily: 'bold', fontSize: 16, color: MyColors.primaryColor,),
                      vSizedBox2,
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Stack(

                                  children: [

                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        // height: 48,
                                        width: MediaQuery.of(context).size.width,
                                        child: Image.asset(MyImages.spa,  fit: BoxFit.fitHeight, height: 48,),
                                      ),
                                    ),
                                    Positioned(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          color: Color.fromRGBO(0, 0, 0, 0.6),
                                          height: 48,
                                          width: MediaQuery.of(context).size.width,
                                          child: Center(child: Image.asset(MyImages.check,  fit: BoxFit.contain, width: 25,)),
                                        ),
                                      ),
                                    ),
                                  ],
                                  clipBehavior: Clip.antiAlias,
                                ),
                                vSizedBox,
                                ParagraphText(text: 'Spa/Beauty', fontSize: 12, color: MyColors.primaryColor,)
                              ],
                            ),
                          ),
                          hSizedBox,
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        // height: 48,
                                        width: MediaQuery.of(context).size.width,
                                        child: Image.asset(MyImages.spa,  fit: BoxFit.fitHeight, height: 48,),
                                      ),
                                    ),
                                    // Positioned(
                                    //   child: ClipRRect(
                                    //     borderRadius: BorderRadius.circular(12),
                                    //     child: Container(
                                    //       color: Color.fromRGBO(0, 0, 0, 0.6),
                                    //       height: 48,
                                    //       width: MediaQuery.of(context).size.width,
                                    //       child: Center(child: Image.asset(MyImages.check,  fit: BoxFit.contain, width: 25,)),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                  clipBehavior: Clip.antiAlias,
                                ),
                                vSizedBox,
                                ParagraphText(text: 'Spa/Beauty', fontSize: 12, color: MyColors.primaryColor,)
                              ],
                            ),
                          ),
                          hSizedBox,
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Stack(

                                  children: [

                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        // height: 48,
                                        width: MediaQuery.of(context).size.width,
                                        child: Image.asset(MyImages.spa,  fit: BoxFit.fitHeight, height: 48,),
                                      ),
                                    ),
                                    // Positioned(
                                    //   child: ClipRRect(
                                    //     borderRadius: BorderRadius.circular(12),
                                    //     child: Container(
                                    //       color: Color.fromRGBO(0, 0, 0, 0.6),
                                    //       height: 48,
                                    //       width: MediaQuery.of(context).size.width,
                                    //       child: Center(child: Image.asset(MyImages.check,  fit: BoxFit.contain, width: 25,)),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                  clipBehavior: Clip.antiAlias,
                                ),
                                vSizedBox,
                                ParagraphText(text: 'Spa/Beauty', fontSize: 12, color: MyColors.primaryColor,)
                              ],
                            ),
                          ),
                          hSizedBox,
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        // height: 48,
                                        width: MediaQuery.of(context).size.width,
                                        child: Image.asset(MyImages.spa,  fit: BoxFit.fitHeight, height: 48,),
                                      ),
                                    ),
                                    // Positioned(
                                    //   child: ClipRRect(
                                    //     borderRadius: BorderRadius.circular(12),
                                    //     child: Container(
                                    //       color: Color.fromRGBO(0, 0, 0, 0.6),
                                    //       height: 48,
                                    //       width: MediaQuery.of(context).size.width,
                                    //       child: Center(child: Image.asset(MyImages.check,  fit: BoxFit.contain, width: 25,)),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                  clipBehavior: Clip.antiAlias,
                                ),
                                vSizedBox,
                                ParagraphText(text: 'Spa/Beauty', fontSize: 12, color: MyColors.primaryColor,)
                              ],
                            ),
                          ),
                        ],
                      ),
                      vSizedBox,
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Stack(

                                  children: [

                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        // height: 48,
                                        width: MediaQuery.of(context).size.width,
                                        child: Image.asset(MyImages.spa,  fit: BoxFit.fitHeight, height: 48,),
                                      ),
                                    ),
                                    // Positioned(
                                    //   child: ClipRRect(
                                    //     borderRadius: BorderRadius.circular(12),
                                    //     child: Container(
                                    //       color: Color.fromRGBO(0, 0, 0, 0.6),
                                    //       height: 48,
                                    //       width: MediaQuery.of(context).size.width,
                                    //       child: Center(child: Image.asset(MyImages.check,  fit: BoxFit.contain, width: 25,)),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                  clipBehavior: Clip.antiAlias,
                                ),
                                vSizedBox,
                                ParagraphText(text: 'Spa/Beauty', fontSize: 12, color: MyColors.primaryColor,)
                              ],
                            ),
                          ),
                          hSizedBox,
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        // height: 48,
                                        width: MediaQuery.of(context).size.width,
                                        child: Image.asset(MyImages.spa,  fit: BoxFit.fitHeight, height: 48,),
                                      ),
                                    ),
                                    // Positioned(
                                    //   child: ClipRRect(
                                    //     borderRadius: BorderRadius.circular(12),
                                    //     child: Container(
                                    //       color: Color.fromRGBO(0, 0, 0, 0.6),
                                    //       height: 48,
                                    //       width: MediaQuery.of(context).size.width,
                                    //       child: Center(child: Image.asset(MyImages.check,  fit: BoxFit.contain, width: 25,)),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                  clipBehavior: Clip.antiAlias,
                                ),
                                vSizedBox,
                                ParagraphText(text: 'Spa/Beauty', fontSize: 12, color: MyColors.primaryColor,)
                              ],
                            ),
                          ),
                          hSizedBox,
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Stack(

                                  children: [

                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        // height: 48,
                                        width: MediaQuery.of(context).size.width,
                                        child: Image.asset(MyImages.spa,  fit: BoxFit.fitHeight, height: 48,),
                                      ),
                                    ),
                                    Positioned(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          color: Color.fromRGBO(0, 0, 0, 0.6),
                                          height: 48,
                                          width: MediaQuery.of(context).size.width,
                                          child: Center(child: Image.asset(MyImages.check,  fit: BoxFit.contain, width: 25,)),
                                        ),
                                      ),
                                    ),
                                  ],
                                  clipBehavior: Clip.antiAlias,
                                ),
                                vSizedBox,
                                ParagraphText(text: 'Spa/Beauty', fontSize: 12, color: MyColors.primaryColor,)
                              ],
                            ),
                          ),
                          hSizedBox,
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        // height: 48,
                                        width: MediaQuery.of(context).size.width,
                                        child: Image.asset(MyImages.spa,  fit: BoxFit.fitHeight, height: 48,),
                                      ),
                                    ),
                                    // Positioned(
                                    //   child: ClipRRect(
                                    //     borderRadius: BorderRadius.circular(12),
                                    //     child: Container(
                                    //       color: Color.fromRGBO(0, 0, 0, 0.6),
                                    //       height: 48,
                                    //       width: MediaQuery.of(context).size.width,
                                    //       child: Center(child: Image.asset(MyImages.check,  fit: BoxFit.contain, width: 25,)),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                  clipBehavior: Clip.antiAlias,
                                ),
                                vSizedBox,
                                ParagraphText(text: 'Spa/Beauty', fontSize: 12, color: MyColors.primaryColor,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                vSizedBox2,
                RoundEdgedButton(
                  text: 'Continue',
                  textColor: Colors.white,
                  color: MyColors.primaryColor,
                  borderRadius: 12,
                  width: MediaQuery.of(context).size.width - 32,
                  fontSize: 16,
                  verticalPadding: 20,
                  horizontalMargin: 16,
                  fontfamily: 'medium',
                  onTap: (){
                    Navigator.pushNamed(context, MyStatefulWidget.id);
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
