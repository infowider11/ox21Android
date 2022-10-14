// import 'package:flutter/material.dart';
// import 'package:ox21/constants/colors.dart';
// import 'package:ox21/constants/image_urls.dart';
// import 'package:ox21/constants/sized_box.dart';
// import 'package:ox21/widgets/CustomTexts.dart';
// import 'package:ox21/widgets/appbar.dart';
// import 'package:ox21/widgets/buttons.dart';
// import 'package:ox21/widgets/customtextfield.dart';
//
// class ContentCreatorPostNowPage extends StatefulWidget {
//   static const String id = 'ContentCreatorPostNowPage';
//   const ContentCreatorPostNowPage({Key? key}) : super(key: key);
//
//   @override
//   _ContentCreatorPostNowPageState createState() =>
//       _ContentCreatorPostNowPageState();
// }
//
// class _ContentCreatorPostNowPageState extends State<ContentCreatorPostNowPage> {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController channelController = TextEditingController();
//   TextEditingController thoughtsController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(context: context, title: 'Content Creator'),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             vSizedBox2,
//             Row(
//               children: [
//                 Container(
//                   height: 60,
//                   width: 60,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(60),
//                       image: DecorationImage(
//                           image: AssetImage(
//                             MyImages.femaleAvatar,
//                           ),
//                           fit: BoxFit.cover)),
//                 ),
//                 hSizedBox,
//                 SubHeadingText(text: 'Domain Name', color: MyColors.primaryColor, fontSize: 16, fontFamily: 'semibold',),
//               ],
//             ),
//             vSizedBox,
//             CustomTextField(
//                 controller: titleController,
//                 hintText: 'What is the title of your topic?', fontsize: 12, hintcolor: Color(0xFF808B9F),),
//             vSizedBox,
//             CustomTextField(
//                 controller: channelController, hintText: 'Description',fontsize: 12, hintcolor: Color(0xFF808B9F),  ),
//             vSizedBox,
//             CustomTextField(
//               controller: thoughtsController,
//               hintText: 'Image screenshot - Linkback to the video.',
//               fontsize: 12,
//               hintcolor: Color(0xFF808b9f),
//
//               maxLines: 6,
//             ),
//             vSizedBox2,
//             Row(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: vSizedBox,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       RoundEdgedButton(
//                         textColor: Colors.white,
//                         text: 'Post Now',
//                         width: 80,
//                         height: 24,
//                         fontSize: 10,
//                         fontfamily: 'regular',
//                         color: MyColors.secondary,
//                         borderRadius: 4,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
