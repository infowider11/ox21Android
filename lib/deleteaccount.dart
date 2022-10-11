import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/splash.dart';
import 'package:ox21/register.dart';
import 'package:ox21/secure_account_step_one.dart';
import 'package:ox21/select_language.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/confirmation_dialog.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import'package:flutter_translate/flutter_translate.dart';

class DeleteAccountPage extends StatefulWidget {
  static const String id="delte";
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  bool isChecked = false;
  TextEditingController passPhraseController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return MyColors.primaryColor;
  }
  bool load = false;
  @override
  Widget build(BuildContext context) {
    bool isSwitched = true;
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      appBar: appBar(context: context,
          title:translate("deleteAccount.title"),
          titleColor: MyColors.primaryColor,
          actions: [
            IconButton(onPressed: (){}, icon: Image.asset(MyImages.logowelcom, width: 35, height: 40, fit: BoxFit.fitHeight,))
          ]
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox,
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: ParagraphText(text: 'Delete Account',
                //     fontSize: 18,
                //     fontFamily: 'bold',
                //   ),
                // ),
                vSizedBox4,
                Stack(
                  children: [

                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    //   child: CustomTextFieldlabel(
                    //     labeltext: 'Mnemonic phrase',
                    //     controller: passPhraseController,
                    //     hintText: '***** **** **** ***** ',
                    //     left: 16,
                    //     fontsize: 12,
                    //     hintcolor: MyColors.inputbordercolor,
                    //     maxLines: 3,
                    //     suffixIcon: MyImages.scan,
                    //     bgColor: Colors.white,
                    //     border: Border.all(color: MyColors.strokelabel),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      child: CustomTextFieldlabel(
                        labeltext: translate("forgot.mnemonic"),
                        controller: passPhraseController,
                        hintText:  translate("forgot.alert1"),
                        left: 16,
                        fontsize: 12,
                        hintcolor: MyColors.inputbordercolor,
                        suffixIcon: MyImages.scan,
                        bgColor: Colors.white,
                        border: Border.all(color: MyColors.strokelabel),
                        onChanged: (value){
                          setState(() {

                          });
                        },
                      ),
                    ),
                    // Positioned(
                    //   child: Image.asset(MyImages.eye_visble, width: 24,),
                    //   right: 60,
                    //   top: 20,
                    // ),
                  ],
                ),

              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ParagraphText(
                      text:
                      translate("deleteAccount.alrt1"),
                      // 'Once you delete an account, there is no way to recover it\nAre you sure you want to delete your account?',
                      color: MyColors.lighttext,
                      fontSize: 12,
                      fontFamily: 'regular',
                    ),
                  ],
                ),
                vSizedBox2,
                RoundEdgedButton(
                  text: translate("deleteAccount.title"),
                  textColor: Colors.white,
                  color: Color(0xFFDC2430),
                  borderRadius: 12,
                  width: MediaQuery.of(context).size.width - 32,
                  fontSize: 16,
                  verticalPadding: 20,
                  horizontalMargin: 16,
                  fontfamily: 'medium',
                  onTap: ()async{
                    FocusScope.of(context).requestFocus(new FocusNode());
                    List words = passPhraseController.text.split(" ");
                    Uuid uuid = Uuid();
                    String typedPhrase =
                    uuid.v5(Uuid.NAMESPACE_URL, passPhraseController.text);
                    if(words.length!=12){
                      print('the words length is ${words.length}');
                      showSnackbar(context, translate("forgot.alert1"));
                    }else if(typedPhrase!=userData!['uuid']){
                      showSnackbar(context, translate("deleteAccount.alert3"));
                    }else{
                      bool? result = await showCustomConfirmationDialog(
                          description: translate("deleteAccount.alrt2")
                      );

                      if(result== true){
                        load = true;
                        setState(() {

                        });
                        var request = {
                          'user_id': userId,
                          'uuid': userData!['uuid']??'nil'
                        };
                        var jsonResponse = await Webservices.postData(url: ApiUrls.delete_account, request: request, context: context);
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.clear();
                        load = false;
                        setState(() {

                        });
                        Navigator.popUntil(context, (route) => route.isFirst);
                        pushReplacement(context: MyGlobalKeys.navigatorKey.currentContext!,screen:  SplashScreenPage(), );
                    }



                    }

                    // Navigator.pushNamed(context, Select_language.id);
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
