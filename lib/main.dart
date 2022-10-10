import 'package:flutter/material.dart';
import 'package:ox21/cart.dart';
import 'package:ox21/chat.dart';
import 'package:ox21/congratulations.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/create_password.dart';
import 'package:ox21/deleteaccount.dart';
import 'package:ox21/home.dart';
import 'package:ox21/intro.dart';
import 'package:ox21/login.dart';
import 'package:ox21/mycoins.dart';
import 'package:ox21/pages/add_description.dart';
import 'package:ox21/pages/add_detail.dart';
import 'package:ox21/pages/add_screenshot.dart';
import 'package:ox21/pages/add_to_cart.dart';
import 'package:ox21/pages/btc_send_page.dart';
import 'package:ox21/pages/content_creator_page.dart';
import 'package:ox21/pages/content_creator_post_now_page.dart';
import 'package:ox21/pages/my_subscribed_channels_page.dart';
import 'package:ox21/pages/my_video_page.dart';
import 'package:ox21/pages/qr_code_page.dart';
import 'package:ox21/pages/search_domain_page.dart';
import 'package:ox21/pages/select_audience.dart';
import 'package:ox21/pages/set_visibility.dart';
import 'package:ox21/pages/splash.dart';
import 'package:ox21/pages/top_banner_bid_page.dart';
import 'package:ox21/pages/upload_page.dart';
import 'package:ox21/register.dart';
import 'package:ox21/search.dart';
import 'package:ox21/secure_account_step_next.dart';
import 'package:ox21/secure_account_step_one.dart';
import 'package:ox21/secure_account_step_two.dart';
import 'package:ox21/select_channels.dart';
import 'package:ox21/select_language.dart';
import 'package:ox21/select_location.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/settings.dart';
import 'package:ox21/signin_mnemonic.dart';
import 'package:ox21/tab.dart';
import 'package:ox21/top_banner_bid_chennels.dart';
import 'package:ox21/top_banner_bid_country.dart';
import 'package:ox21/top_banner_purchase_bid_language.dart';
import 'package:ox21/upload_video_view.dart';
import 'package:ox21/walletpage.dart';
import 'package:ox21/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'choose_lang.dart';
import 'constants/global_constants.dart';

void main() async{
  // print('hi');
  WidgetsFlutterBinding.ensureInitialized();
  channels = await Webservices.getList(ApiUrls.getChannels);
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // // print(sharedPreferences.getString('data'));
  // print('hello');
  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: MyGlobalKeys.navigatorKey,
      title: '',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  ChooseLanguage(),
      routes: {
        EntroPage.id:(context)=> EntroPage(),
        LoginPage.id:(context)=> LoginPage(),
        RegisterPage.id:(context)=> RegisterPage(),
        CongratulationsPage.id:(context)=> CongratulationsPage(),
        // CreatePassword.id:(context)=> CreatePassword(),
        Step_one.id:(context)=> Step_one(),
        // Step_two.id:(context)=> Step_two(),
        SignInPage.id:(context)=> SignInPage(),
        Select_language.id:(context)=> Select_language(),
        Select_location.id:(context)=> Select_location(),
        SelectChannelPage.id:(context)=> SelectChannelPage(),
        // Home_Page.id:(context)=> Home_Page(),
        MyStatefulWidget.id:(context)=> MyStatefulWidget(),
        WalletPage.id:(context)=> WalletPage(),
        SearchPage.id:(context)=> SearchPage(),
        ChatPage.id:(context)=> ChatPage(),
        BTCSendPage.id:(context)=> BTCSendPage(),
        // SearchDomainPage.id:(context)=> SearchDomainPage(),
        ScanQRCodePage.id:(context)=> ScanQRCodePage(),
        ContentCreatorPage.id:(context)=> ContentCreatorPage(),
        ContentCreatorPostNowPage.id:(context)=> ContentCreatorPostNowPage(),
        TopBannerBidPage.id:(context)=> TopBannerBidPage(),
        MySubscribedChannels.id:(context)=> MySubscribedChannels(),
        MyCoinsPage.id:(context)=> MyCoinsPage(),
        // Step_nextPage.id:(context)=> Step_nextPage(),
        // TopBannerLanguagePage.id:(context)=> TopBannerLanguagePage(),
        // TopBannerBidCountryPage.id:(context)=> TopBannerBidCountryPage(),
        // top_banner_chennel.id:(context)=> top_banner_chennel(),
        // Cart.id:(context)=> Cart(),
        Addtocart.id:(context)=> Addtocart(),
        SettingsPage.id:(context)=> SettingsPage(),
        DeleteAccountPage.id:(context)=> DeleteAccountPage(),
        SplashScreenPage.id:(context)=> SplashScreenPage(),
        WelcomePage.id:(context)=> WelcomePage(),
        Upload_Page.id:(context)=> Upload_Page(),
        // UploadPageView.id:(context)=> UploadPageView(),
        // Add_Detail_Page.id:(context)=> Add_Detail_Page(),
        // Add_Description_Page.id:(context)=> Add_Description_Page(),
        // Set_visibility_Page.id:(context)=> Set_visibility_Page(),
        // Add_Screenshot_page.id:(context)=> Add_Screenshot_page(),
        // Select_Audience.id:(context)=> Select_Audience(),
        My_Videos_Page.id:(context)=> My_Videos_Page(),
        // ChooseLanguage.id:(context)=> ChooseLanguage(),
      }
    );
  }
}

