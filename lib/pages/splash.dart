import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../select_channels.dart';
import '../select_language.dart';
import '../select_location.dart';
import '../tab.dart';

class SplashScreenPage extends StatefulWidget {
  static const String id="splash";
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 3)).then((value){
    //   Navigator.pushNamed(context, WelcomePage.id);
    //
    // });
    navigateToPage();
  }


  navigateToPage()async{
    await Future.delayed(Duration(seconds: 2));
    try{
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      print(sharedPreferences.getString('data'));
      if (sharedPreferences.getString('data') == null) {
        print('dkljslfkj');
        Navigator.pushReplacementNamed(context, WelcomePage.id);
      } else {
        print(sharedPreferences.getString('data'));
        Map userMap = jsonDecode(sharedPreferences.getString('data')!);
        print('the data is ');
        print(userMap['channels']);
        userId = userMap['id'].toString();
        userData = userMap;
        if (userMap['language'] == 0)
          Navigator.pushReplacementNamed(context, Select_language.id);
        else if (userMap['country'] == null  && sharedPreferences.getString('skippedLocation')==null) {
          print('kldvhnjklf');
          print(sharedPreferences.getString('skippedLocation'));
          await Navigator.pushReplacementNamed(context, Select_location.id);

        } else if ((userMap['channels'] as List).length==0) {
          Navigator.pushReplacementNamed(context, SelectChannelPage.id);
        } else {
          Navigator.pushReplacementNamed(context, MyStatefulWidget.id);
        }
      }
    }catch(e){
      print('Error in try block $e');
      Navigator.pushReplacementNamed(context, WelcomePage.id);
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
          MyImages.splash,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
