// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ox21/chat.dart';
// import 'package:ox21/constants/global_functions.dart';
// import 'package:ox21/mycoins.dart';
// import 'package:ox21/pages/content_creator_page.dart';
// import 'package:ox21/pages/upload_page.dart';
// import 'package:ox21/search.dart';
// import 'package:ox21/upload_video_view.dart';
// import 'package:ox21/widgets/CustomTexts.dart';
// import 'package:ox21/widgets/avatar.dart';
// import 'package:ox21/widgets/buttons.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
//
// import 'constants/colors.dart';
// import 'constants/image_urls.dart';
// import 'constants/sized_box.dart';
//
// class Home_Page extends StatefulWidget {
//   static const String id = "home";
//   const Home_Page({Key? key}) : super(key: key);
//
//   @override
//   State<Home_Page> createState() => _Home_PageState();
// }
//
// class _Home_PageState extends State<Home_Page> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       extendBodyBehindAppBar: true,
//       backgroundColor: Color(0xFF88E1E5),
//       floatingActionButton: FloatingActionButton(
//         // onPressed: () {
//         //   // Add your onPressed code here!
//         //   Navigator.pushNamed(context, ContentCreatorPage.id);
//         // },
//         onPressed: () {
//           showModalBottomSheet<void>(
//             context: context,
//             backgroundColor: Colors.transparent,
//             builder: (BuildContext context) {
//               return Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(24),
//                     topRight: Radius.circular(24),
//                   ),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     vSizedBox,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ParagraphText(
//                           text: 'Create',
//                           color: MyColors.secondary,
//                           fontSize: 16,
//                           fontFamily: 'semibold',
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Icon(
//                             Icons.close_outlined,
//                             size: 20,
//                             color: MyColors.secondary,
//                           ),
//                         ),
//                       ],
//                     ),
//                     vSizedBox2,
//                     GestureDetector(
//                       behavior: HitTestBehavior.translucent,
//                       // onTap: () {
//                       //   Navigator.pop(context);
//                       //   Navigator.pushNamed(context, Upload_Page.id);
//                       // },
//                       onTap: () async {
//                         print('button poresssed');
//                         File? video = await pickVideo(isGallery: false);
//                         if(video!=null){
//                             // Navigator.pop(context);
//                             Uint8List? uint8list = await VideoThumbnail.thumbnailData(
//                               video: video.path,
//                               imageFormat: ImageFormat.JPEG,
//                               maxWidth: 400, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//                               maxHeight: 400,
//                               quality: 50,
//                             );
//                             print(uint8list);
//                             if(uint8list!=null){
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadPageView(video: video,image: uint8list, videoType: 'shorts',)));
//                             }
//                             // Navigator.pushNamed(context, Upload_Page.id);
//                             // Navigator.pushNamed(context, UploadPageView.id);
//
//                         }
//                       },
//                       child: Row(
//                         children: [
//                           Expanded(
//                             flex: 3,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CircleAvatarcustom(
//                                   image: MyImages.short,
//                                   width: 50,
//                                   height: 50,
//                                   fit: BoxFit.fitWidth,
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           Expanded(
//                             flex: 12,
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 2, horizontal: 0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       ParagraphText(
//                                         text: 'Create a Short',
//                                         color: MyColors.heading,
//                                         fontSize: 12,
//                                         fontFamily: 'bold',
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     vSizedBox2,
//                     GestureDetector(
//                       behavior: HitTestBehavior.translucent,
//                       onTap: () async {
//                         print('button poresssed');
//                         File? video = await pickVideo(isGallery: true);
//                         if(video!=null){
//                           // Navigator.pop(context);
//                           Uint8List? uint8list = await VideoThumbnail.thumbnailData(
//                             video: video.path,
//                             imageFormat: ImageFormat.JPEG,
//                             maxWidth: 400, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//                             maxHeight: 400,
//                             quality: 50,
//                           );
//                           print(uint8list);
//                           if(uint8list!=null){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadPageView(video: video,image: uint8list, videoType: 'videos',)));
//                           }
//                           // Navigator.pushNamed(context, Upload_Page.id);
//                           // Navigator.pushNamed(context, UploadPageView.id);
//
//                         }
//                       },
//                       child: Row(
//                         children: [
//                           Expanded(
//                             flex: 3,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CircleAvatarcustom(
//                                   image: MyImages.upload_video,
//                                   width: 50,
//                                   height: 50,
//                                   fit: BoxFit.fitWidth,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             flex: 12,
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 2, horizontal: 0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       ParagraphText(
//                                         text: 'Upload a Video',
//                                         color: MyColors.heading,
//                                         fontSize: 12,
//                                         fontFamily: 'bold',
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // vSizedBox2,
//                     // Row(
//                     //   children: [
//                     //     Expanded(
//                     //       flex: 3,
//                     //       child: Column(
//                     //         crossAxisAlignment: CrossAxisAlignment.start,
//                     //         children: [
//                     //           CircleAvatarcustom(
//                     //             image: MyImages.short,
//                     //             width: 50,
//                     //             height: 50,
//                     //             fit: BoxFit.fitWidth,
//                     //           ),
//                     //         ],
//                     //       ),
//                     //     ),
//                     //     Expanded(
//                     //       flex: 12,
//                     //       child: Container(
//                     //         padding: EdgeInsets.symmetric(
//                     //             vertical: 2, horizontal: 0),
//                     //         child: Column(
//                     //           crossAxisAlignment: CrossAxisAlignment.start,
//                     //           children: [
//                     //             Row(
//                     //               mainAxisAlignment:
//                     //                   MainAxisAlignment.spaceBetween,
//                     //               children: [
//                     //                 ParagraphText(
//                     //                   text: 'Go Live',
//                     //                   color: MyColors.heading,
//                     //                   fontSize: 12,
//                     //                   fontFamily: 'bold',
//                     //                 ),
//                     //               ],
//                     //             ),
//                     //           ],
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//         backgroundColor: MyColors.secondary,
//         child: const Icon(Icons.add),
//       ),
//       appBar: AppBar(
//         elevation: 0,
//         leading: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, MyCoinsPage.id);
//                   },
//                   child: Image.asset(
//                     MyImages.user,
//                     width: 24,
//                     height: 24,
//                   )),
//             ],
//           ),
//         ),
//         centerTitle: true,
//         title: Image.asset(
//           MyImages.logo_white,
//           width: 104,
//         ),
//         actions: [
//           GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, SearchPage.id);
//               },
//               child: Image.asset(
//                 MyImages.search_circle,
//                 width: 24,
//               )),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: GestureDetector(
//                 onTap: () {
//                   Navigator.pushNamed(context, ChatPage.id);
//                 },
//                 child: Image.asset(
//                   MyImages.message,
//                   width: 24,
//                 )),
//           )
//         ],
//         backgroundColor: Colors.transparent,
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Container(
//               // height: MediaQuery.of(context).size.height - 100,
//               margin: EdgeInsets.only(top: 100),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(24),
//                   topRight: Radius.circular(24),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   vSizedBox,
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     child: Stack(
//                       clipBehavior: Clip.none,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: Image.asset(
//                             MyImages.home1,
//                             width: MediaQuery.of(context).size.width,
//                             height: 200,
//                             fit: BoxFit.fitHeight,
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           top: 20,
//                           left: 0,
//                           child: ClipRRect(
//                             child: Container(
//                               height: 200,
//                               width: MediaQuery.of(context).size.width - 32,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topCenter,
//                                     end: Alignment.bottomCenter,
//                                     stops: [
//                                       0.1,
//                                       1,
//                                     ],
//                                     colors: [
//                                       Colors.white10,
//                                       Colors.black87,
//                                     ],
//                                   )),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 40,
//                           left: 16,
//                           child: MainHeadingText(
//                             text: 'Lorem Ipsum Headline',
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontFamily: 'bold',
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 15,
//                           left: 16,
//                           child: ParagraphText(
//                             text:
//                                 'Lorem Ipsum Paragraph Text goes here. It can\nextend upto 2 lines',
//                             color: MyColors.whiteColor,
//                             fontSize: 10,
//                           ),
//                         ),
//                         Positioned(
//                             bottom: 25,
//                             right: 16,
//                             child: Column(
//                               children: [
//                                 GestureDetector(
//                                     child: Image.asset(
//                                       MyImages.message_icon,
//                                       width: 15,
//                                     ),
//                                     onTap: () {
//                                       // showDialog<void>(context: context, builder: (context) => dialog1);
//                                     }),
//                                 vSizedBox,
//                                 GestureDetector(
//                                     child: Image.asset(
//                                       MyImages.heart,
//                                       width: 15,
//                                     ),
//                                     onTap: () {
//                                       // showDialog<void>(context: context, builder: (context) => dialog1);
//                                     }),
//                                 vSizedBox,
//                                 GestureDetector(
//                                     child: Image.asset(
//                                       MyImages.dislike,
//                                       width: 15,
//                                     ),
//                                     onTap: () {
//                                       // showDialog<void>(context: context, builder: (context) => dialog1);
//                                     }),
//                               ],
//                             )),
//                       ],
//                     ),
//                   ),
//                   Divider(
//                     indent: 40,
//                     endIndent: 40,
//                     height: 15,
//                     color: MyColors.lightblue,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Stack(
//                       children: [
//                         Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 2,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       CircleAvatarcustom(
//                                         image: MyImages.user_avatar,
//                                         width: 50,
//                                         height: 50,
//                                         fit: BoxFit.fitWidth,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 8,
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                         vertical: 2, horizontal: 10),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         ParagraphText(
//                                           text: 'Ashlyn BO shared in #beach',
//                                           color: MyColors.heading,
//                                           fontSize: 12,
//                                           fontFamily: 'bold',
//                                         ),
//                                         ParagraphText(
//                                           text: '30 Sep at 2:30 am',
//                                           color: MyColors.textcolor,
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w300,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 3,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Icon(
//                                         Icons.more_vert_outlined,
//                                         color: Colors.black,
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                             vSizedBox,
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Container(
//                                 decoration:
//                                     BoxDecoration(color: Color(0xFFFBFBFB)),
//                                 child: Column(
//                                   children: [
//                                     Image.asset(MyImages.unsplash),
//                                     Row(
//                                       children: [
//                                         Flexible(
//                                           flex: 3,
//                                           child: Container(
//                                             padding: EdgeInsets.only(
//                                                 top: 10, bottom: 0, left: 10),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 ParagraphText(
//                                                   text:
//                                                       'A fun day at Beach,...',
//                                                   color: MyColors.blackColor,
//                                                   fontSize: 12,
//                                                   fontFamily: 'semibold',
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Image.asset(
//                                                       MyImages.attach,
//                                                       width: 15,
//                                                     ),
//                                                     hSizedBox,
//                                                     ParagraphText(
//                                                       text: 'be.acx',
//                                                       color: Colors.grey,
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w300,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Flexible(
//                                           flex: 4,
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.end,
//                                             children: [
//                                               GestureDetector(
//                                                 onTap: () {},
//                                                 child: Container(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 16),
//                                                   height: 26,
//                                                   width: 80,
//                                                   decoration: BoxDecoration(
//                                                       color: MyColors.lightblue,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               4)),
//                                                   child: Row(
//                                                     // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                     children: [
//                                                       Image.asset(
//                                                         MyImages.heartfill,
//                                                         width: 16,
//                                                         fit: BoxFit.fitWidth,
//                                                       ),
//                                                       hSizedBox,
//                                                       ParagraphText(
//                                                         text: 'Like',
//                                                         color: MyColors
//                                                             .primaryColor,
//                                                         fontSize: 12,
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               hSizedBox,
//                                               GestureDetector(
//                                                 onTap: () {},
//                                                 child: Container(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 8),
//                                                   height: 26,
//                                                   width: 80,
//                                                   decoration: BoxDecoration(
//                                                       color: MyColors.lightblue,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               4)),
//                                                   child: Row(
//                                                     // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                     children: [
//                                                       Image.asset(
//                                                         MyImages.dislikefill,
//                                                         width: 11,
//                                                         fit: BoxFit.fitWidth,
//                                                       ),
//                                                       hSizedBox,
//                                                       ParagraphText(
//                                                         text: 'Dislike',
//                                                         color: MyColors
//                                                             .primaryColor,
//                                                         fontSize: 12,
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Positioned(
//                             top: 60,
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 5, horizontal: 16),
//                               decoration: BoxDecoration(
//                                 color: MyColors.lightblue,
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(12),
//                                   bottomRight: Radius.circular(12),
//                                 ),
//                               ),
//                               child: ParagraphText(
//                                 text: 'freshed with ox21 coin',
//                                 color: MyColors.primaryColor,
//                                 fontFamily: 'semibold',
//                                 fontSize: 9,
//                               ),
//                             )),
//                         Positioned(
//                             top: 65,
//                             right: 10,
//                             child: Image.asset(
//                               MyImages.starfill,
//                               width: 20,
//                             ))
//                       ],
//                     ),
//                   ),
//                   vSizedBox2,
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Stack(
//                       children: [
//                         Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 2,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       CircleAvatarcustom(
//                                         image: MyImages.user_avatar,
//                                         width: 50,
//                                         height: 50,
//                                         fit: BoxFit.fitWidth,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 8,
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                         vertical: 2, horizontal: 10),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         ParagraphText(
//                                           text: 'Ashlyn BO shared in #beach',
//                                           color: MyColors.heading,
//                                           fontSize: 12,
//                                           fontFamily: 'bold',
//                                         ),
//                                         ParagraphText(
//                                           text: '30 Sep at 2:30 am',
//                                           color: MyColors.textcolor,
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w300,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 3,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Icon(
//                                         Icons.more_vert_outlined,
//                                         color: Colors.black,
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                             vSizedBox,
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Container(
//                                 decoration:
//                                     BoxDecoration(color: Color(0xFFFBFBFB)),
//                                 child: Column(
//                                   children: [
//                                     Image.asset(MyImages.unsplash),
//                                     Row(
//                                       children: [
//                                         Flexible(
//                                           flex: 3,
//                                           child: Container(
//                                             padding: EdgeInsets.only(
//                                                 top: 10, bottom: 0, left: 10),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 ParagraphText(
//                                                   text:
//                                                       'A fun day at Beach,...',
//                                                   color: MyColors.blackColor,
//                                                   fontSize: 12,
//                                                   fontFamily: 'semibold',
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Image.asset(
//                                                       MyImages.attach,
//                                                       width: 15,
//                                                     ),
//                                                     hSizedBox,
//                                                     ParagraphText(
//                                                       text: 'be.acx',
//                                                       color: Colors.grey,
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w300,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Flexible(
//                                           flex: 4,
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.end,
//                                             children: [
//                                               GestureDetector(
//                                                 onTap: () {},
//                                                 child: Container(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 16),
//                                                   height: 26,
//                                                   width: 80,
//                                                   decoration: BoxDecoration(
//                                                       color: MyColors.lightblue,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               4)),
//                                                   child: Row(
//                                                     // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                     children: [
//                                                       Image.asset(
//                                                         MyImages.heartfill,
//                                                         width: 16,
//                                                         fit: BoxFit.fitWidth,
//                                                       ),
//                                                       hSizedBox,
//                                                       ParagraphText(
//                                                         text: 'Like',
//                                                         color: MyColors
//                                                             .primaryColor,
//                                                         fontSize: 12,
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               hSizedBox,
//                                               GestureDetector(
//                                                 onTap: () {},
//                                                 child: Container(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 8),
//                                                   height: 26,
//                                                   width: 80,
//                                                   decoration: BoxDecoration(
//                                                       color: MyColors.lightblue,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               4)),
//                                                   child: Row(
//                                                     // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                     children: [
//                                                       Image.asset(
//                                                         MyImages.dislikefill,
//                                                         width: 11,
//                                                         fit: BoxFit.fitWidth,
//                                                       ),
//                                                       hSizedBox,
//                                                       ParagraphText(
//                                                         text: 'Dislike',
//                                                         color: MyColors
//                                                             .primaryColor,
//                                                         fontSize: 12,
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Positioned(
//                             top: 60,
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 5, horizontal: 16),
//                               decoration: BoxDecoration(
//                                 color: MyColors.lightblue,
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(12),
//                                   bottomRight: Radius.circular(12),
//                                 ),
//                               ),
//                               child: ParagraphText(
//                                 text: 'freshed with ox21 coin',
//                                 color: MyColors.primaryColor,
//                                 fontFamily: 'semibold',
//                                 fontSize: 9,
//                               ),
//                             )),
//                         Positioned(
//                             top: 65,
//                             right: 10,
//                             child: Image.asset(
//                               MyImages.starfill,
//                               width: 20,
//                             ))
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
