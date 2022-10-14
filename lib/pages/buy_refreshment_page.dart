// import 'package:flutter/material.dart';
// import 'package:ox21/constants/colors.dart';
// import 'package:ox21/constants/sized_box.dart';
// import 'package:ox21/widgets/CustomTexts.dart';
// import 'package:ox21/widgets/appbar.dart';
// import 'package:ox21/widgets/buttons.dart';
// import 'package:ox21/widgets/customtextfield.dart';
//
// class BuyRefreshmentPage extends StatefulWidget {
//   final int coins;
//   const BuyRefreshmentPage({Key? key, required this.coins}) : super(key: key);
//
//   @override
//   _BuyRefreshmentPageState createState() => _BuyRefreshmentPageState();
// }
//
// class _BuyRefreshmentPageState extends State<BuyRefreshmentPage> {
//   TextEditingController coinsController = TextEditingController();
//
//   String? errorTextCoinsController;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(context: context, title: 'Buy Refreshment'),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             vSizedBox4,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SubHeadingText(
//                   text: 'Enter Coins',
//                   color: MyColors.primaryColor,
//                 ),
//                 SubHeadingText(text: 'Coins in your wallet : ${widget.coins}'),
//               ],
//             ),
//             CustomTextField(
//               controller: coinsController,
//               hintText: 'Enter coins',
//               keyboardType: TextInputType.number,
//               errorText: errorTextCoinsController,
//               onChanged: (val) {
//                 print('the val is $val & ${widget.coins}');
//                 try {
//                   if (int.parse(val==''?'0':val) > widget.coins) {
//                     errorTextCoinsController = 'Insufficient coins';
//                   } else {
//                     errorTextCoinsController = null;
//                   }
//                 } catch (e) {
//                   print('Inside catch block 232 $e');
//
//                   //
//                 }
//                 setState(() {});
//               },
//             ),
//             vSizedBox,
//             Row(
//               children: [
//                 Expanded(
//                   child: RoundEdgedButton(
//                     text: '100',
//                     isSolid: coinsController.text == '100',
//                     onTap: (){
//                       FocusScope.of(context).requestFocus(new FocusNode());
//                       coinsController.text = '100';
//                       try {
//                         if (int.parse(coinsController.text) > widget.coins) {
//                           errorTextCoinsController = 'Insufficient coins';
//                         } else {
//                           errorTextCoinsController = null;
//                         }
//                       } catch (e) {
//                         print('Inside catch block 232 $e');
//                       }
//                       setState(() {
//
//                       });
//                     },
//                   ),
//                 ),
//                 hSizedBox,
//                 Expanded(
//                   child: RoundEdgedButton(
//                     text: '1000',
//                     isSolid: coinsController.text == '1000',
//                     onTap: (){
//                       FocusScope.of(context).requestFocus(new FocusNode());
//                       coinsController.text = '1000';
//                       try {
//                         if (int.parse(coinsController.text) > widget.coins) {
//                           errorTextCoinsController = 'Insufficient coins';
//                         } else {
//                           errorTextCoinsController = null;
//                         }
//                       } catch (e) {
//                         print('Inside catch block 232 $e');
//                       }
//                       setState(() {
//
//                       });
//                     },
//                   ),
//                 ),
//                 hSizedBox,
//                 Expanded(
//                   child: RoundEdgedButton(
//                     text: '10000',
//                     isSolid: coinsController.text == '10000',
//                     onTap: (){
//                       FocusScope.of(context).requestFocus(new FocusNode());
//                       coinsController.text = '10000';
//                       try {
//                         if (int.parse(coinsController.text) > widget.coins) {
//                           errorTextCoinsController = 'Insufficient coins';
//                         } else {
//                           errorTextCoinsController = null;
//                         }
//                       } catch (e) {
//                         print('Inside catch block 232 $e');
//                       }
//                       setState(() {
//
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             vSizedBox8,
//             RoundEdgedButton(text: 'Convert Coins to BTC', isSolid: false,),
//             vSizedBox,
//             RoundEdgedButton(text: 'Convert All Coins to BTC'),
//           ],
//         ),
//       ),
//     );
//   }
// }
