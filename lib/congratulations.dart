import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/login.dart';
import 'package:ox21/register.dart';
import 'package:ox21/select_language.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customtextfield.dart';

import 'constants/global_constants.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CongratulationsPage extends StatefulWidget {
  static const String id="congratulations";
  const CongratulationsPage({Key? key}) : super(key: key);

  @override
  State<CongratulationsPage> createState() => _CongratulationsPageState();
}

class _CongratulationsPageState extends State<CongratulationsPage> {
  @override
  Widget build(BuildContext context) {
    print(userId);
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: appBar(context: context,implyLeading: false,
            actions: [
              IconButton(onPressed: (){}, icon: Image.asset(MyImages.logowelcom, width: 35, height: 40, fit: BoxFit.fitHeight,))
            ]
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  vSizedBox2,
                  Center(
                      child: Image.asset(MyImages.logo_hori, height: 46,)
                  ),
                  vSizedBox4,
                  ParagraphText(text:translate("Congratulations.title"),
                    // 'Congratulations',
                    fontSize: 24,
                    fontFamily: 'bold',
                  ),
                  Image.asset(MyImages.confirm,
                  width: MediaQuery.of(context).size.width,
                  ),
                  // ParagraphText(text: 'A confirmation email has been sent to\nyour email address. ',
                  //   fontSize: 16,
                  //   textAlign: TextAlign.center,
                  //   fontFamily: 'regular',
                  //   color: MyColors.textcolor,
                  // ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ParagraphText(text:translate("Congratulations.subTitle"),
                    // 'You\'ve successfully secured your account. Remember to keep your mnemonic phrase safe, it\'s your responsibility!',
                    textAlign: TextAlign.center,
                      color: MyColors.textcolor,
                      fontSize: 14,
                    ),
                    vSizedBox2,
                    GestureDetector(
                      onTap: (){
                        // Navigator.pushNamed(context, LoginPage.id);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ParagraphText(
                            text: translate("Congratulations.hint"),
                            color: MyColors.primaryColor,
                            fontSize: 16,
                            underlined: true,
                            fontFamily: 'bold',
                          ),
                        ],
                      ),
                    ),
                    vSizedBox4,
                    ParagraphText(text:translate("Congratulations.text2"),
                      textAlign: TextAlign.center,
                      color: MyColors.textcolor,
                      fontSize: 14,
                      ),
                    vSizedBox2,
                    RoundEdgedButton(
                      text: translate("Congratulations.continueBtn"),
                      verticalMargin: 20,
                      textColor: Colors.white,
                      color: MyColors.primaryColor,
                      borderRadius: 12,
                      width: MediaQuery.of(context).size.width - 32,
                      fontSize: 16,
                      horizontalMargin: 16,
                      fontfamily: 'medium',
                      onTap: (){
                        Navigator.pushReplacementNamed(context, Select_language.id);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



