import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/intro.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:flutter_translate/flutter_translate.dart';

class WelcomePage extends StatefulWidget {
  static const String id="welcome";
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MyImages.welcomeback),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter
              ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              vSizedBox8,
              vSizedBox4,
              Image.asset(MyImages.logowelcom, width: 74,),
              vSizedBox8,
              ParagraphText(
                text:translate("welcome.title"),
                color: MyColors.heading, fontSize: 32,
                textAlign: TextAlign.center,
                fontFamily: 'openextrabold',
              ),
              vSizedBox2,
              ParagraphText(
                text: translate("welcome.subTitle"),
                color: MyColors.para, fontSize: 16,
                fontFamily: 'openregular',
                textAlign: TextAlign.center,
              ),
              vSizedBox4,
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, EntroPage.id);
                },
                  child: Image.asset(MyImages.go, width: 49,)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
