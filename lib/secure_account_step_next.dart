// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ox21/constants/colors.dart';
// import 'package:ox21/constants/image_urls.dart';
// import 'package:ox21/constants/sized_box.dart';
// import 'package:ox21/secure_account_step_two.dart';
// import 'package:ox21/widgets/CustomTexts.dart';
// import 'package:ox21/widgets/appbar.dart';
// import 'package:ox21/widgets/buttons.dart';
// import 'package:ox21/widgets/customtextfield.dart';
//
// class Step_nextPage extends StatefulWidget {
//   static const String id="stepnext";
//   const Step_nextPage({Key? key}) : super(key: key);
//
//   @override
//   State<Step_nextPage> createState() => _Step_nextPageState();
// }
//
// class _Step_nextPageState extends State<Step_nextPage> {
//   bool viewVisible = true ;
//   void hideWidget(){
//     setState(() {
//       viewVisible = false ;
//     });
//   }
//   List phrasevalues = [
//     "then",
//     "vacant",
//     "girl",
//     "exist",
//     "avoid",
//     "usage",
//     "ride",
//     "alien",
//     "comic",
//     "cross",
//     "upon",
//     "huba"
//   ];
//   int rows = 4;
//   int columns = 3;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyColors.backcolor,
//       appBar: appBar(context: context,
//           actions: [
//             IconButton(onPressed: () {},
//                 icon: Image.asset(MyImages.logowelcom, width: 35,
//                   height: 40,
//                   fit: BoxFit.fitHeight,))
//           ]
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 vSizedBox,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: ParagraphText(text: 'Back up Mnemonic phrase',
//                     fontSize: 18,
//                     fontFamily: 'bold',
//                   ),
//                 ),
//                 vSizedBox,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: ParagraphText(
//                     text: 'These 12 words are your mnemonic phrase. They are the key to your wallet. Write it down on a paper and keep it in a safe place. You\'ll be asked to re-enter this phrase (in order) on the next step.',
//                     fontSize: 16,
//                     fontFamily: 'regular',
//                     color: MyColors.textcolor,
//                   ),
//                 ),
//                 vSizedBox,
//                 Stack(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             color: Color(0xFFF4F4F6)
//                         ),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Column(
//                         children:
//                         // generateGrid(),
//
//                         [
//
//
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                   flex:2,
//                                   child: Column(
//                                     children: [
//                                       RoundEdgedButton(
//                                         text: '1.then',
//                                         textColor: Color(0xFF000000),
//                                         fontSize: 16,
//                                         fontfamily: 'regular',
//                                         verticalPadding: 12,
//                                         height: 40,
//                                         borderRadius: 8,
//                                         horizontalMargin: 2.5,
//                                         // isSolid:false
//                                       ),
//                                     ],
//                                   )
//                               ),
//                               vSizedBox,
//                               Expanded(
//                                   flex:2,
//                                   child: Column(
//                                     children: [
//                                       RoundEdgedButton(
//                                         text: '2. vacant',
//                                         textColor: Color(0xFF090A0B),
//                                         fontSize: 14,
//                                         fontfamily: 'regular',
//                                         verticalPadding: 12,
//                                         height: 40,
//                                         borderRadius: 8,
//                                         horizontalMargin: 2.5,
//                                       ),
//                                     ],
//                                   )
//                               ),
//                               vSizedBox,
//                               Expanded(
//                                   flex:2,
//                                   child: Column(
//                                     children: [
//                                       RoundEdgedButton(
//                                         text: '3. girl',
//                                         textColor: Color(0xFF090A0B),
//                                         fontSize: 16,
//                                         fontfamily: 'regular',
//                                         verticalPadding: 12,
//                                         height: 40,
//                                         borderRadius: 8,
//                                         horizontalMargin: 2.5,
//                                       ),
//                                     ],
//                                   )
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 16,),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                   flex:2,
//                                   child: Column(
//                                     children: [
//                                       RoundEdgedButton(
//                                         text: '4. exist',
//                                         textColor: Color(0xFF090A0B),
//                                         fontSize: 16,
//                                         fontfamily: 'regular',
//                                         verticalPadding: 12,
//                                         height: 40,
//                                         borderRadius: 8,
//                                         horizontalMargin: 2.5,
//                                       ),
//                                     ],
//                                   )
//                               ),
//                               vSizedBox,
//                               Expanded(
//                                   flex:2,
//                                   child: Column(
//                                     children: [
//                                       RoundEdgedButton(
//                                         text: '5. avoid',
//                                         textColor: Color(0xFF090A0B),
//                                         fontSize: 16,
//                                         fontfamily: 'regular',
//                                         verticalPadding: 12,
//                                         height: 40,
//                                         borderRadius: 8,
//                                         horizontalMargin: 2.5,
//                                       ),
//                                     ],
//                                   )
//                               ),
//                               vSizedBox,
//                               Expanded(
//                                   flex:2,
//                                   child: Column(
//                                     children: [
//                                       RoundEdgedButton(
//                                         text: '6. usage',
//                                         textColor: Color(0xFF090A0B),
//                                         fontSize: 16,
//                                         fontfamily: 'regular',
//                                         verticalPadding: 12,
//                                         height: 40,
//                                         borderRadius: 8,
//                                         horizontalMargin: 2.5,
//                                       ),
//                                     ],
//                                   )
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 16,),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                   flex:2,
//                                   child: Column(
//                                     children: [
//                                       RoundEdgedButton(
//                                         text: '7. ride',
//                                         textColor: Color(0xFF090A0B),
//                                         fontSize: 16,
//                                         fontfamily: 'regular',
//                                         verticalPadding: 12,
//                                         height: 40,
//                                         borderRadius: 8,
//                                         horizontalMargin: 2.5,
//                                       ),
//                                     ],
//                                   )
//                               ),
//                               vSizedBox,
//                               Expanded(
//                                   flex:2,
//                                   child: Column(
//                                     children: [
//                                       RoundEdgedButton(
//                                         text: '8. alien',
//                                         textColor: Color(0xFF090A0B),
//                                         fontSize: 16,
//                                         fontfamily: 'regular',
//                                         verticalPadding: 12,
//                                         height: 40,
//                                         borderRadius: 8,
//                                         horizontalMargin: 2.5,
//                                       ),
//                                     ],
//                                   )
//                               ),
//                               vSizedBox,
//                               Expanded(
//                                   flex:2,
//                                   child: Column(
//                                     children: [
//                                       RoundEdgedButton(
//                                         text: '9. comic',
//                                         textColor: Color(0xFF090A0B),
//                                         fontSize: 16,
//                                         fontfamily: 'regular',
//                                         verticalPadding: 12,
//                                         height: 40,
//                                         borderRadius: 8,
//                                         horizontalMargin: 2.5,
//                                       ),
//                                     ],
//                                   )
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 16,),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                   flex:2,
//                                   child: Column(
//                                     children: [
//                                       RoundEdgedButton(
//                                         text: '10. cross',
//                                         textColor: Color(0xFF090A0B),
//                                         fontSize: 16,
//                                         fontfamily: 'regular',
//                                         verticalPadding: 12,
//                                         height: 40,
//                                         borderRadius: 8,
//                                         horizontalMargin: 2.5,
//                                       ),
//                                     ],
//                                   )
//                               ),
//                               vSizedBox,
//                               Expanded(
//                                   flex:2,
//                                   child: Column(
//                                     children: [
//                                       RoundEdgedButton(
//                                         text: '11. upon',
//                                         textColor: Color(0xFF090A0B),
//                                         fontSize: 16,
//                                         fontfamily: 'regular',
//                                         verticalPadding: 12,
//                                         height: 40,
//                                         borderRadius: 8,
//                                         horizontalMargin: 2.5,
//                                       ),
//                                     ],
//                                   )
//                               ),
//                               vSizedBox,
//                               Expanded(
//                                   flex:2,
//                                   child: Column(
//                                     children: [
//                                       RoundEdgedButton(
//                                         text: '12. huba',
//                                         textColor: Color(0xFF090A0B),
//                                         fontSize: 16,
//                                         fontfamily: 'regular',
//                                         verticalPadding: 12,
//                                         height: 40,
//                                         borderRadius: 8,
//                                         horizontalMargin: 2.5,
//                                       ),
//                                     ],
//                                   )
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child:  RoundEdgedButton(
//               text: 'Continue',
//               textColor: Colors.white,
//               color: MyColors.primaryColor,
//               borderRadius: 12,
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width - 32,
//               fontSize: 16,
//               verticalPadding: 20,
//               horizontalMargin: 16,
//               fontfamily: 'medium',
//               onTap: () {
//                 Navigator.pushNamed(context, Step_two.id);
//               },
//
//             ),
//           ),
//
//
//         ],
//       ),
//     );
//   }
//
//   List<Widget> generateGrid() {
//     List<Widget> wdg = [];
//     for (var i = 1; i <= rows; i++) {
//       Widget m = Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//                 flex: 2,
//                 child: Column(
//                     children: generateBlocks(i)))
//           ]);
//       wdg.add(m);
//       wdg.add(vSizedBox);
//     };
//
//     return wdg;
//   }
//
//
//   List<Widget> generateBlocks(i) {
//     List<Widget> wdg = [];
//     for(var j = 1; j <= columns; j++){
//       Widget m = PhraseInput(
//         text: '${i + j - 1}. ${(i - 1) * j +
//             j }',
//         textColor: Color(0xFF000000),
//         fontSize: 16,
//         fontfamily: 'regular',
//         verticalPadding: 12,
//       );
//       wdg.add(m);
//       wdg.add(vSizedBox);
//     }
//
//     return wdg;
//   }
// }
