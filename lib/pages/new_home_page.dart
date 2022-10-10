import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ox21/chat.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_functions.dart';
import 'package:ox21/mycoins.dart';
import 'package:ox21/pages/content_creator_page.dart';
import 'package:ox21/pages/upload_page.dart';
import 'package:ox21/pages/video_player_essentials/flick_multi_manager.dart';
import 'package:ox21/pages/video_player_essentials/flick_multi_player.dart';
import 'package:ox21/search.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/upload_video_view.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/avatar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';


class NewHomePage extends StatefulWidget {
  static const String id = "newhome";
  const NewHomePage({Key? key}) : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {

  bool load = false;
  List items = [];
  late FlickMultiManager flickMultiManager;
  
  getVideos()async{

    load = true;
    setState(() {

    });

    items = await Webservices.getList(ApiUrls.getAllPost + 'user_id=$userId');
    flickMultiManager = FlickMultiManager();
    setState(() {
      load = false;
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getVideos();
  }
  VideoPlayerController? _controller;
  initializeController(String videoUrl)async{
    setState(() {
      load = true;
    });
    _controller = VideoPlayerController.network(
       videoUrl
      // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
    )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          load = false;
        });
      }).onError((error, stackTrace){
        print('the errorr is $error and strach $stackTrace');
        initializeController(videoUrl);
      });
  }

  @override
  Widget build(BuildContext context) {
    print('iiii ${items.length}');
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      // backgroundColor: Color(0xFF88E1E5),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          items = await Webservices.getList(ApiUrls.getAllPost + 'user_id=$userId');
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
                          text: 'Create',
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
                      // onTap: () {
                      //   Navigator.pop(context);
                      //   Navigator.pushNamed(context, Upload_Page.id);
                      // },
                      onTap: () async {
                        print('button poresssed');
                        File? video = await pickVideo(isGallery: false);
                        if(video!=null){
                          // Navigator.pop(context);
                          Uint8List? uint8list = await VideoThumbnail.thumbnailData(
                            video: video.path,
                            imageFormat: ImageFormat.JPEG,
                            maxWidth: 400, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
                            maxHeight: 400,
                            quality: 50,
                          );
                          print(uint8list);
                          if(uint8list!=null){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadPageView(video: video,image: uint8list, videoType: 'shorts',)));
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
                                  image: MyImages.short,
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
                                        text: 'Create a Short',
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
                        if(video!=null){
                          // Navigator.pop(context);
                          Uint8List? uint8list = await VideoThumbnail.thumbnailData(
                            video: video.path,
                            imageFormat: ImageFormat.JPEG,
                            maxWidth: 400, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
                            maxHeight: 400,
                            quality: 50,
                          );
                          print(uint8list);
                          if(uint8list!=null){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadPageView(video: video,image: uint8list, videoType: 'videos',)));
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
                                        text: 'Upload a Video',
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
                    // vSizedBox2,
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 3,
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           CircleAvatarcustom(
                    //             image: MyImages.short,
                    //             width: 50,
                    //             height: 50,
                    //             fit: BoxFit.fitWidth,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 12,
                    //       child: Container(
                    //         padding: EdgeInsets.symmetric(
                    //             vertical: 2, horizontal: 0),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 ParagraphText(
                    //                   text: 'Go Live',
                    //                   color: MyColors.heading,
                    //                   fontSize: 12,
                    //                   fontFamily: 'bold',
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SearchPage.id);
              },
              child: Image.asset(
                MyImages.search_circle,
                width: 24,
              )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ChatPage.id);
                },
                child: Image.asset(
                  MyImages.message,
                  width: 24,
                )),
          )
        ],
        backgroundColor: Color(0xFF88E1E5),
      ),
      body:load?CustomLoader():items.length==0?Center(
        child: ParagraphText(text: 'No Videos Found',),
      ): RefreshIndicator(
        onRefresh: ()async{
          getVideos();
        },
        child: VisibilityDetector(
          key: ObjectKey(flickMultiManager),
          onVisibilityChanged: (visibility) {
            if (visibility.visibleFraction == 0 && this.mounted) {
              flickMultiManager.pause();
            }
          },
          child: Container(
            color: Color(0xFFECF6F9),
            padding: EdgeInsets.only(top: 16),
            child: ListView.builder(
              // separatorBuilder: (context, int) => Container(
              //   height: 50,
              // ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      // gestures: <Type, GestureRecognizerFactory>{
                      //   TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
                      //         () => TapGestureRecognizer(),
                      //         (TapGestureRecognizer instance) {
                      //       instance
                      //
                      //         ..onTap = () async{
                      //           print('mani lagne lage he ye raste');
                      //           await initializeController(MyGlobalConstants.ipfsLink + items[index]['video_cid']);
                      //           showDialog(context: context, builder: (context){
                      //             bool isPlaying = false;
                      //             return StatefulBuilder(builder: (context, setState){
                      //               return Dialog(
                      //                 insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      //                 child: Container(
                      //                   child: Stack(
                      //                     children: [
                      //                       Padding(
                      //                         padding: EdgeInsets.symmetric(horizontal: 20),
                      //                         child: InteractiveViewer(
                      //                           maxScale:
                      //                           4,
                      //                           minScale:
                      //                           1,
                      //                           child: AspectRatio(
                      //                             aspectRatio: _controller!.value.aspectRatio,
                      //                             // aspectRatio: 1.4,
                      //                             child: VideoPlayer(_controller!),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       Positioned(
                      //                         left: 0,
                      //                         right: 0,
                      //                         top: 0,
                      //                         bottom: 0,
                      //                         child: Center(
                      //                           child: IconButton(
                      //                             icon: Icon(isPlaying?Icons.pause:Icons.play_arrow, color: Colors.white,size: 50,),
                      //                             onPressed: (){
                      //                               !isPlaying?
                      //                               _controller?.play():_controller?.pause();
                      //
                      //                               isPlaying = !isPlaying;
                      //                               setState(() {
                      //
                      //
                      //                               });
                      //
                      //                             },
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               );
                      //             });
                      //             // return Dialog(
                      //             //   insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      //             //   child: Container(
                      //             //     child: Stack(
                      //             //       children: [
                      //             //         Padding(
                      //             //           padding: EdgeInsets.symmetric(horizontal: 20),
                      //             //           child: InteractiveViewer(
                      //             //             maxScale:
                      //             //             4,
                      //             //             minScale:
                      //             //             1,
                      //             //             child: AspectRatio(
                      //             //               aspectRatio: _controller!.value.aspectRatio,
                      //             //               // aspectRatio: 1.4,
                      //             //               child: VideoPlayer(_controller!),
                      //             //             ),
                      //             //           ),
                      //             //         ),
                      //             //         Positioned(
                      //             //           left: 0,
                      //             //           right: 0,
                      //             //           top: 0,
                      //             //           bottom: 0,
                      //             //           child: Center(
                      //             //             child: IconButton(
                      //             //               icon: Icon(isPlaying?Icons.pause:Icons.play_arrow, color: Colors.white,size: 50,),
                      //             //               onPressed: (){
                      //             //                 !isPlaying?
                      //             //                 _controller?.play():_controller?.pause();
                      //             //
                      //             //                 isPlaying = !isPlaying;
                      //             //                 setState(() {
                      //             //
                      //             //
                      //             //                 });
                      //             //
                      //             //               },
                      //             //             ),
                      //             //           ),
                      //             //         ),
                      //             //       ],
                      //             //     ),
                      //             //   ),
                      //             // );
                      //           });
                      //         };
                      //
                      //     },
                      //   ),
                      // },
                      onDoubleTap: ()async{
                        print('mani lagne lage he ye raste');
                        await initializeController(MyGlobalConstants.ipfsLink + items[index]['video_cid']);
                        showDialog(context: context, builder: (context){
                          bool isPlaying = false;
                          return StatefulBuilder(builder: (context, setState){
                            return Dialog(
                              insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child: Container(
                               height: MediaQuery.of(context).size.height,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: InteractiveViewer(
                                        maxScale:
                                        4,
                                        minScale:
                                        1,
                                        child: AspectRatio(
                                          aspectRatio: _controller!.value.aspectRatio,
                                          // aspectRatio: 1.4,
                                          child: VideoPlayer(_controller!),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(isPlaying?Icons.pause:Icons.play_arrow, color: Colors.white,size: 50,),
                                          onPressed: (){
                                            !isPlaying?
                                            _controller?.play():_controller?.pause();

                                            isPlaying = !isPlaying;
                                            setState(() {


                                            });

                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                          // return Dialog(
                          //   insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          //   child: Container(
                          //     child: Stack(
                          //       children: [
                          //         Padding(
                          //           padding: EdgeInsets.symmetric(horizontal: 20),
                          //           child: InteractiveViewer(
                          //             maxScale:
                          //             4,
                          //             minScale:
                          //             1,
                          //             child: AspectRatio(
                          //               aspectRatio: _controller!.value.aspectRatio,
                          //               // aspectRatio: 1.4,
                          //               child: VideoPlayer(_controller!),
                          //             ),
                          //           ),
                          //         ),
                          //         Positioned(
                          //           left: 0,
                          //           right: 0,
                          //           top: 0,
                          //           bottom: 0,
                          //           child: Center(
                          //             child: IconButton(
                          //               icon: Icon(isPlaying?Icons.pause:Icons.play_arrow, color: Colors.white,size: 50,),
                          //               onPressed: (){
                          //                 !isPlaying?
                          //                 _controller?.play():_controller?.pause();
                          //
                          //                 isPlaying = !isPlaying;
                          //                 setState(() {
                          //
                          //
                          //                 });
                          //
                          //               },
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // );
                        });
                      },
                      child: Container(
                          height: 380,
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: FlickMultiPlayer(

                              url: MyGlobalConstants.ipfsLink +  items[index]['video_cid'],
                              flickMultiManager: flickMultiManager,
                              image: items[index]['thumbnail'],
                            ),
                          )),
                    ),
                    Column(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Expanded(
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           SubHeadingText(text: items[index]['title'], color: Colors.white,fontSize: 18,),
                        //           vSizedBox05,
                        //           ParagraphText(text: items[index]['description'], color: Colors.white,),
                        //         ],
                        //       ),
                        //     ),
                        //     Column(
                        //       mainAxisAlignment: MainAxisAlignment.end,
                        //       children: [
                        //         Icon(Icons.heart_broken, size: 26,color: MyColors.redColor,),
                        //         vSizedBox05,
                        //         Icon(Icons.comment, size: 26,color: MyColors.whiteColor,),
                        //         vSizedBox05,
                        //         Icon(Icons.thumb_down, size: 26,color: MyColors.whiteColor,),
                        //       ],
                        //     )
                        //   ],
                        // ),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 10),
                          padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFfbfbfb),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )

                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex:3,
                                child: Container(
                                  padding: EdgeInsets.only(top: 0, bottom: 0, left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ParagraphText(text: items[index]['title'],
                                        color: MyColors.blackColor, fontSize: 12, fontFamily: 'semibold', ),
                                      // Image.asset(MyImages.attach, width: 15,),
                                      hSizedBox,
                                      ParagraphText(text: items[index]['description'],
                                        color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w300,),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: (){},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        height: 26,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: MyColors.lightblue,
                                            borderRadius: BorderRadius.circular(4)
                                        ),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.asset(MyImages.heartfill, width: 16, fit: BoxFit.fitWidth,),
                                            hSizedBox,
                                            ParagraphText(text: 'Like', color: MyColors.primaryColor, fontSize: 12, )
                                          ],
                                        ),
                                      ),
                                    ),
                                    hSizedBox,
                                    GestureDetector(
                                      onTap: (){},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        height: 26,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: MyColors.lightblue,
                                            borderRadius: BorderRadius.circular(4)
                                        ),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.asset(MyImages.dislikefill, width: 11, fit: BoxFit.fitWidth,),
                                            hSizedBox,
                                            ParagraphText(text: 'Dislike', color: MyColors.primaryColor, fontSize: 12, )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      )
    );
  }
}
