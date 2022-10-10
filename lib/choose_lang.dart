import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';

class ChooseLanguage extends StatefulWidget {
  static const String id = "chooseLanguage";
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whitelight,
      appBar: appBar(context: context, title: 'Choose Language',),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    height: 130,
                    decoration: BoxDecoration(
                      color: MyColors.whitelight,
                      borderRadius: BorderRadius.circular(8),
                      // border: Border.all(color: MyColors.black54Color, width: 1)
                      boxShadow: [BoxShadow(
                        color: MyColors.greyColor,
                        blurRadius: 4,
                        spreadRadius: 2,
                        offset: Offset(0, 5)
                      )],
                      border: Border.all(
                        color: MyColors.grey,
                        width: 1
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/usa.png', width: 80,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MainHeadingText(text: 'English', fontSize: 12,),
                            Icon(Icons.check, size: 16,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.only(bottom: 16, left: 16, right: 16
                    ),
                    height: 130,
                    decoration: BoxDecoration(
                        color: MyColors.whitelight,
                        borderRadius: BorderRadius.circular(8),
                        // border: Border.all(color: MyColors.black54Color, width: 1)
                        boxShadow: [BoxShadow(
                            color: MyColors.greyColor,
                            blurRadius: 4,
                            spreadRadius: 2,
                            offset: Offset(0, 5)
                        )],
                        // border: Border.all(
                        //     color: MyColors.grey,
                        //     width: 1
                        // )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/china.png', width: 80,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MainHeadingText(text: 'China', fontSize: 12,),
                            // Icon(Icons.check, size: 16,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
