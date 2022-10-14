// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ox21/congratulations.dart';
// import 'package:ox21/constants/colors.dart';
// import 'package:ox21/constants/image_urls.dart';
// import 'package:ox21/constants/sized_box.dart';
// import 'package:ox21/widgets/CustomTexts.dart';
// import 'package:ox21/widgets/buttons.dart';
// import 'package:ox21/widgets/customtextfield.dart';
//
// class RegisterPage extends StatefulWidget {
//   static const String id="register";
//   const RegisterPage({Key? key}) : super(key: key);
//
//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }
//
// class _RegisterPageState extends State<RegisterPage> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController emailcontroller = TextEditingController();
//     TextEditingController passwordcontroller = TextEditingController();
//     return Scaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 vSizedBox8,
//                 Center(
//                     child: Image.asset(MyImages.logo_hori, height: 46,)
//                 ),
//                 vSizedBox4,
//                 ParagraphText(text: 'Create an account',
//                   fontSize: 24,
//                   fontFamily: 'bold',
//                 ),
//                 ParagraphText(text: 'Sign up to get started!',
//                   fontSize: 16,
//                   fontFamily: 'regular',
//                   color: MyColors.textcolor,
//                 ),
//                 vSizedBox4,
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
//                   child: CustomTextField(
//                     controller: emailcontroller,
//                     hintText: 'Full Name',
//                     left: 16,
//                     fontsize: 12,
//                     hintcolor: MyColors.inputbordercolor,
//
//                   ),
//                 ),
//                 vSizedBox2,
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
//                   child: CustomTextField(
//                     controller: passwordcontroller,
//                     hintText: 'Email Address',
//                     left: 16,
//                     fontsize: 12,
//                     hintcolor: MyColors.inputbordercolor,
//                   ),
//                 ),
//                 vSizedBox2,
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
//                   child: CustomTextField(
//                     controller: emailcontroller,
//                     hintText: 'User ID',
//                     left: 16,
//                     fontsize: 12,
//                     hintcolor: MyColors.inputbordercolor,
//
//                   ),
//                 ),
//                 vSizedBox2,
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
//                   child: CustomTextField(
//                     controller: passwordcontroller,
//                     hintText: 'Password',
//                     obscureText: true,
//                     left: 16,
//                     fontsize: 12,
//                     hintcolor: MyColors.inputbordercolor,
//                   ),
//                 ),
//                 vSizedBox2,
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
//                   child: CustomTextField(
//                     controller: passwordcontroller,
//                     hintText: 'Confirm Password',
//                     obscureText: true,
//                     left: 16,
//                     fontsize: 12,
//                     hintcolor: MyColors.inputbordercolor,
//                   ),
//                 ),
//                 vSizedBox2,
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     RoundEdgedButton(
//                       text: 'Register',
//                       textColor: Colors.white,
//                       color: MyColors.primaryColor,
//                       borderRadius: 12,
//                       width: MediaQuery.of(context).size.width - 32,
//                       fontSize: 16,
//                       verticalPadding: 20,
//                       horizontalMargin: 16,
//                       fontfamily: 'semibold',
//                       onTap: (){
//                         Navigator.pushReplacementNamed(context, CongratulationsPage.id);
//                       },
//                     ),
//                     vSizedBox2,
//                     GestureDetector(
//                       onTap: (){
//                         // Navigator.pushNamed(context, LoginPage.id);
//                       },
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ParagraphText(
//                             text: 'By register, you agree to our',
//                             color: MyColors.textcolor,
//                             fontSize: 10,
//                             fontFamily: 'regular',
//                           ),
//                           ParagraphText(
//                             text: ' Terms, Data Policy',
//                             color: Color(0xFF0085FF),
//                             fontSize: 10,
//                             fontFamily: 'regular',
//                           ),
//                           ParagraphText(
//                             text: ' and',
//                             color: MyColors.primaryColor,
//                             fontSize: 10,
//                             fontFamily: 'regular',
//                           ),
//                           ParagraphText(
//                             text: ' Cookies Policy.',
//                             color: Color(0xFF0085FF),
//                             fontSize: 10,
//                             fontFamily: 'regular',
//                           ),
//                         ],
//                       ),
//                     ),
//                     vSizedBox2,
//                     GestureDetector(
//                       onTap: (){
//                         Navigator.pushNamed(context, RegisterPage.id);
//                       },
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ParagraphText(
//                             text: 'Already have an account?',
//                             color: MyColors.textcolor,
//                             fontSize: 12,
//                             fontFamily: 'regular',
//                           ),
//                           ParagraphText(
//                             text: ' Login',
//                             color: MyColors.primaryColor,
//                             fontSize: 12,
//                             underlined: true,
//                             fontFamily: 'semibold',
//                           ),
//                         ],
//                       ),
//                     ),
//                     vSizedBox4,
//                     RoundEdgedButton(
//                       text: 'Go to website',
//                       textColor: Colors.white,
//                       color: MyColors.secondary,
//                       width: 135,
//                       fontSize: 10,
//                       fontfamily: 'medium',
//                       verticalPadding: 12,
//                       borderRadius: 30,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
