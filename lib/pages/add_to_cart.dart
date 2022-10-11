// import 'package:flutter/material.dart';
// import 'package:ox21/cart.dart';
// import 'package:ox21/constants/colors.dart';
// import 'package:ox21/constants/image_urls.dart';
// import 'package:ox21/constants/sized_box.dart';
// import 'package:ox21/widgets/CustomTexts.dart';
// import 'package:ox21/widgets/appbar.dart';
// import 'package:ox21/widgets/buttons.dart';
// import 'package:ox21/widgets/customtextfield.dart';
// class Addtocart extends StatefulWidget {
//   static const String id = 'addtocart';
//   const Addtocart({Key? key}) : super(key: key);
//
//   @override
//   _AddtocartState createState() => _AddtocartState();
// }
//
// class _AddtocartState extends State<Addtocart> {
//   TextEditingController searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(context: context, title: 'Domain'),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//               child: CustomTextFieldlabel(
//                 labeltext: 'Search Domain',
//                 controller: searchController,
//                 hintText: 'Search Domain',
//                 left: 16,
//                 fontsize: 12,
//                 hintcolor: MyColors.inputbordercolor,
//                 // suffixIcon: MyImages.voicesearch,
//                 bgColor: Color(0xFFF2F2F2),
//                 border: Border.all(color: MyColors.strokelabel),
//                 icon: Icons.search,
//                 borderRadius: 16,
//                 paddingsuffix: 14,
//               ),
//             ),
//             vSizedBox2,
//             Container(
//               width: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(16)),
//               child: Column(
//                 children: [
//                   SubHeadingText(text: 'Domain Name: abc',),
//                   vSizedBox,
//                   Image.asset(MyImages.tickIcon, height: 60, fit: BoxFit.fitHeight,),
//                   vSizedBox,
//                   ParagraphText(text: 'Name Available to Purchase'),
//                   vSizedBox2,
//                   RoundEdgedButton(
//                     text: 'Add to Cart',
//                     textColor: Colors.white,
//                     color: MyColors.secondary,
//                     fontfamily: 'medium',
//                     onTap: (){
//                       Navigator.pushNamed(context, Cart.id);
//                     },
//                   ),
//                   vSizedBox2,
//                   RoundEdgedButton(
//                     text: 'Rent',
//                     isSolid: false,
//                     textColor: Colors.white,
//                     color: MyColors.secondary,
//                     fontfamily: 'medium',
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
