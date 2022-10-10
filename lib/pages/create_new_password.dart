import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/register.dart';
import 'package:ox21/secure_account_step_one.dart';
import 'package:ox21/select_language.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/signin_mnemonic.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:uuid/uuid.dart';

import '../constants/getStrengthColor.dart';


class CreateNewPassword extends StatefulWidget {
  static const String id="forgot_password_page";
  final String passPhrase;
  const CreateNewPassword({Key? key, required this.passPhrase}) : super(key: key);

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool isChecked = false;
  bool passVisible = false;
  bool load = false;

  String strength = passwordStrength[0];
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
                  child: ParagraphText(text: 'Create a new Password',
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
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      child: CustomTextFieldlabel(
                        labeltext: 'New Password',
                        controller: passwordController,
                        obscureText: !passVisible,
                        hintText: '********',
                        left: 16,
                        fontsize: 12,
                        hintcolor: MyColors.inputbordercolor,
                        suffixIconButton: IconButton(
                          icon: Icon(passVisible?Icons.visibility:Icons.visibility_off_outlined,size: 26,),
                          onPressed: (){
                            setState(() {
                              passVisible = !passVisible;
                            });
                          },
                        ),
                        onChanged: (value){
                          if(value.length<8){
                            print(' ia her');
                            strength = passwordStrength[4];
                            setState(() {

                            });
                          }else{
                            print(value);
                            RegExp upperCaseRegex = RegExp("^(?=.*[A-Z])");
                            RegExp lowerCaseRegex = RegExp("^(?=.*[a-z])");
                            RegExp numberRegex = RegExp("^(?=.*[0-9])");
                            RegExp specialCharacterRegex = RegExp("^(?=.*?[#?!@\$%^&*-])");
                            print('_________');
                            print(upperCaseRegex.hasMatch(value));
                            print(lowerCaseRegex.hasMatch(value));
                            print(numberRegex.hasMatch(value));
                            print(specialCharacterRegex.hasMatch(value));

                            int tempStrength = -1;
                            if(upperCaseRegex.hasMatch(value))
                              tempStrength++;
                            if(lowerCaseRegex.hasMatch(value))tempStrength++;
                            if(numberRegex.hasMatch(value))tempStrength++;
                            if(specialCharacterRegex.hasMatch(value))tempStrength++;
                            if(tempStrength!=-1)
                              setState(() {
                                strength = passwordStrength[tempStrength];
                              });
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ParagraphText(
                            text: 'Password strength: ',
                            color: MyColors.textcolor,
                            fontSize: 12,
                            fontFamily: 'regular',
                          ),
                          Expanded(
                            child: ParagraphText(
                              text: strength,
                              color:getStrengthColor(strength),
                              fontSize: 12,
                              // underlined: true,
                              fontFamily: 'semibold',
                            ),
                          ),
                        ],
                      ),
                    ),
                    vSizedBox2,
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      child: CustomTextFieldlabel(
                        labeltext: 'Confirm password',
                        controller: confirmPasswordController,
                        hintText: '********',
                        obscureText: true,
                        left: 16,
                        fontsize: 12,
                        hintcolor: MyColors.inputbordercolor,
                        onChanged: (v){
                          setState(() {

                            print(passwordController.text==confirmPasswordController.text);
                          });
                        },
                        suffixIcon:passwordController.text==confirmPasswordController.text && (strength==passwordStrength[2] || strength==passwordStrength[3])? MyImages.check_green:null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ParagraphText(
                            text: 'Must be at least 8 characters',
                            color: MyColors.textcolor,
                            fontSize: 12,
                            fontFamily: 'regular',
                          ),
                        ],
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
                  text: 'Change Password',
                  textColor: Colors.white,
                  color:passwordController.text.isNotEmpty? MyColors.primaryColor: Colors.grey.shade300,
                  borderRadius: 12,
                  width: MediaQuery.of(context).size.width - 32,
                  fontSize: 16,
                  verticalPadding: 20,
                  horizontalMargin: 16,
                  fontfamily: 'medium',
                  onTap: ()async{
                    FocusScope.of(context).requestFocus(new FocusNode());
                    setState(() {
                      load = true;
                    });
                    if(passwordController.text==confirmPasswordController.text){
                        if (
                        // strength == passwordStrength[2] ||
                            strength == passwordStrength[3]) {
                          String passPhrase = '';
                          for(int i = 0;i<widget.passPhrase.length;i++) {
                            passPhrase = passPhrase + widget.passPhrase[i];
                            if(i!=widget.passPhrase.length-1){
                              passPhrase = passPhrase +" ";
                            }
                          }
                          print('the passphrase is $passPhrase');
                          String typedPhrase =
                          uuid.v5(Uuid.NAMESPACE_URL, passPhrase);
                          Crypt hashedPass = Crypt.sha256(
                              passwordController.text,
                              salt: MyGlobalConstants.passwordSalt);
                          print('hello $typedPhrase');
                          print(hashedPass.hash);
                          Map<String,dynamic> request = {
                            "password": hashedPass.hash,
                            "confirm_password": hashedPass.hash,
                            "uuid": widget.passPhrase,
                          };
                          var response = await Webservices.postData(context: context,url: ApiUrls.changePassword, request: request);
                          if(response['status']==1){
                            showSnackbar(context, response['message']);
                            await Navigator.pushReplacementNamed(context, SignInPage.id);
                          }else{
                            print('Error in status code');
                            print(response);
                          }
                        }else{
                          showSnackbar(context, 'Please type the strong password');
                        }
                    }
                    else{
                      showSnackbar(context, 'Confirm password does not match');
                    }
                    setState(() {
                      load = false;
                    });


                    // List words = passPhraseController.text.split(" ");

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
