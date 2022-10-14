// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ox21/constants/colors.dart';
// import 'package:ox21/constants/sized_box.dart';
// import 'package:ox21/upload_video_view.dart';
// import 'package:ox21/widgets/CustomTexts.dart';
// import 'package:ox21/widgets/appbar.dart';
// import 'package:ox21/widgets/buttons.dart';
//
// class Upload_Page extends StatefulWidget {
//   static const String id="upload_img";
//   const Upload_Page({Key? key}) : super(key: key);
//
//   @override
//   State<Upload_Page> createState() => _Upload_PageState();
// }
//
// class _Upload_PageState extends State<Upload_Page> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFeaedf6),
//       appBar: appBar(context: context,
//           title: 'Upload',
//           titleColor: MyColors.secondary,
//           implyLeading: false,
//           leading: IconButton(
//             onPressed: (){
//               Navigator.pop(context);
//             }, icon: Icon(
//             Icons.close_outlined, size: 20, color: MyColors.secondary,
//           ),
//           )
//
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ParagraphText(text: 'View and share your video here', fontSize: 16, ),
//             vSizedBox2,
//             RoundEdgedButton(text: 'Allow Access', textColor: Colors.white,
//             color: MyColors.secondary,
//               width: 120,
//               borderRadius: 30,
//               height: 50,
//               fontSize: 15,
//               fontfamily: 'regular',
//               onTap: (){
//               Navigator.pushNamed(context, UploadPageView.id);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
