import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/create_password.dart';
import 'package:ox21/login.dart';
import 'package:ox21/register.dart';
import 'package:ox21/secure_account_step_one.dart';
import 'package:ox21/signin_mnemonic.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'constants/colors.dart';
import 'constants/image_urls.dart';
import 'constants/sized_box.dart';
import 'package:flutter_translate/flutter_translate.dart';

class EntroPage extends StatefulWidget {
  static const String  id="intro";
  const EntroPage({Key? key}) : super(key: key);

  @override
  _EntroPageState createState() => _EntroPageState();
}

class _EntroPageState extends State<EntroPage> {
  PageController controller = PageController();

  page1(){
    return Container(
      color: MyColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          vSizedBox8,
          vSizedBox6,
          vSizedBox6,
          Image.asset(MyImages.intro1,
            width:200,

            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0,),
            child: MainHeadingText(
              text:translate("intro.title1"),
              textAlign: TextAlign.center,
              fontFamily: 'opensemibold',
              color: MyColors.introparacolor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
  page2(){
    return Container(
      color: MyColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          vSizedBox8,
          vSizedBox6,
          vSizedBox6,
          Image.asset(MyImages.intro2,
            width:240,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20),
            child: MainHeadingText(
              text:translate("intro.title2"),
              textAlign: TextAlign.center,
              fontFamily: 'opensemibold',
              color: MyColors.introparacolor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
  page3(){
    return Container(
      color: MyColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          vSizedBox8,
          vSizedBox6,
          vSizedBox6,
          Image.asset(
            MyImages.intro3,
            width:260,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0,),
            child: MainHeadingText(
              text:translate("intro.title3"),
              textAlign: TextAlign.center,
              fontFamily: 'opensemibold',
              color: MyColors.introparacolor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [

              PageView.builder(
                itemCount: 3,
                controller: controller,
                itemBuilder: (context, index){
                  switch(index){
                    case 0: return page1();
                    case 1: return page2();
                    case 2: return page3();
                    default: return page1();
                  }
                },
              ),
              Positioned(
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    RoundEdgedButton(
                      text: translate("intro.createButton"),
                      textColor: Colors.white,
                      color: MyColors.primaryColor,
                      borderRadius: 12,
                      width: MediaQuery.of(context).size.width - 32,
                      fontSize: 16,
                      verticalPadding: 0,
                      horizontalMargin: 16,
                      fontfamily: 'medium',
                      onTap: (){
                        Navigator.pushNamed(context, Step_one.id);
                      },
                    ),
                    vSizedBox2,
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, SignInPage.id);
                      },
                      child: ParagraphText(
                        text: translate("intro.SignIn"),
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'medium',
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 15,
                right: 16,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(MyImages.logowelcom, width: 35,),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 160,
                // right: 32,
                // alignment: Alignment.center,
                child: SmoothPageIndicator(
                    controller: controller,  // PageController
                    count:  3,
                    effect:  WormEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        activeDotColor: MyColors.primaryColor,
                        dotColor: MyColors.dot

                    ),  // your preferred effect
                    onDotClicked: (index){

                    }
                ) ,
              ),
              // Positioned(
              //   bottom: 20,
              //   right: 32,
              //   child: GestureDetector(
              //     onTap: (){
              //       // Navigator.pushNamed(context, LoginPage.id);
              //     },
              //     child: Container(
              //       decoration: BoxDecoration(
              //           color: MyColors.primaryColor,
              //           borderRadius: BorderRadius.circular(12)
              //       ),
              //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              //       child: Icon(Icons.arrow_forward, color: Colors.white,),
              //     ),
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
