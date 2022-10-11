import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/play_video_page.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:video_player/video_player.dart';

import '../constants/colors.dart';
import '../constants/global_functions.dart';
import '../widgets/appbar.dart';
import '../widgets/customtextfield.dart';
import '../widgets/play_video_widget.dart';
import 'package:flutter_translate/flutter_translate.dart';
class My_Videos_Page extends StatefulWidget {
  static const String id = "My_videos_page";
  const My_Videos_Page({Key? key}) : super(key: key);

  @override
  State<My_Videos_Page> createState() => _My_Videos_PageState();
}

class _My_Videos_PageState extends State<My_Videos_Page> {
  VideoPlayerController? _controller;
  initializeController(String videoUrl) async {
    _controller = VideoPlayerController.network(videoUrl
        // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
        )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      }).onError((error, stackTrace) {
        print('the errorr is $error and strach $stackTrace');
        initializeController(videoUrl);
      });
  }

  bool load = true;
  bool showSearch = false;
  int count = 0;
  TextEditingController searchController = TextEditingController();
  List myVideos = [
    {
      'title': 'Impact Of Information',
      'description': 'This is the desoclksdfn',
      "thumbnail":
          "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
      "video":
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      "screenshots": [
        "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
        "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
        "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
      ],
      'views': '5',
      'likes': '6',
      'comments': '27',
      "time": DateTime.now().toString(),
    },
    {
      'title': 'Impact Of Information',
      'description': 'This is the desoclksdfn',
      "thumbnail":
          "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
      "video":
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      "screenshots": [
        "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
        "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
        "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
      ],
      'views': '5',
      'likes': '6',
      'comments': '27',
      "time": DateTime.now().toString(),
    },
    {
      'title': 'Impact Of Information',
      'description': 'This is the desoclksdfn',
      "thumbnail":
          "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
      "video":
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      "screenshots": [
        "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
        "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
        "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
      ],
      'views': '5',
      'likes': '6',
      'comments': '27',
      "time": DateTime.now().toString(),
    }
  ];
  List shorts = [
    {
      'title': 'Impact Of Information',
      'description': 'This is the description',
      "thumbnail":
          "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
      "video":
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      "screenshots": [
        "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
        "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
        "https://storage.googleapis.com/ares-profile-pictures/hd/karwaan007-5a40c12128002b997f0059595fa6717e_hd.jpg",
      ],
      'views': '5',
      'likes': '6',
      'comments': '27',
      "time": DateTime.now().toString(),
    },
  ];

  String selectedVideoType = 'videos';
  getVideos() async {
    setState(() {
      load = true;
    });
    myVideos = await Webservices.getList(
        ApiUrls.getVideos + '$userId' + '?video_type=videos');
    shorts = await Webservices.getList(
        ApiUrls.getVideos + '$userId' + '?video_type=shorts');
    // shorts.clear();
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    count = 0;
    if (selectedVideoType == 'videos') {
      for (int index = 0; index < myVideos.length; index++)
        if ((myVideos[index]['title']
            .toString()
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))) count++;
    } else if (selectedVideoType == 'shorts') {
      for (int index = 0; index < shorts.length; index++)
        if ((shorts[index]['title']
            .toString()
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))) count++;
    }

    return Scaffold(
      backgroundColor: Color(0xFFeaedf6),
      appBar: appBar(
          context: context,
          title:translate("my_video_page.yourVideos"),
          titleColor: MyColors.secondary,
          // toolbarHeight: 50,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  showSearch = !showSearch;
                });
              },
              icon: Icon(
                Icons.search_outlined,
                size: 25,
                color: MyColors.secondary,
              ),
            )
          ]),
      body: load
          ? CustomLoader()
          : Container(
              child: Column(
                children: [
                  if (showSearch)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextField(
                        bgColor: Colors.white,
                        controller: searchController,
                        hintText:translate("my_video_page.search"),
                        onChanged: (value) {
                          setState(() {
                            count = 0;
                          });
                        },
                      ),
                    ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        // ChoiceChip(
                        //   label: Icon(
                        //     Icons.tune_outlined,
                        //     color: MyColors.primaryColor,
                        //     size: 20,
                        //   ),
                        //   selected: false,
                        //   backgroundColor: Colors.transparent,
                        //   disabledColor: MyColors.secondary.withOpacity(0.3),
                        //   selectedColor: MyColors.secondary,
                        //   onSelected: (value) {
                        //     // selectedVideoType = 'filter';
                        //     setState(() {});
                        //   },
                        // ),
                        // hSizedBox,
                        ChoiceChip(
                          label: Text(
                            translate("my_video_page.videos"),
                            style: TextStyle(color: MyColors.blackColor),
                          ),
                          selected: selectedVideoType == 'videos',
                          backgroundColor: Colors.transparent,
                          disabledColor: MyColors.secondary.withOpacity(0.3),
                          selectedColor: MyColors.secondary,
                          onSelected: (value) {
                            selectedVideoType = 'videos';
                            setState(() {});
                          },
                        ),
                        hSizedBox,
                        ChoiceChip(
                          label: Text(
                            translate("my_video_page.shorts"),
                            style: TextStyle(color: MyColors.blackColor),
                          ),
                          selected: selectedVideoType == 'shorts',
                          backgroundColor: Colors.transparent,
                          disabledColor: MyColors.secondary.withOpacity(0.3),
                          selectedColor: MyColors.secondary,
                          onSelected: (value) {
                            selectedVideoType = 'shorts';
                            setState(() {});
                          },
                        ),
                        hSizedBox,
                      ],
                    ),
                  ),
                  vSizedBox4,
                  if ((selectedVideoType == 'videos' && myVideos.length != 0) ||
                      (selectedVideoType == 'shorts' && shorts.length != 0))
                    Expanded(
                      child: ListView.builder(
                        itemCount: selectedVideoType == 'videos'
                            ? myVideos.length
                            : shorts.length,
                        itemBuilder: (context, index) {
                          if ((selectedVideoType == 'videos' &&
                                  myVideos[index]['title']
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchController.text
                                          .toLowerCase())) ||
                              (selectedVideoType == 'shorts' &&
                                  shorts[index]['title']
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchController.text
                                          .toLowerCase()))) {
                            return GestureDetector(
                              onTap: () async {
                                bool isPlaying = false;
                                print('111222');
                                String link = MyGlobalConstants.ipfsLink;
                                if (selectedVideoType == 'videos')
                                  link = link + myVideos[index]['video_cid'];
                                else
                                  link = link + shorts[index]['video_cid'];
                                print('the link is $link');
                                // // Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayVideoPage(videoUrl:link)));
                                // await initializeController(link);
                                // showDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       return StatefulBuilder(
                                //           builder: (context, setState) {
                                //         return Dialog(
                                //           insetPadding: EdgeInsets.symmetric(
                                //               horizontal: 0, vertical: 0),
                                //           backgroundColor: Colors.transparent,
                                //           child: Container(
                                //             // decoration: BoxDecoration(
                                //             //   color: Colors.white,
                                //             //   borderRadius: BorderRadius.circular(15)
                                //             // ),
                                //             height: MediaQuery.of(context)
                                //                     .size
                                //                     .height -
                                //                 0,
                                //             margin: EdgeInsets.symmetric(
                                //                 horizontal: 0),
                                //             child: Column(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment.center,
                                //               mainAxisSize: MainAxisSize.min,
                                //               children: [
                                //                 Stack(
                                //                   children: [
                                //                     Padding(
                                //                       padding:
                                //                           EdgeInsets.symmetric(
                                //                               horizontal: 0),
                                //                       child: InteractiveViewer(
                                //                         maxScale: 3,
                                //                         minScale: 1,
                                //                         child: AspectRatio(
                                //                           aspectRatio:
                                //                               _controller!.value
                                //                                   .aspectRatio,
                                //                           // aspectRatio: 1.4,
                                //                           child: VideoPlayer(
                                //                               _controller!),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                     Positioned(
                                //                       left: 0,
                                //                       right: 0,
                                //                       top: 0,
                                //                       bottom: 0,
                                //                       child: Center(
                                //                         child: IconButton(
                                //                           icon: Icon(
                                //                             isPlaying
                                //                                 ? Icons.pause
                                //                                 : Icons
                                //                                     .play_arrow,
                                //                             color: Colors.white,
                                //                             size: 50,
                                //                           ),
                                //                           onPressed: () {
                                //                             !isPlaying
                                //                                 ? _controller
                                //                                     ?.play()
                                //                                 : _controller
                                //                                     ?.pause();
                                //
                                //                             isPlaying =
                                //                                 !isPlaying;
                                //                             setState(() {});
                                //                           },
                                //                         ),
                                //                       ),
                                //                     ),
                                //                     Positioned(
                                //                       right: 0,
                                //                       top: 0,
                                //                       child: Center(
                                //                         child: IconButton(
                                //                           icon: Icon(
                                //                             Icons.close,
                                //                             size: 30,
                                //                             color: MyColors
                                //                                 .whiteColor,
                                //                           ),
                                //                           onPressed: () {
                                //                             _controller
                                //                                 ?.dispose();
                                //                             Navigator.pop(
                                //                                 context);
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

                                push(context: context, screen: PlayVideoPage(url: link));
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayVideoPage(videoUrl: selectedVideoType=='videos'? myVideos[index]['video']: shorts[index]['video'])));
                              },
                              child: Container(
                                // color: Colors.red,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Image.network(
                                        selectedVideoType == 'videos'
                                            ? myVideos[index]['thumbnail']
                                            : shorts[index]['thumbnail'],
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    hSizedBox2,
                                    Expanded(
                                        flex: 7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: SubHeadingText(
                                                          text:
                                                              selectedVideoType ==
                                                                      'videos'
                                                                  ? myVideos[
                                                                          index]
                                                                      ['title']
                                                                  : shorts[index]
                                                                      ['title'],
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      hSizedBox,
                                                      if((selectedVideoType ==
                                                          'videos'
                                                          ? myVideos[
                                                      index]
                                                      ['use_points']
                                                          : shorts[index]
                                                      ['use_points'])==0)
                                                      RoundEdgedButton(
                                                          text:
                                                          translate("my_video_page.addFresh"),
                                                        width: 140,
                                                        isSolid: false,
                                                        verticalPadding: 1,
                                                        height: null,
                                                        fontfamily: 'medium',
                                                        onTap: ()async{
                                                            if(userData!['points']<100){
                                                              print(userData!['points']);
                                                              showSnackbar(context, translate("my_video_page.alertFresh"));

                                                            }else{


                                                              String? freshness = await showModalBottomSheet(context: context, builder: (context){
                                                                return Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      SubHeadingText(text: translate("my_video_page.selectFresh")),
                                                                      vSizedBox2,
                                                                      for(int i = 1;i<freshnessList.length;i++)
                                                                        GestureDetector(
                                                                          behavior: HitTestBehavior.opaque,
                                                                          onTap: (){
                                                                            Navigator.pop(context, freshnessList[i]);
                                                                          },
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                                                            child: ParagraphText(text: '${freshnessList[i]}',fontSize: 18,),
                                                                          ),
                                                                        ),

                                                                    ],
                                                                  ),
                                                                );
                                                              });
                                                              if(freshness!=null){
                                                                setState(() {
                                                                  load = true;
                                                                });
                                                                var request = {
                                                                  'user_id': userId,
                                                                  'id': (selectedVideoType ==
                                                                      'videos'
                                                                      ? myVideos[
                                                                  index]
                                                                  ['id']
                                                                      : shorts[index]
                                                                  ['id']).toString(),
                                                                  'use_points': freshness
                                                                };
                                                                var jsonResponse = await Webservices.postData(url: ApiUrls.addFreshnessPoints, request: request, context: context);
                                                                if(jsonResponse['status'].toString()=='1'){
                                                                  showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, jsonResponse['message']);
                                                                  getVideos();
                                                                }else{
                                                                  setState(() {
                                                                    load = false;
                                                                  });
                                                                }
                                                              }
                                                            }
                                                        },
                                                      )
                                                      else
                                                        Expanded(
                                                          child: ParagraphText(text: (selectedVideoType ==
                                                              'videos'
                                                              ? myVideos[index]
                                                          [
                                                          'use_points']
                                                              .toString()
                                                              : shorts[index][
                                                          'use_points']
                                                              .toString()) + translate("my_video_page.pointAdded"), color: MyColors.green,textAlign: TextAlign.center,),
                                                        )
                                                    ],
                                                  ),
                                                  vSizedBox,
                                                  Row(
                                                    children: [
                                                      ParagraphText(
                                                        text: (selectedVideoType ==
                                                                    'videos'
                                                                ? myVideos[index]
                                                                        [
                                                                        'views']
                                                                    .toString()
                                                                : shorts[index][
                                                                        'views']
                                                                    .toString()) +
                                                            translate("my_video_page.views"),
                                                        fontSize: 12,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                      ),
                                                      hSizedBox,
                                                      ParagraphText(
                                                        text: selectedVideoType ==
                                                                'videos'
                                                            ? timeAgo(DateTime
                                                                .parse(myVideos[
                                                                        index][
                                                                    'created_at']))
                                                            : timeAgo(DateTime
                                                                .parse(shorts[
                                                                        index][
                                                                    'created_at'])),
                                                        fontSize: 12,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                      ),
                                                    ],
                                                  ),
                                                  vSizedBox05,
                                                  Row(
                                                    children: [
                                                      ParagraphText(
                                                        text: (selectedVideoType ==
                                                                'videos'
                                                            ? myVideos[index][
                                                                    'visibility']
                                                                .toString()
                                                            : shorts[index][
                                                                    'visibility']
                                                                .toString()),
                                                        fontSize: 12,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                      ),
                                                      hSizedBox,
                                                      ParagraphText(
                                                        text: translate("my_video_page.playlist") +
                                                            (selectedVideoType ==
                                                                    'videos'
                                                                ? myVideos[index]
                                                                            [
                                                                            'playlist'][0]
                                                                        ['name']
                                                                    .toString()
                                                                : shorts[index][
                                                                            'playlist']
                                                                        [
                                                                        0]['name']
                                                                    .toString()),
                                                        fontSize: 12,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                      ),
                                                      hSizedBox,
                                                      // ParagraphText(text:selectedVideoType=='videos'?  timeAgo(DateTime.parse(myVideos[index]['created_at'])):timeAgo(DateTime.parse(shorts[index]['created_at'])),fontSize: 12,color: Colors.black.withOpacity(0.5),),
                                                    ],
                                                  ),
                                                  vSizedBox05,
                                                  Row(
                                                    children: [
                                                      ParagraphText(
                                                        text: translate("my_video_page.channel") +
                                                            (selectedVideoType ==
                                                                    'videos'
                                                                ? myVideos[index]
                                                                            [
                                                                            'channel'][0]
                                                                        ['name']
                                                                    .toString()
                                                                : shorts[index][
                                                                            'channel']
                                                                        [
                                                                        0]['name']
                                                                    .toString()),
                                                        fontSize: 12,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                      ),
                                                    ],
                                                  ),
                                                  vSizedBox,
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      // Image.asset(MyImages.attach_video, width: 20,), hSizedBox,
                                                      Image.asset(
                                                        MyImages.like_video,
                                                        width: 15,
                                                      ),
                                                      hSizedBox,
                                                      ParagraphText(
                                                        text:
                                                            selectedVideoType ==
                                                                    'videos'
                                                                ? myVideos[index]
                                                                        [
                                                                        'likes']
                                                                    .toString()
                                                                : shorts[index][
                                                                        'likes']
                                                                    .toString(),
                                                        fontSize: 12,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                      ),
                                                      hSizedBox,
                                                      RotatedBox(
                                                        child: Image.asset(
                                                          MyImages.like_video,
                                                          width: 15,
                                                        ),
                                                        quarterTurns: 2,
                                                      ),
                                                      hSizedBox,
                                                      ParagraphText(
                                                        text: selectedVideoType ==
                                                                'videos'
                                                            ? myVideos[index]
                                                                    ['dislikes']
                                                                .toString()
                                                            : shorts[index]
                                                                    ['dislikes']
                                                                .toString(),
                                                        fontSize: 12,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                      ),
                                                      hSizedBox,
                                                      Image.asset(
                                                        MyImages.comment_video,
                                                        width: 15,
                                                      ),
                                                      hSizedBox,
                                                      ParagraphText(
                                                        text: selectedVideoType ==
                                                                'videos'
                                                            ? myVideos[index]
                                                                    ['comments']
                                                                .toString()
                                                            : shorts[index]
                                                                    ['comments']
                                                                .toString(),
                                                        fontSize: 12,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            // PopupMenuButton(
                                            //
                                            //   icon: Icon(Icons.more_vert, color: MyColors.blackColor,),
                                            //   elevation: 0,
                                            //   offset: Offset(0, 0),
                                            //   padding: EdgeInsets.all(0),
                                            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                            //   itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                                            //     const PopupMenuItem(
                                            //       child: ListTile(
                                            //         contentPadding: EdgeInsets.all(0),
                                            //         visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                            //         title: Text('Edit'),
                                            //       ),
                                            //     ),
                                            //     const PopupMenuItem(
                                            //       child: ListTile(
                                            //         contentPadding: EdgeInsets.all(0),
                                            //         visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                            //         title: Text('Delete'),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    )
                  else
                    Expanded(
                      child: Center(
                        child: Text(translate("my_video_page.noVideos")),
                      ),
                    ),
                  if (count == 0 &&
                      ((selectedVideoType == 'videos' &&
                              myVideos.length != 0) ||
                          (selectedVideoType == 'shorts' &&
                              shorts.length != 0)))
                    Expanded(
                      child: Center(
                        child: Text(translate("my_video_page.noVideos")),
                      ),
                    ),
                  vSizedBox,
                ],
              ),
            ),
    );
  }
}
