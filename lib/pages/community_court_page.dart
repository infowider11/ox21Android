import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ox21/pages/video_player_essentials/flick_multi_manager.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:video_player/video_player.dart';

import '../constants/colors.dart';
import '../constants/global_constants.dart';
import '../constants/global_keys.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../top_banner_purchase_bid_language.dart';
import '../widgets/buttons.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/customtextfield.dart';
import 'package:flutter_translate/flutter_translate.dart';
class CommunityCourtPage extends StatefulWidget {
  const CommunityCourtPage({Key? key}) : super(key: key);

  @override
  _CommunityCourtPageState createState() => _CommunityCourtPageState();
}

class _CommunityCourtPageState extends State<CommunityCourtPage> {
bool pageLoad = false;

bool onLastIndex = true;
List items = [];

int pageNo = 1;
late FlickMultiManager flickMultiManager;

getVideos() async {
  pageLoad = true;
  setState(() {});

  items = await Webservices.getList(ApiUrls.Community_court_post + 'user_id=$userId');
  flickMultiManager = FlickMultiManager();
  setState(() {
    pageLoad = false;
  });
  // push(context: context, screen: CreatePrivateChannel());
}

@override
void initState() {
  // TODO: implement initState

  super.initState();

  getVideos();
}

VideoPlayerController? _controller;
initializeController(String videoUrl) async {
  // setState(() {
  //   load = true;
  // });
  _controller = VideoPlayerController.network(videoUrl
    // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
  )
    ..initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      // setState(() {
      //   load = false;
      // });
    }).onError((error, stackTrace) {
      print('the errorr is $error and strach $stackTrace');
      initializeController(videoUrl);
    });
}

