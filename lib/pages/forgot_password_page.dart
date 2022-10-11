import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/pages/create_new_password.dart';
import 'package:ox21/register.dart';
import 'package:ox21/secure_account_step_one.dart';
import 'package:ox21/select_language.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_translate/flutter_translate.dart';


class ForgotPasswordPage extends StatefulWidget {
  static const String id="forgot_password_page";
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isChecked = false;
  bool passVisible = false;
  bool load = false;

  String strength = passwordStrength[0];
  TextEditingController passPhraseController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Uuid uuid = Uuid();
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
  @override
  Widget build(BuildContext context) {
    bool isSwitched = true;
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      appBar:load?null:  appBar(context: context,
          actions: [
            IconButton(onPressed: (){}, icon: Image.asset(MyImages.logowelcom, width: 35, height: 40, fit: BoxFit.fitHeight,))
          ]
      ),
      body:load?CustomLoader():  Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox4,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ParagraphText(text: translate("forgot.forgotPass"),
                    fontSize: 18,
                    fontFamily: 'bold',
                  ),
                ),
                vSizedBox,
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: ParagraphText(text: 'This password will unlock your OX21 account only on this service.',
                //     fontSize: 16,
                //     fontFamily: 'regular',
                //     color: MyColors.textcolor,
                //   ),
                // ),
                vSizedBox4,
                Stack(
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      child: CustomTextFieldlabel(
                        labeltext: translate("forgot.mnemonic"),
                        controller: passPhraseController,
                        hintText: 'Enter the 12 Words pass phrase',
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
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     ParagraphText(
                //       text: 'By proceeding, you agree to these ',
                //       color: MyColors.lighttext,
                //       fontSize: 12,
                //       fontFamily: 'regular',
                //     ),
                //     ParagraphText(
                //       text: 'Term and Conditions.',
                //       color: MyColors.primaryColor,
                //       fontSize: 12,
                //       fontFamily: 'regular',
                //     ),
                //   ],
                // ),
                // vSizedBox2,
                RoundEdgedButton(
                  text: translate("forgot.send"),
                  textColor: Colors.white,
                  color:passPhraseController.text.isNotEmpty? MyColors.primaryColor: Colors.grey.shade300,
                  borderRadius: 12,
                  width: MediaQuery.of(context).size.width - 32,
                  fontSize: 16,
                  verticalPadding: 20,
                  horizontalMargin: 16,
                  fontfamily: 'medium',
                  onTap: ()async{
                    FocusScope.of(context).requestFocus(new FocusNode());
                    List words = passPhraseController.text.split(" ");
                    if(words.length!=12){
                      showSnackbar(context, translate("forgot.alert1"));
                    }else{
                      setState(() {
                        load = true;
                      });
                      String typedPhrase =
                      uuid.v5(Uuid.NAMESPACE_URL, passPhraseController.text  );
                      bool result = await Webservices.forgotPassword(uuid: typedPhrase, context: context);
                      setState(() {
                        load = false;
                      });
                      if(result){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewPassword(passPhrase: typedPhrase,)));
                        // Navigator.pushNamed(context, Select_language.id);
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
