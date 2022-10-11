import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_functions.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/mycoins.dart';
import 'package:ox21/pages/comments_page_bottom_sheet.dart';
import 'package:ox21/pages/video_player_essentials/flick_multi_manager.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/top_banner_purchase_bid_language.dart';
import 'package:ox21/upload_video_view.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/avatar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:ox21/widgets/play_video_widget.dart';
import 'package:ox21/widgets/show_custom_modal_sheet.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../custom_dialogs/rent_banner_bottom_sheet.dart';
import '../widgets/fully_custom_dropdown.dart';
import 'package:flutter_translate/flutter_translate.dart';


class NewestHomePage extends StatefulWidget {
  static const String id = "newhome";
  const NewestHomePage({Key? key}) : super(key: key);

  @override
  State<NewestHomePage> createState() => _NewestHomePageState();
}

class _NewestHomePageState extends State<NewestHomePage> {
  bool pageLoad = false;

  bool onLastIndex = true;
  List items = [];

  int pageNo = 1;
  late FlickMultiManager flickMultiManager;

  getVideos() async {
    pageLoad = true;
    setState(() {});

    items = await Webservices.getList(ApiUrls.getAllPost + 'user_id=$userId');
    flickMultiManager = FlickMultiManager();
    setState(() {
      pageLoad = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    getVideos();
  }

  // VideoPlayerController? _controller;
  // initializeController(String videoUrl) async {
  //   _controller = VideoPlayerController.network(videoUrl
  //       )
  //     ..initialize().then((_) {
  //     }).onError((error, stackTrace) {
  //       print('the errorr is $error and strach $stackTrace');
  //       initializeController(videoUrl);
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    print('Home page post dlength is  ${items.length}');
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        // backgroundColor: Color(0xFF88E1E5),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            items = await Webservices.getList(
                ApiUrls.getAllPost + 'user_id=$userId');
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      vSizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ParagraphText(
                            text: translate("add_detail.create"),
                            color: MyColors.secondary,
                            fontSize: 16,
                            fontFamily: 'semibold',
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close_outlined,
                              size: 20,
                              color: MyColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      vSizedBox2,
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          print('button poresssed');
                          File? video = await pickVideo(isGallery: false);
                          if (video != null) {
                            // Navigator.pop(context);
                            Uint8List? uint8list =
                                await VideoThumbnail.thumbnailData(
                              video: video.path,
                              imageFormat: ImageFormat.JPEG,
                              maxWidth:
                                  400, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
                              maxHeight: 400,
                              quality: 50,
                            );
                            print(uint8list);
                            if (uint8list != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UploadPageView(
                                            video: video,
                                            image: uint8list,
                                            videoType: 'shorts',
                                          )));
                            }
                          }
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatarcustom(
                                    image: MyImages.short,
                                    // image: '/assets/',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ParagraphText(
                                          text: translate("newest_home_page.createShort"),
                                          color: MyColors.heading,
                                          fontSize: 12,
                                          fontFamily: 'bold',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      vSizedBox2,
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          print('button poresssed');
                          File? video = await pickVideo(isGallery: true);
                          if (video != null) {
                            // Navigator.pop(context);
                            Uint8List? uint8list =
                                await VideoThumbnail.thumbnailData(
                              video: video.path,
                              imageFormat: ImageFormat.JPEG,
                              maxWidth:
                                  400, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
                              maxHeight: 400,
                              quality: 50,
                            );
                            print(uint8list);
                            if (uint8list != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UploadPageView(
                                            video: video,
                                            image: uint8list,
                                            videoType: 'videos',
                                          )));
                            }
                            // Navigator.pushNamed(context, Upload_Page.id);
                            // Navigator.pushNamed(context, UploadPageView.id);

                          }
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatarcustom(
                                    image: MyImages.upload_video,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ParagraphText(
                                          text: translate("my_purchased_banners.uploadVideo"),
                                          color: MyColors.heading,
                                          fontSize: 12,
                                          fontFamily: 'bold',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          backgroundColor: MyColors.secondary,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, MyCoinsPage.id);
                    },
                    child: Image.asset(
                      MyImages.user,
                      width: 24,
                      height: 24,
                    )),
              ],
            ),
          ),
          centerTitle: true,
          title: Image.asset(
            MyImages.logo_white,
            width: 104,
          ),
          actions: [],
          backgroundColor: Color(0xFF88E1E5),
        ),
        body: pageLoad
            ? CustomLoader()
            : RefreshIndicator(
                onRefresh: () async {
                  getVideos();
                },
                child: Container(
                  color: Color(0xFFECF6F9),
                  padding: EdgeInsets.only(top: 16),
                  child: NotificationListener<ScrollUpdateNotification>(
                    onNotification: (scroll) {
                      if (onLastIndex &&
                          scroll.metrics.maxScrollExtent ==
                              scroll.metrics.pixels) {
                        onLastIndex = false;
                        String lastObjectId = items.last['id'].toString();
                        List newData = [];
                        setState(() {});

                        Webservices.getList(ApiUrls.getAllPost +
                                'user_id=$userId&last_id=$lastObjectId&page=${++pageNo}')
                            .then((value) {
                          newData = value;
                          setState(() {
                            print('about to add new items ${items.length}');
                            items = items + newData;
                            print('added new items ${items.length}');
                            onLastIndex = true;
                          });
                        });
                      }

                      return true;
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          vSizedBox8,
                          vSizedBox4,
                          GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TopBannerLanguagePage()));
                            },
                            child: Container(
                              // height: 200,
                              constraints: BoxConstraints(maxHeight: 300),
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              width: MediaQuery.of(context).size.width - 16,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              clipBehavior: Clip.hardEdge,

                              child: Image.asset(
                                MyImages.bannerPurchase,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          items.length == 0
                              ? Center(
                                  child: ParagraphText(
                                    text: translate("my_video_page.noVideos"),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    if (items[index]['is_banner'])
                                      return GestureDetector(
                                        onTap: () async {
                                          if (items[index]
                                                      ['is_available_for_rent']
                                                  .toString() ==
                                              '1') {
                                            if (items[index]['user_id']
                                                    .toString() ==
                                                userId) {
                                            } else {
                                              int? selectedMonths;
                                              TextEditingController
                                                  dateController =
                                                  TextEditingController();
                                              DateTime selectedDate =
                                                  DateTime.now()
                                                      .add(Duration(days: 10));
                                              bool rentBannerLoad = false;
                                              bool? result =
                                                  await showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      builder: (context) {
                                                        return RentBanner(
                                                          item: items[index],
                                                        );
                                                        // return StatefulBuilder(
                                                        //     builder: (context, setState) {
                                                        //       return Container(
                                                        //         padding:
                                                        //         EdgeInsets.symmetric(
                                                        //             horizontal: 16),
                                                        //         decoration: BoxDecoration(
                                                        //           color: Colors.white,
                                                        //           borderRadius:
                                                        //           BorderRadius.circular(
                                                        //               14),
                                                        //         ),
                                                        //         height: 400 +
                                                        //             MediaQuery.of(context)
                                                        //                 .viewInsets
                                                        //                 .bottom,
                                                        //         child: Column(
                                                        //           mainAxisSize:
                                                        //           MainAxisSize.min,
                                                        //           children: [
                                                        //             vSizedBox,
                                                        //             MainHeadingText(
                                                        //                 text:
                                                        //                 'Rent this banner'),
                                                        //             vSizedBox,
                                                        //             Row(
                                                        //               mainAxisAlignment:
                                                        //               MainAxisAlignment
                                                        //                   .spaceBetween,
                                                        //               children: [
                                                        //                 Expanded(
                                                        //                     child:
                                                        //                     SubHeadingText(
                                                        //                       text:
                                                        //                       'Select Date',
                                                        //                     )),
                                                        //                 hSizedBox,
                                                        //                 Expanded(
                                                        //                     child:
                                                        //                     GestureDetector(
                                                        //                       onTap: () async {
                                                        //                         DateTime? temp =
                                                        //                         await showDatePicker(
                                                        //                           context:
                                                        //                           context,
                                                        //                           initialDate:
                                                        //                           selectedDate,
                                                        //                           firstDate: DateTime
                                                        //                               .now()
                                                        //                               .add(Duration(
                                                        //                               days:
                                                        //                               5)),
                                                        //                           lastDate: DateTime
                                                        //                               .now()
                                                        //                               .add(Duration(
                                                        //                               days: 365 *
                                                        //                                   2)),
                                                        //                         );
                                                        //                         if (temp !=
                                                        //                             null) {
                                                        //                           setState(() {
                                                        //                             selectedDate =
                                                        //                                 temp;
                                                        //                             dateController
                                                        //                                 .text = DateFormat
                                                        //                                 .yMMMd()
                                                        //                                 .format(
                                                        //                                 selectedDate);
                                                        //                           });
                                                        //                         }
                                                        //                       },
                                                        //                       child: CustomTextField(
                                                        //                           controller:
                                                        //                           dateController,
                                                        //                           hintText:
                                                        //                           'Select Date',
                                                        //                           enabled:
                                                        //                           false),
                                                        //                     )),
                                                        //               ],
                                                        //             ),
                                                        //             vSizedBox,
                                                        //             Row(
                                                        //               // crossAxisAlignment: CrossAxisAlignment.start,
                                                        //               mainAxisAlignment:
                                                        //               MainAxisAlignment
                                                        //                   .spaceBetween,
                                                        //               children: [
                                                        //                 Expanded(
                                                        //                   child:
                                                        //                   SubHeadingText(
                                                        //                     text:
                                                        //                     'Select Months',
                                                        //                   ),
                                                        //                 ),
                                                        //                 hSizedBox,
                                                        //                 Expanded(
                                                        //                   child:
                                                        //                   CustomDropDown(
                                                        //                     hint:
                                                        //                     'Select months',
                                                        //                     onChanged:
                                                        //                         (val) {
                                                        //                       selectedMonths = val;
                                                        //                       setState(() {
                                                        //
                                                        //                       });
                                                        //                     },
                                                        //                     selectedItem:
                                                        //                     selectedMonths,
                                                        //                     items: List
                                                        //                         .generate(
                                                        //                       12,
                                                        //                           (index) =>
                                                        //                           DropdownMenuItem<int>(
                                                        //                             value:
                                                        //                             index + 1,
                                                        //                             child:
                                                        //                             ParagraphText(
                                                        //                               text:
                                                        //                               '${index + 1}',
                                                        //                             ),
                                                        //                           ),
                                                        //                     ),
                                                        //                   ),
                                                        //                 ),
                                                        //               ],
                                                        //             ),
                                                        //             vSizedBox,
                                                        //             if(selectedMonths!=null)
                                                        //               Wrap(
                                                        //                 crossAxisAlignment: WrapCrossAlignment.end,
                                                        //                 children: [
                                                        //                   ParagraphText(text: 'You will be charged '),
                                                        //                   ParagraphText(text: '${(selectedMonths! * items[index]['total_rent']).toStringAsFixed(2)} BTC', fontWeight: FontWeight.w700,)
                                                        //                 ],
                                                        //               ),
                                                        //             vSizedBox6,
                                                        //             RoundEdgedButton(text: 'Rent', onTap: ()async{
                                                        //               var request = {
                                                        //                 "banner_id":items[index]['banner_id'].toString(),
                                                        //                 "start_date":selectedDate.toString(),
                                                        //                 "months":selectedMonths.toString(),
                                                        //                 "tenant":userId,
                                                        //               };
                                                        //
                                                        //               setState((){
                                                        //                 rentBannerLoad = true;
                                                        //               });
                                                        //               var jsonResponse = await Webservices.postData(url: ApiUrls.buy_banner_on_rent, request: request, context: context, showSuccessMessage: true);
                                                        //               // if(jsonResponse['status']==1){
                                                        //                 Navigator.pop(context);
                                                        //               // }
                                                        //               try{
                                                        //                 setState((){
                                                        //                   rentBannerLoad = false;
                                                        //                 });
                                                        //               }catch(e){
                                                        //                 try{
                                                        //                   this.setState((){
                                                        //                     rentBannerLoad = false;
                                                        //                   });
                                                        //                 }catch(ef){
                                                        //                   print("Error in catch block $ef and first was $e");
                                                        //                 }
                                                        //               }
                                                        //             },),
                                                        //           ],
                                                        //         ),
                                                        //       );
                                                        //     }
                                                        // );
                                                      });
                                            }
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TopBannerLanguagePage()));
                                          }
                                        },
                                        child: Container(
                                          // height: 200,
                                          constraints:
                                              BoxConstraints(maxHeight: 300),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              16,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(32),
                                          ),
                                          clipBehavior: Clip.hardEdge,

                                          child: Image.network(
                                            items[index]['image'],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 380,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      bool isPlaying = false;
                                                      print('111222');
                                                      String link =
                                                          MyGlobalConstants
                                                              .ipfsLink;
                                                      link = link +
                                                          items[index]
                                                              ['video_cid'];
                                                      print(
                                                          'the link is $link');

                                                      // await initializeController(
                                                      //     link);
                                                      // showDialog(
                                                      //     context: context,
                                                      //     builder: (context) {
                                                      //       return StatefulBuilder(
                                                      //           builder: (context,
                                                      //               setState) {
                                                      //         return Dialog(
                                                      //           insetPadding: EdgeInsets
                                                      //               .symmetric(
                                                      //                   horizontal:
                                                      //                       0,
                                                      //                   vertical:
                                                      //                       0),
                                                      //           backgroundColor:
                                                      //               Colors
                                                      //                   .transparent,
                                                      //           child:
                                                      //               Container(
                                                      //             // decoration: BoxDecoration(
                                                      //             //   color: Colors.white,
                                                      //             //   borderRadius: BorderRadius.circular(15)
                                                      //             // ),
                                                      //             height: MediaQuery.of(
                                                      //                         context)
                                                      //                     .size
                                                      //                     .height -
                                                      //                 0,
                                                      //             margin: EdgeInsets
                                                      //                 .symmetric(
                                                      //                     horizontal:
                                                      //                         0),
                                                      //             child: Column(
                                                      //               mainAxisAlignment:
                                                      //                   MainAxisAlignment
                                                      //                       .center,
                                                      //               mainAxisSize:
                                                      //                   MainAxisSize
                                                      //                       .min,
                                                      //               children: [
                                                      //                 Stack(
                                                      //                   children: [
                                                      //                     Padding(
                                                      //                       padding:
                                                      //                           EdgeInsets.symmetric(horizontal: 0),
                                                      //                       child:
                                                      //                           InteractiveViewer(
                                                      //                         maxScale: 3,
                                                      //                         minScale: 1,
                                                      //                         child: AspectRatio(
                                                      //                           aspectRatio: _controller!.value.aspectRatio,
                                                      //                           // aspectRatio: 1.4,
                                                      //                           child: VideoPlayer(
                                                      //                             _controller!,
                                                      //                           ),
                                                      //                         ),
                                                      //                       ),
                                                      //                     ),
                                                      //                     Positioned(
                                                      //                       // left: 0,
                                                      //                       // top: 0,
                                                      //                       right:
                                                      //                           16,
                                                      //
                                                      //                       bottom:
                                                      //                           16,
                                                      //                       child:
                                                      //                           Center(
                                                      //                         child: IconButton(
                                                      //                           icon: Icon(
                                                      //                             isPlaying ? Icons.pause : Icons.play_arrow,
                                                      //                             color: Colors.white,
                                                      //                             size: 50,
                                                      //                           ),
                                                      //                           onPressed: () {
                                                      //                             !isPlaying ? _controller?.play() : _controller?.pause();
                                                      //
                                                      //                             isPlaying = !isPlaying;
                                                      //                             setState(() {});
                                                      //                           },
                                                      //                         ),
                                                      //                       ),
                                                      //                     ),
                                                      //                     Positioned(
                                                      //                       right:
                                                      //                           0,
                                                      //                       top:
                                                      //                           0,
                                                      //                       child:
                                                      //                           Center(
                                                      //                         child: IconButton(
                                                      //                           icon: Icon(
                                                      //                             Icons.close,
                                                      //                             size: 30,
                                                      //                             color: MyColors.whiteColor,
                                                      //                           ),
                                                      //                           onPressed: () {
                                                      //                             _controller?.dispose();
                                                      //                             Navigator.pop(context);
                                                      //                           },
                                                      //                         ),
                                                      //                       ),
                                                      //                     ),
                                                      //                   ],
                                                      //                 ),
                                                      //               ],
                                                      //             ),
                                                      //           ),
                                                      //         );
                                                      //       });
                                                      //     });

                                                      push(
                                                          context: context,
                                                          screen: PlayVideoPage(
                                                              url: link));

                                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayVideoPage(videoUrl:link)));
                                                    },
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Image.network(
                                                        items[index]
                                                                ['screenshots']
                                                            [0]['screenshot'],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (items[index]['domain'] !=
                                                  null)
                                                Positioned(
                                                  bottom: 16,
                                                  left: 32,
                                                  child: SubHeadingText(
                                                    text:
                                                        'By ${items[index]['domain']['domain']}',
                                                    color:
                                                        MyColors.primaryColor,
                                                  ),
                                                ),
                                              Positioned(
                                                  right: 12,
                                                  top: 12,
                                                  child: IconButton(
                                                    icon: Icon(Icons
                                                        .more_vert_outlined),
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                          context: context,
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          builder: (context) {
                                                            return Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          16),
                                                              height: 140,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  GestureDetector(
                                                                    behavior:
                                                                        HitTestBehavior
                                                                            .opaque,
                                                                    child:
                                                                        SubHeadingText(
                                                                      text:
                                                                      translate("newest_home_page.reportThis"),
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                    onTap:
                                                                        () async {
                                                                      Navigator.pop(
                                                                          context);
                                                                      TextEditingController
                                                                          reportMessageController =
                                                                          TextEditingController();
                                                                      bool? result = await showDialog(
                                                                          context: MyGlobalKeys.navigatorKey.currentContext!,
                                                                          builder: (context) {
                                                                            return Dialog(
                                                                              insetPadding: EdgeInsets.symmetric(horizontal: 24),
                                                                              child: Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    SubHeadingText(
                                                                                      text:translate("newest_home_page.report"),
                                                                                      color: Colors.red,
                                                                                    ),
                                                                                    vSizedBox05,
                                                                                    ParagraphText(text:translate("newest_home_page.text1")),
                                                                                    vSizedBox2,
                                                                                    CustomTextField(controller: reportMessageController, hintText: translate("newest_home_page.typeSome")),
                                                                                    vSizedBox2,
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        RoundEdgedButton(
                                                                                          text:translate("newest_home_page.no"),
                                                                                          verticalPadding: 0,
                                                                                          height: 36,
                                                                                          width: 100,
                                                                                          onTap: () {
                                                                                            Navigator.pop(MyGlobalKeys.navigatorKey.currentContext!);
                                                                                          },
                                                                                        ),
                                                                                        hSizedBox,
                                                                                        RoundEdgedButton(
                                                                                          text: translate("newest_home_page.yes"),
                                                                                          verticalPadding: 0,
                                                                                          height: 36,
                                                                                          width: 100,
                                                                                          color: Colors.red,
                                                                                          onTap: () {
                                                                                            Navigator.pop(MyGlobalKeys.navigatorKey.currentContext!, true);
                                                                                          },
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          });

                                                                      if (result ==
                                                                          true) {
                                                                        // var request ={
                                                                        //   "block_by":userId.toString(),
                                                                        //   "block_to":items[index]['user_id'].toString()
                                                                        // };
                                                                        if (reportMessageController.text ==
                                                                            '') {
                                                                          showSnackbar(
                                                                              MyGlobalKeys.navigatorKey.currentContext!,
                                                                              translate("newest_home_page.alertMsg"));
                                                                        } else {
                                                                          var request =
                                                                              {
                                                                            "post_id":
                                                                                items[index]['id'].toString(),
                                                                            "report_to":
                                                                                items[index]['user_id'].toString(),
                                                                            "report_by":
                                                                                userId.toString(),
                                                                            "message":
                                                                                reportMessageController.text,
                                                                          };
                                                                          // setState(() {
                                                                          //   pageLoad = true;
                                                                          // });

                                                                          var jsonResponse =
                                                                              await Webservices.postData(
                                                                            url:
                                                                                ApiUrls.report_post,
                                                                            request:
                                                                                request,
                                                                            context:
                                                                                MyGlobalKeys.navigatorKey.currentContext!,
                                                                          );
                                                                          if (jsonResponse['status'] ==
                                                                              1) {
                                                                            showSnackbar(MyGlobalKeys.navigatorKey.currentContext!,
                                                                                jsonResponse['message']);
                                                                          }
                                                                          // items = [];
                                                                          // getVideos();
                                                                        }
                                                                      }
                                                                    },
                                                                  ),
                                                                  CustomDivider(),
                                                                  GestureDetector(
                                                                    behavior:
                                                                        HitTestBehavior
                                                                            .opaque,
                                                                    onTap:
                                                                        () async {
                                                                      Navigator.pop(
                                                                          context);
                                                                      bool? result = await showDialog(
                                                                          context: MyGlobalKeys.navigatorKey.currentContext!,
                                                                          builder: (context) {
                                                                            return Dialog(
                                                                              insetPadding: EdgeInsets.symmetric(horizontal: 24),
                                                                              child: Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    SubHeadingText(text: translate("newest_home_page.RUS")),
                                                                                    vSizedBox05,
                                                                                    ParagraphText(text: translate("newest_home_page.text2")),
                                                                                    vSizedBox2,
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        RoundEdgedButton(
                                                                                          text:translate("newest_home_page.no"),
                                                                                          verticalPadding: 0,
                                                                                          height: 36,
                                                                                          width: 100,
                                                                                          onTap: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                        ),
                                                                                        hSizedBox,
                                                                                        RoundEdgedButton(
                                                                                          text: translate("newest_home_page.yes"),
                                                                                          verticalPadding: 0,
                                                                                          height: 36,
                                                                                          width: 100,
                                                                                          color: Colors.red,
                                                                                          onTap: () {
                                                                                            Navigator.pop(context, true);
                                                                                          },
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          });

                                                                      if (result ==
                                                                          true) {
                                                                        var request =
                                                                            {
                                                                          "block_by":
                                                                              userId.toString(),
                                                                          "block_to":
                                                                              items[index]['user_id'].toString()
                                                                        };
                                                                        setState(
                                                                            () {
                                                                          pageLoad =
                                                                              true;
                                                                        });
                                                                        items =
                                                                            [];

                                                                        var jsonResponse =
                                                                            await Webservices.postData(
                                                                          url: ApiUrls
                                                                              .do_not_see_user_post,
                                                                          request:
                                                                              request,
                                                                          context: MyGlobalKeys
                                                                              .navigatorKey
                                                                              .currentContext!,
                                                                        );
                                                                        if (jsonResponse['status'] ==
                                                                            1) {
                                                                          showSnackbar(
                                                                              MyGlobalKeys.navigatorKey.currentContext!,
                                                                              jsonResponse['message']);
                                                                        }
                                                                        getVideos();
                                                                      }
                                                                    },
                                                                    child:
                                                                        SubHeadingText(
                                                                      text:
                                                                      translate("newest_home_page.block"),
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                    },
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 16,
                                                  right: 16,
                                                  top: 0,
                                                  bottom: 10),
                                              padding: EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  top: 10,
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFfbfbfb),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  )),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    flex: 3,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: 0,
                                                          bottom: 0,
                                                          left: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ParagraphText(
                                                            text: items[index]
                                                                ['title'],
                                                            color: MyColors
                                                                .blackColor,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'semibold',
                                                          ),
                                                          // Image.asset(MyImages.attach, width: 15,),
                                                          hSizedBox,
                                                          ParagraphText(
                                                            text: items[index]
                                                                ['description'],
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 6,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          behavior:
                                                              HitTestBehavior
                                                                  .opaque,
                                                          onTap: () async {
                                                            if (items[index][
                                                                    'is_like'] !=
                                                                1) {
                                                              print(
                                                                  '${items[index]['id']} is liked ');
                                                              items[index][
                                                                  'is_like'] = 1;
                                                              setState(() {});
                                                              await Webservices
                                                                  .getData(ApiUrls
                                                                          .likePost +
                                                                      'user_id=$userId&post_id=${items[index]['id']}');
                                                            } else {
                                                              items[index][
                                                                  'is_like'] = 0;
                                                              setState(() {});
                                                              await Webservices
                                                                  .getData(ApiUrls
                                                                          .removelikeDislikePost +
                                                                      'user_id=$userId&post_id=${items[index]['id']}');
                                                            }
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16),
                                                            height: 28,
                                                            // width: 80,
                                                            decoration: BoxDecoration(
                                                                color: MyColors
                                                                    .lightblue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                            child: Row(
                                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              children: [
                                                                Image.asset(
                                                                  MyImages
                                                                      .heartfill,
                                                                  width: 16,
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                  color: items[index]
                                                                              [
                                                                              'is_like'] ==
                                                                          1
                                                                      ? Colors
                                                                          .red
                                                                      : null,
                                                                ),
                                                                // hSizedBox,
                                                                // ParagraphText(
                                                                //   text: 'Like',
                                                                //   color: MyColors
                                                                //       .primaryColor,
                                                                //   fontSize: 12,
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        hSizedBox,
                                                        GestureDetector(
                                                          behavior:
                                                              HitTestBehavior
                                                                  .opaque,
                                                          onTap: () async {
                                                            if (items[index][
                                                                    'is_like'] !=
                                                                -1) {
                                                              print(
                                                                  '${items[index]['id']} is liked ');
                                                              items[index][
                                                                  'is_like'] = -1;
                                                              setState(() {});
                                                              await Webservices
                                                                  .getData(ApiUrls
                                                                          .dislikePost +
                                                                      'user_id=$userId&post_id=${items[index]['id']}');
                                                            } else {
                                                              items[index][
                                                                  'is_like'] = 0;
                                                              setState(() {});
                                                              await Webservices
                                                                  .getData(ApiUrls
                                                                          .removelikeDislikePost +
                                                                      'user_id=$userId&post_id=${items[index]['id']}');
                                                            }
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8),
                                                            height: 28,
                                                            // width: 40,
                                                            decoration: BoxDecoration(
                                                                color: MyColors
                                                                    .lightblue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                            child: Row(
                                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              children: [
                                                                Image.asset(
                                                                  MyImages
                                                                      .dislikefill,
                                                                  width: 14,
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                  color: items[index]
                                                                              [
                                                                              'is_like'] ==
                                                                          -1
                                                                      ? Colors
                                                                          .red
                                                                      : null,
                                                                ),
                                                                // hSizedBox,
                                                                // ParagraphText(
                                                                //   text:
                                                                //       'Dislike',
                                                                //   color: MyColors
                                                                //       .primaryColor,
                                                                //   fontSize: 12,
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        hSizedBox,
                                                        GestureDetector(
                                                          behavior:
                                                              HitTestBehavior
                                                                  .opaque,
                                                          onTap: () async {
                                                            showCustomBottomSheet(

                                                              context,
                                                              child:
                                                                  CommentsPageInHomeFeed(postId: items[index]['id'].toString(),),
                                                                height: 400
                                                            );
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16),
                                                            height: 28,
                                                            // width: 80,
                                                            decoration: BoxDecoration(
                                                                color: MyColors
                                                                    .lightblue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                            child: Row(
                                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              children: [
                                                                Image.asset(
                                                                  MyImages
                                                                      .comment_video,
                                                                  width: 14,
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                  color: MyColors
                                                                      .primaryColor
                                                                      .withAlpha(
                                                                          92),
                                                                ),
                                                                // hSizedBox,
                                                                // ParagraphText(
                                                                //   text: 'Like',
                                                                //   color: MyColors
                                                                //       .primaryColor,
                                                                //   fontSize: 12,
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}