@override
  Widget build(BuildContext context) {
  log('the dddd is ${items}');
    return Scaffold(
      appBar: appBar(context: context, title:translate("community_court_page.title")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child:pageLoad?CustomLoader():  items.length == 0
            ? Center(
          child: ParagraphText(
            text:translate("community_court_page.noData"),
          ),
        )
            :NotificationListener<ScrollUpdateNotification>(
          onNotification: (scroll) {
            if (onLastIndex &&
                scroll.metrics.maxScrollExtent ==
                    scroll.metrics.pixels) {
              onLastIndex = false;
              String lastObjectId = items.last['id'].toString();
              List newData = [];
              setState(() {});
              // items = await Webservices.getList(ApiUrls.Community_court_post + 'user_id=$userId');
              // Webservices.getList(ApiUrls.getAllPost +
              //     'user_id=$userId&last_id=$lastObjectId&page=${++pageNo}')

              Webservices.getList(ApiUrls.Community_court_post + 'user_id=$userId&page=${++pageNo}')
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
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),

          // separatorBuilder: (context, int) => Container(
          //   height: 50,
          // ),
          itemCount: items.length,
          itemBuilder: (context, index) {
              return Stack(
                children: [
                  Column(
                    children: [

                      GestureDetector(
                        child: Stack(
                          children: [
                            Container(
                              height: 380,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: GestureDetector(
                                  onTap: () async {
                                    bool isPlaying = false;
                                    print('111222');
                                    String link =
                                        MyGlobalConstants.ipfsLink;
                                    link = link + items[index]['video_cid'];
                                    print('the link is $link');
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayVideoPage(videoUrl:link)));
                                    await initializeController(link);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                                return Dialog(
                                                  insetPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 0),
                                                  backgroundColor:
                                                  Colors.transparent,
                                                  child: Container(
                                                    // decoration: BoxDecoration(
                                                    //   color: Colors.white,
                                                    //   borderRadius: BorderRadius.circular(15)
                                                    // ),
                                                    height:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height -
                                                        0,
                                                    margin:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      mainAxisSize:
                                                      MainAxisSize.min,
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                  0),
                                                              child:
                                                              InteractiveViewer(
                                                                maxScale: 3,
                                                                minScale: 1,
                                                                child:
                                                                AspectRatio(
                                                                  aspectRatio:
                                                                  _controller!
                                                                      .value
                                                                      .aspectRatio,
                                                                  // aspectRatio: 1.4,
                                                                  child:
                                                                  VideoPlayer(
                                                                    _controller!,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              // left: 0,
                                                              // top: 0,
                                                              right: 16,

                                                              bottom: 16,
                                                              child: Center(
                                                                child:
                                                                IconButton(
                                                                  icon: Icon(
                                                                    isPlaying
                                                                        ? Icons
                                                                        .pause
                                                                        : Icons
                                                                        .play_arrow,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 50,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    !isPlaying
                                                                        ? _controller
                                                                        ?.play()
                                                                        : _controller
                                                                        ?.pause();

                                                                    isPlaying =
                                                                    !isPlaying;
                                                                    setState(
                                                                            () {});
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              right: 0,
                                                              top: 0,
                                                              child: Center(
                                                                child:
                                                                IconButton(
                                                                  icon: Icon(
                                                                    Icons.close,
                                                                    size: 30,
                                                                    color: MyColors
                                                                        .whiteColor,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    _controller
                                                                        ?.dispose();
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        });

                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayVideoPage(videoUrl: selectedVideoType=='videos'? myVideos[index]['video']: shorts[index]['video'])));
                                  },
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width,
                                    child:items[index]['screenshots']==null?null: Image.network(
                                      items[index]['screenshots'][0]
                                      ['screenshot'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                              ),
                            ),
                            if(items[index]['domain']!=null)
                              Positioned(
                                bottom: 16,
                                left: 32,
                                child: SubHeadingText(text:'${translate("community_court_page.by")} ${items[index]['domain']['domain']}', color: MyColors.primaryColor,),
                              ),


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
                                left: 8, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: Color(0xFFfbfbfb),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: 0, bottom: 0, left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        ParagraphText(
                                          text: '${items[index]['title']}',
                                          color: MyColors.blackColor,
                                          fontSize: 12,
                                          fontFamily: 'semibold',
                                        ),
                                        // Image.asset(MyImages.attach, width: 15,),
                                        hSizedBox,
                                        ParagraphText(
                                          text: '${items[index]
                                          ['description']}',
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 9,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          behavior:
                                          HitTestBehavior.opaque,
                                          onTap: () async {
                                            var request = {
                                              "post_id":items[index]['id'].toString(),
                                              "user_id":userId,
                                              "type":'1'
                                            };
                                            var jsonResponse = await Webservices.postData(url: ApiUrls.voteForPost, request: request, context: context, showSuccessMessage: true);
                                            items = [];
                                            getVideos();


                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6),
                                            height: 26,
                                            decoration: BoxDecoration(
                                                color: MyColors.greenColor,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    4)),
                                            child: Center(
                                              child: ParagraphText(
                                                text: translate("community_court_page.allow"),
                                                textAlign: TextAlign.center,
                                                color: MyColors
                                                    .whiteColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      hSizedBox05,
                                      Expanded(
                                        child: GestureDetector(
                                          behavior:
                                          HitTestBehavior.opaque,
                                          onTap: () async {
                                            var request = {
                                              "post_id":items[index]['id'].toString(),
                                              "user_id":userId,
                                              "type":'0'
                                            };
                                            var jsonResponse = await Webservices.postData(url: ApiUrls.voteForPost, request: request, context: context, showSuccessMessage: true);
                                            items = [];
                                            getVideos();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6),
                                            height: 26,
                                            decoration: BoxDecoration(
                                                color: MyColors.redColor,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    4)),
                                            child: Center(
                                              child: ParagraphText(
                                                text: translate("community_court_page.deny"),
                                                textAlign: TextAlign.center,
                                                color: MyColors
                                                    .whiteColor,
                                                fontSize: 12,
                                              ),
                                            ),
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
                  ),
                  if(items[index]['is_reported']==1)
                    Positioned(
                      right: 12,
                      top: 12,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16),
                        height: 26,
                        width: 140,
                        decoration: BoxDecoration(
                            color: MyColors.redColor,
                            borderRadius:
                            BorderRadius.circular(
                                4)),
                        child: Center(child: ParagraphText(text: '${items[index]['is_reported']==1?translate("community_court_page.voted"):translate("community_court_page.giveVote")}',textAlign: TextAlign.center,color: MyColors.whiteColor,)),
                      ),
                    )
                ],
              );
          },
        ),
            ),
      ),
    );
  }
}
