import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/register.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customtextfield.dart';

class LoginPage extends StatefulWidget {
  static const String id="login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    TextEditingController emailcontroller = TextEditingController();
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
      return MyColors.grey;
    }
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                vSizedBox8,
                Center(
                    child: Image.asset(MyImages.logo_hori, height: 46,)
                ),
                vSizedBox4,
                ParagraphText(text: 'Welcome back.',
                  fontSize: 24,
                  fontFamily: 'bold',
                ),
                ParagraphText(text: 'Sign in to continue!',
                  fontSize: 16,
                  fontFamily: 'regular',
                  color: MyColors.textcolor,
                ),
                vSizedBox4,
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  child: CustomTextField(
                    controller: emailcontroller,
                    hintText: 'Your User ID or Email Address',
                    left: 16,
                    fontsize: 12,
                    hintcolor: MyColors.inputbordercolor,

                  ),
                ),
                vSizedBox2,
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  child: CustomTextField(
                    controller: passwordcontroller,
                    hintText: 'Your password',
                    obscureText: true,
                    left: 16,
                    fontsize: 12,
                    hintcolor: MyColors.inputbordercolor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                              visualDensity: VisualDensity(horizontal: -4, vertical: 0),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                              child: Row(
                                children: [
                                  ParagraphText( text: "Remember Me",
                                    textAlign: TextAlign.right,
                                    color: MyColors.textcolor,
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: ParagraphText(
                          text: 'Trouble logging in ?',
                          textAlign: TextAlign.right,
                          color: MyColors.primaryColor,
                          fontSize: 12,
                        ),
                        onTap: (){

                        },
                      ),
                    ],
                  ),
                ),
                vSizedBox2,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundEdgedButton(
                      text: 'Login',
                      textColor: Colors.white,
                      color: MyColors.primaryColor,
                      borderRadius: 12,
                      width: MediaQuery.of(context).size.width - 32,
                      fontSize: 16,
                      verticalPadding: 20,
                      horizontalMargin: 16,
                      fontfamily: 'medium',
                    ),
                    vSizedBox2,
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ParagraphText(
                            text: 'New to 4-Share? ',
                            color: MyColors.textcolor,
                            fontSize: 12,
                            fontFamily: 'regular',
                          ),
                          ParagraphText(
                            text: 'Sign Up',
                            color: MyColors.primaryColor,
                            fontSize: 12,
                            underlined: true,
                            fontFamily: 'semibold',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: RoundEdgedButton(
                text: 'Go to website',
                textColor: Colors.white,
                color: MyColors.secondary,
                width: 135,
                fontSize: 10,
                fontfamily: 'medium',
                verticalPadding: 12,
                borderRadius: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
