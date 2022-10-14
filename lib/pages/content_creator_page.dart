// import 'package:flutter/material.dart';
// import 'package:masonry_grid/masonry_grid.dart';
// import 'package:ox21/constants/colors.dart';
// import 'package:ox21/constants/image_urls.dart';
// import 'package:ox21/constants/sized_box.dart';
// import 'package:ox21/pages/content_creator_post_now_page.dart';
// import 'package:ox21/widgets/CustomTexts.dart';
// import 'package:ox21/widgets/appbar.dart';
// import 'package:ox21/widgets/buttons.dart';
// import 'package:ox21/widgets/customtextfield.dart';
//
// class ContentCreatorPage extends StatefulWidget {
//   static const String id = 'content_creator_page';
//   const ContentCreatorPage({Key? key}) : super(key: key);
//
//   @override
//   _ContentCreatorPageState createState() => _ContentCreatorPageState();
// }
//
// class _ContentCreatorPageState extends State<ContentCreatorPage> {
//   TextEditingController captionController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(
//         context: context,
//         title: 'Content Creator',
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             vSizedBox2,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(60),
//                           image: DecorationImage(
//                               image: AssetImage(
//                                 MyImages.femaleAvatar,
//                               ),
//                               fit: BoxFit.cover)),
//                     ),
//                     hSizedBox,
//                     SubHeadingText(text: 'Domain Name'),
//                   ],
//                 ),
//                 GestureDetector(
//                   onTap: (){
//                     Navigator.pushNamed(context, ContentCreatorPostNowPage.id);
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//                     decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(4)),
//                     child: Row(
//                       children: [
//                         Image.asset(
//                           MyImages.addIcon,
//                           height: 16,
//                           fit: BoxFit.fitHeight,
//                         ),
//                         hSizedBox05,
//                         ParagraphText(text: 'Post a topic')
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             CustomTextField(
//               controller: captionController,
//               hintText: 'Add a Caption...',
//               border: Border.all(color: Colors.transparent),
//               maxLines: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Color(0xFF808B9F)),
//                           borderRadius: BorderRadius.circular(6)),
//                       child: Row(
//                         children: [
//                           Image.asset(
//                             MyImages.addImageIcon,
//                             height: 16,
//                             fit: BoxFit.fitHeight,
//                           ),
//                           hSizedBox05,
//                           ParagraphText(text: 'Add an Image', fontSize: 8,color: Color(0xFF808B9F))
//                         ],
//                       ),
//                     ),
//                     hSizedBox,
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Color(0xFF808B9F)),
//                           borderRadius: BorderRadius.circular(6)),
//                       child: Row(
//                         children: [
//                           // Image.asset(MyImages.addImageIcon, height: 16, fit:  BoxFit.fitHeight,),
//                           // hSizedBox05,
//                           ParagraphText(text: 'Add # Tags', fontSize: 8, color: Color(0xFF808B9F),)
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 hSizedBox4,
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       RoundEdgedButton(
//                         text: 'Post Now',
//                         textColor: Colors.white,
//                         color: MyColors.secondary,
//                         fontSize: 10,
//                         height: 24,
//                         width: 80,
//                         fontfamily: 'regular',
//                         borderRadius: 4,
//                         onTap: ()=> Navigator.pushNamed(context, ContentCreatorPostNowPage.id),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             vSizedBox2,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SubHeadingText(text: 'Recent Images'),
//                 Container(
//                   width: 80,
//                   height: 24,
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Color(0xFF808B9F)),
//                       borderRadius: BorderRadius.circular(6)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Image.asset(MyImages.addImageIcon, height: 16, fit:  BoxFit.fitHeight,),
//                       // hSizedBox05,
//                       ParagraphText(text: 'Gallery', fontSize: 8, color: Color(0xFF808B9F),),
//                       Icon(Icons.keyboard_arrow_down_rounded, size: 10,)
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             CustomDivider(),
//             vSizedBox2,
//             Expanded(
//               child: CustomScrollView(
//                 slivers: [
//                   SliverToBoxAdapter(
//                     child: MasonryGrid(
//                         crossAxisSpacing: 8,
//                         mainAxisSpacing: 8,
//                         column: 2,
//                         children: [
//                           // for(int i = 0;i<10;i++)
//                           Image.asset(
//                             MyImages.galleryImage1,
//                             width: MediaQuery.of(context).size.width,
//                             fit: BoxFit.fitWidth,
//                           ),
//                           Image.asset(
//                             MyImages.galleryImage3,
//                             width: MediaQuery.of(context).size.width,
//                             fit: BoxFit.fitWidth,
//                           ),
//                           Image.asset(
//                             MyImages.galleryImage2,
//                             width: MediaQuery.of(context).size.width,
//                             fit: BoxFit.fitWidth,
//                           ),
//                           Image.asset(
//                             MyImages.galleryImage4,
//                             width: MediaQuery.of(context).size.width,
//                             fit: BoxFit.fitWidth,
//                           ),
//                           Image.asset(
//                             MyImages.galleryImage2,
//                             width: MediaQuery.of(context).size.width,
//                             fit: BoxFit.fitWidth,
//                           ),
//                           Image.asset(
//                             MyImages.user_avatar,
//                             width: MediaQuery.of(context).size.width,
//                             fit: BoxFit.fitWidth,
//                           ),
//                           Image.asset(
//                             MyImages.galleryImage1,
//                             width: MediaQuery.of(context).size.width,
//                             fit: BoxFit.fitWidth,
//                           ),
//                           Image.asset(
//                             MyImages.galleryImage4,
//                             width: MediaQuery.of(context).size.width,
//                             fit: BoxFit.fitWidth,
//                           ),
//                           Image.asset(
//                             MyImages.galleryImage3,
//                             width: MediaQuery.of(context).size.width,
//                             fit: BoxFit.fitWidth,
//                           ),
//                         ]),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
