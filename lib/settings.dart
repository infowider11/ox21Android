import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/deleteaccount.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/mycoins.dart';
import 'package:ox21/pages/add_web_storage_token.dart';
import 'package:ox21/pages/community_court_page.dart';
import 'package:ox21/pages/friend_and_family/group_list_page.dart';
import 'package:ox21/pages/in_app_purchase/sample_page.dart';
import 'package:ox21/pages/make_payment_for_banner_page.dart';
import 'package:ox21/pages/make_payment_for_domain_page.dart';
import 'package:ox21/pages/my_private_channels.dart';
import 'package:ox21/pages/my_purchased_banners.dart';
import 'package:ox21/pages/my_purchased_domains.dart';
import 'package:ox21/pages/my_subscribed_channels_page.dart';
import 'package:ox21/pages/my_video_page.dart';
import 'package:ox21/pages/rent_banner/my_rented_banners.dart';
import 'package:ox21/pages/rent_banner/rent_banner_page.dart';
import 'package:ox21/pages/terms_and_conditions_page.dart';
import 'package:ox21/pages/vmails_page.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static const String id="settings";
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Settings', implyLeading: false),
      body: Container(
        margin: EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.face_outlined, color: MyColors.primaryColor,
                ),
                title: Text('My Coins', style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 16,
                  fontFamily: 'medium',
                ),),
                onTap: (){
                  Navigator.pushNamed(context, MyCoinsPage.id);
                },
              ),
              Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
              vSizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.subscriptions_outlined, color: MyColors.primaryColor,
                    ),
                    title: Text('Friends & Family', style: TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 16,
                      fontFamily: 'medium',
                    ),
                    ),
                    onTap: (){
                      push(context: context, screen: FriendsAndFamilyGroupListPage(

                      ));
                    },
                  ),

                  Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
                  vSizedBox,
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.subscriptions_outlined, color: MyColors.primaryColor,
                    ),
                    title: Text('Add Web Storage Token', style: TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 16,
                      fontFamily: 'medium',
                    ),
                    ),
                    onTap: (){
                      push(context: context, screen: AddWebStorageTokenPage(

                      ));
                    },
                  ),

                  Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
                  vSizedBox,
                ],
              ),
              ListTile(
                leading: Icon(
                  Icons.subscriptions_outlined, color: MyColors.primaryColor,
                ),
                title: Text('My Subscribed Channels', style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 16,
                  fontFamily: 'medium',
                ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, MySubscribedChannels.id);
                },
              ),
              Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
              vSizedBox,
              ListTile(
                leading: Icon(
                  Icons.subscriptions_outlined, color: MyColors.primaryColor,
                ),
                title: Text('My Private Channels', style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 16,
                  fontFamily: 'medium',
                ),
                ),
                onTap: (){
                  // Navigator.pushNamed(context, MyPrivateChannels.id);
                  push(context: context, screen: MyPrivateChannels());
                },
              ),
              Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
              vSizedBox,
              ListTile(
                leading: Icon(
                  Icons.subscriptions_outlined, color: MyColors.primaryColor,
                ),
                title: Text('My Purchased Domains', style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 16,
                  fontFamily: 'medium',
                ),
                ),
                onTap: (){
                  push(context: context, screen: MyPurchasedDomains());
                },
              ),

              Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
              vSizedBox,
              ListTile(
                leading: Icon(
                  Icons.subscriptions_outlined, color: MyColors.primaryColor,
                ),
                title: Text('My Purchased Banners', style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 16,
                  fontFamily: 'medium',
                ),
                ),
                onTap: (){
                  push(context: context, screen: MyPurchasedBanners());
                },
              ),

              Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
              vSizedBox,
              ListTile(
                leading: Icon(
                  Icons.play_circle_outline_outlined, color: MyColors.primaryColor,
                ),
                title: Text('My Videos', style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 16,
                  fontFamily: 'medium',
                ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, My_Videos_Page.id);
                },
              ),
              Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
              vSizedBox,
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 ListTile(
                   leading: Icon(
                     Icons.subscriptions_outlined, color: MyColors.primaryColor,
                   ),
                   title: Text('Make Payment For Banner', style: TextStyle(
                     color: MyColors.primaryColor,
                     fontSize: 16,
                     fontFamily: 'medium',
                   ),
                   ),
                   onTap: (){
                     push(context: context, screen: MakePaymentForBannerPage());
                   },
                 ),

                 Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
                 vSizedBox,
               ],
             ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.subscriptions_outlined, color: MyColors.primaryColor,
                    ),
                    title: Text('Make Payment For Domain', style: TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 16,
                      fontFamily: 'medium',
                    ),
                    ),
                    onTap: (){
                      push(context: context, screen: MakePaymentForDomainPage());
                    },
                  ),

                  Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
                  vSizedBox,
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.subscriptions_outlined, color: MyColors.primaryColor,
                    ),
                    title: Text('Rent a Banner', style: TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 16,
                      fontFamily: 'medium',
                    ),
                    ),
                    onTap: (){
                      push(context: context, screen: RentBannerPage(

                      ));
                    },
                  ),

                  Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
                  vSizedBox,
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.subscriptions_outlined, color: MyColors.primaryColor,
                    ),
                    title: Text('My Rented Banners', style: TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 16,
                      fontFamily: 'medium',
                    ),
                    ),
                    onTap: (){
                      push(context: context, screen: MyRentedBannersPage(

                      ));
                    },
                  ),

                  Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
                  vSizedBox,
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.subscriptions_outlined, color: MyColors.primaryColor,
                    ),
                    title: Text('VMail', style: TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 16,
                      fontFamily: 'medium',
                    ),
                    ),
                    onTap: (){
                      push(context: context, screen: VMailPage());
                    },
                  ),

                  Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
                  vSizedBox,
                ],
              ),
              ListTile(
                leading: Icon(
                  Icons.subscriptions_outlined, color: MyColors.primaryColor,
                ),
                title: Text('Community Court', style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 16,
                  fontFamily: 'medium',
                ),
                ),
                onTap: (){
                  push(context: context, screen: CommunityCourtPage());
                },
              ),

              Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
              vSizedBox,
              ListTile(
                leading:Icon(
                  Icons.delete_outlined, color: Colors.red,
                ),
                title: Text('Delete Account', style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 16,
                  fontFamily: 'medium',
                ),
                ),
                onTap: ()async{
                  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  // sharedPreferences.clear();
                  Navigator.pushNamed(context, DeleteAccountPage.id);
                },
              ),
              Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
              vSizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.subscriptions_outlined, color: MyColors.primaryColor,
                    ),
                    title: Text('Terms & Conditions', style: TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 16,
                      fontFamily: 'medium',
                    ),
                    ),
                    onTap: (){
                      push(context: context, screen: TermsAndConditionsPage());
                    },
                  ),

                  Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
                  vSizedBox,
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.subscriptions_outlined, color: MyColors.primaryColor,
                    ),
                    title: Text('Privacy Policy', style: TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 16,
                      fontFamily: 'medium',
                    ),
                    ),
                    onTap: (){
                      push(context: context, screen: PrivacyPolicyPage());
                    },
                  ),

                  Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
                  vSizedBox,
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.subscriptions_outlined, color: MyColors.primaryColor,
                    ),
                    title: Text('Copyrights', style: TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 16,
                      fontFamily: 'medium',
                    ),
                    ),
                    onTap: (){

                      ///TODO: yaha in app purchase ka code he vo remove krna he end me

                      push(context: context, screen: SampleInAppPurchasePage());
                      // push(context: context, screen: CopyrightPage());
                    },
                  ),

                  Divider(indent: 65, height: 10, thickness: 0.5, color: MyColors.primaryColor,),
                  vSizedBox,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
