import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/pages/add_detail.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_translate/flutter_translate.dart';

class UploadPageView extends StatefulWidget {
  static const String id = "upload_img_view";
  final File video;
  final Uint8List image;
  final String videoType;
  const UploadPageView({
    Key? key,
    required this.video,
    required this.image,
    required this.videoType
  }) : super(key: key);

  @override
  State<UploadPageView> createState() => _UploadPageViewState();
}

class _UploadPageViewState extends State<UploadPageView> {

  VideoPlayerController? _controller;
  bool isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.file(
        widget.video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, toolbarHeight: 50, actions: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RoundEdgedButton(
                text:translate("walletpage.next"),
                textColor: MyColors.whiteColor,
                color: MyColors.secondary,
                width: 65,
                fontSize: 14,
                fontfamily: 'regular',
                height: 40,
                verticalPadding: 0,
                horizontalPadding: 0,
                borderRadius: 5,
                onTap: ()async {
                  // Navigator.pushNamed(context, Add_Detail_Page.id);
                  _controller!.pause();
                  isPlaying = false;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Add_Detail_Page(
                              video: widget.video, image: widget.image, videoType: widget.videoType,)));
                },
              ),
            ],
          ),
        ),
        hSizedBox,
      ]),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _controller!=null
                ? Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 45),
                      child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              // aspectRatio: 1.4,
              child: VideoPlayer(_controller!),
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
                    )
                  ],
                )
                : Container(),
            // GestureDetector(
            //   onTap: (){
            //     _controller?.play();
            //     // _controller.pause();
            //   },
            //   child: Image.memory(
            //     widget.image,
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height - 600,
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
