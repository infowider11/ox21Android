// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ox21/constants/sized_box.dart';
// import 'package:ox21/widgets/CustomTexts.dart';
// import 'package:ox21/widgets/appbar.dart';
// import 'package:ox21/widgets/avatar.dart';
// import 'package:ox21/widgets/buttons.dart';
// import 'package:ox21/widgets/customtextfield.dart';
//
// import 'constants/colors.dart';
// import 'constants/image_urls.dart';
//
// class ChatPage extends StatefulWidget {
//   static const String id="Chat";
//   const ChatPage({Key? key}) : super(key: key);
//
//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController emailcontroller = TextEditingController();
//     return Scaffold(
//       appBar: appBar(context: context, title: 'Messages', fontfamily: 'bold', titleColor: MyColors.primaryColor, ),
//       body: Container(
//         margin: EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
//               child: CustomTextFieldlabel(
//                 labeltext: 'Search',
//                 controller: emailcontroller,
//                 hintText: 'labeltext',
//                 left: 16,
//                 fontsize: 12,
//                 hintcolor: MyColors.inputbordercolor,
//                 suffixIcon: MyImages.voicesearch,
//                 bgColor: Color(0xFFF2F2F2),
//                 border: Border.all(color: MyColors.strokelabel),
//                 icon: Icons.search,
//                 borderRadius: 16,
//                 paddingsuffix: 14,
//               ),
//             ),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CircleAvatarcustom(image: MyImages.user_avatar, width: 50, height: 50, fit: BoxFit.fitWidth,),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 12,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ParagraphText(text: 'Ox21 General',
//                                   color: MyColors.heading, fontSize: 12, fontFamily: 'bold',),
//                                 ParagraphText(text: '18:31',
//                                   color: MyColors.heading, fontSize: 10, fontFamily: 'regular',),
//                               ],
//                             ),
//                             SizedBox(height: 5,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ParagraphText(text: 'You: The store only has (gasp!) 2% m...',
//                                   color: MyColors.textcolor, fontSize: 10, fontWeight: FontWeight.w300,),
//                                 Container(
//                                   height: 20,
//                                   width: 20,
//                                   decoration: BoxDecoration(
//                                     color: MyColors.secondary,
//                                     borderRadius: BorderRadius.circular(20)
//                                   ),
//                                   child:Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       ParagraphText(text: '5', color: Colors.white, fontSize: 10, fontFamily: 'bold',),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//                 Divider(
//                   height: 20, color: MyColors.introparacolor,
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CircleAvatarcustom(image: MyImages.user_avatar, width: 50, height: 50, fit: BoxFit.fitWidth,),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 12,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ParagraphText(text: 'Ox21 General',
//                                   color: MyColors.heading, fontSize: 12, fontFamily: 'bold',),
//                                 ParagraphText(text: '18:31',
//                                   color: MyColors.heading, fontSize: 10, fontFamily: 'regular',),
//                               ],
//                             ),
//                             SizedBox(height: 5,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ParagraphText(text: 'You: The store only has (gasp!) 2% m...',
//                                   color: MyColors.textcolor, fontSize: 10, fontWeight: FontWeight.w300,),
//                                 Container(
//                                   height: 20,
//                                   width: 20,
//                                   decoration: BoxDecoration(
//                                       color: MyColors.secondary,
//                                       borderRadius: BorderRadius.circular(20)
//                                   ),
//                                   child:Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       ParagraphText(text: '5', color: Colors.white, fontSize: 10, fontFamily: 'bold',),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//                 Divider(
//                   height: 20, color: MyColors.introparacolor,
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CircleAvatarcustom(image: MyImages.user_avatar, width: 50, height: 50, fit: BoxFit.fitWidth,),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 12,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ParagraphText(text: 'Ox21 General',
//                                   color: MyColors.heading, fontSize: 12, fontFamily: 'bold',),
//                                 ParagraphText(text: '18:31',
//                                   color: MyColors.heading, fontSize: 10, fontFamily: 'regular',),
//                               ],
//                             ),
//                             SizedBox(height: 5,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ParagraphText(text: 'You: The store only has (gasp!) 2% m...',
//                                   color: MyColors.textcolor, fontSize: 10, fontWeight: FontWeight.w300,),
//                                 Container(
//                                   height: 20,
//                                   width: 20,
//                                   decoration: BoxDecoration(
//                                       color: MyColors.secondary,
//                                       borderRadius: BorderRadius.circular(20)
//                                   ),
//                                   child:Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       ParagraphText(text: '5', color: Colors.white, fontSize: 10, fontFamily: 'bold',),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//                 Divider(
//                   height: 20, color: MyColors.introparacolor,
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CircleAvatarcustom(image: MyImages.user_avatar, width: 50, height: 50, fit: BoxFit.fitWidth,),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 12,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ParagraphText(text: 'Ox21 General',
//                                   color: MyColors.heading, fontSize: 12, fontFamily: 'bold',),
//                                 ParagraphText(text: '18:31',
//                                   color: MyColors.heading, fontSize: 10, fontFamily: 'regular',),
//                               ],
//                             ),
//                             SizedBox(height: 5,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ParagraphText(text: 'You: The store only has (gasp!) 2% m...',
//                                   color: MyColors.textcolor, fontSize: 10, fontWeight: FontWeight.w300,),
//                                 Container(
//                                   height: 20,
//                                   width: 20,
//                                   decoration: BoxDecoration(
//                                       color: MyColors.secondary,
//                                       borderRadius: BorderRadius.circular(20)
//                                   ),
//                                   child:Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       ParagraphText(text: '5', color: Colors.white, fontSize: 10, fontFamily: 'bold',),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//                 Divider(
//                   height: 20, color: MyColors.introparacolor,
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CircleAvatarcustom(image: MyImages.user_avatar, width: 50, height: 50, fit: BoxFit.fitWidth,),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 12,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ParagraphText(text: 'Ox21 General',
//                                   color: MyColors.heading, fontSize: 12, fontFamily: 'bold',),
//                                 ParagraphText(text: '18:31',
//                                   color: MyColors.heading, fontSize: 10, fontFamily: 'regular',),
//                               ],
//                             ),
//                             SizedBox(height: 5,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ParagraphText(text: 'You: The store only has (gasp!) 2% m...',
//                                   color: MyColors.textcolor, fontSize: 10, fontWeight: FontWeight.w300,),
//                                 Container(
//                                   height: 20,
//                                   width: 20,
//                                   decoration: BoxDecoration(
//                                       color: MyColors.secondary,
//                                       borderRadius: BorderRadius.circular(20)
//                                   ),
//                                   child:Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       ParagraphText(text: '5', color: Colors.white, fontSize: 10, fontFamily: 'bold',),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//                 Divider(
//                   height: 20, color: MyColors.introparacolor,
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CircleAvatarcustom(image: MyImages.user_avatar, width: 50, height: 50, fit: BoxFit.fitWidth,),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 12,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ParagraphText(text: 'Ox21 General',
//                                   color: MyColors.heading, fontSize: 12, fontFamily: 'bold',),
//                                 ParagraphText(text: '18:31',
//                                   color: MyColors.heading, fontSize: 10, fontFamily: 'regular',),
//                               ],
//                             ),
//                             SizedBox(height: 5,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ParagraphText(text: 'You: The store only has (gasp!) 2% m...',
//                                   color: MyColors.textcolor, fontSize: 10, fontWeight: FontWeight.w300,),
//                                 Container(
//                                   height: 20,
//                                   width: 20,
//                                   decoration: BoxDecoration(
//                                       color: MyColors.secondary,
//                                       borderRadius: BorderRadius.circular(20)
//                                   ),
//                                   child:Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       ParagraphText(text: '5', color: Colors.white, fontSize: 10, fontFamily: 'bold',),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//                 Divider(
//                   height: 20, color: MyColors.introparacolor,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
