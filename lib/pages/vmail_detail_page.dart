import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/forward_vmail.dart';
import 'package:ox21/widgets/play_video_widget.dart';
import 'package:video_player/video_player.dart';

import '../constants/global_constants.dart';
import '../constants/global_keys.dart';
import '../constants/image_urls.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/buttons.dart';
import '../widgets/customLoader.dart';
import '../widgets/custom_circular_image.dart';
import '../widgets/customtextfield.dart';
import '../widgets/send_vmail.dart';
import 'package:flutter_translate/flutter_translate.dart';
class VmailDetailPage extends StatefulWidget {
  final Map vmailData;
  const VmailDetailPage({Key? key, required this.vmailData}) : super(key: key);

  @override
  _VmailDetailPageState createState() => _VmailDetailPageState();
}

class _VmailDetailPageState extends State<VmailDetailPage> {
  VideoPlayerController? _controller;

  bool load = false;
  initializeController(String videoUrl) async {
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {}).onError((error, stackTrace) {
        print('the errorr is $error and strach $stackTrace');
        initializeController(videoUrl);
      });
  }

  @override
  Widget build(BuildContext context) {
    // print('the ${widget.vmailData['attachments']}');
    log(widget.vmailData.toString());
    return Scaffold(
      appBar: appBar(context: context, title: translate("vmail_detail_page.vmail")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MainHeadingText(
                      text: widget.vmailData['subject'],
                    ),
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      hSizedBox,
                      IconButton(onPressed: ()async{
                        List myDomains =
                        await Webservices.getList(ApiUrls.getMyDomains + 'user_id=$userId&status=1');
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return SendVmailBottomSheet(
                              myDomains: myDomains,
                              replyData: widget.vmailData,
                            );
                          },
                        );
                      }, icon: Icon(Icons.reply),),
                      hSizedBox,
                      IconButton(onPressed: ()async{
                        List myDomains =
                        await Webservices.getList(ApiUrls.getMyDomains + 'user_id=$userId&status=1');
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {

                            return ForwardVmailPage(replyData: widget.vmailData,myDomains: myDomains,);
                          },
                        );
                      }, icon: Icon(Icons.forward_to_inbox),),
                      hSizedBox,
                      if(widget.vmailData['sender_id'].toString()!=userId)
                      IconButton(onPressed: ()async{
                        // List myDomains =
                        // await Webservices.getList(ApiUrls.getMyDomains + 'user_id=$userId');
                        log(widget.vmailData.toString());
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
                                      vSizedBox,
                                      SubHeadingText(
                                        text:translate("vmail_detail_page.RUS"),
                                        color: Colors.red,
                                      ),
                                      vSizedBox,
                                      ParagraphText(text: translate("vmail_detail_page.text")),
                                      vSizedBox2,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          RoundEdgedButton(
                                            text: translate("vmail_detail_page.no"),
                                            verticalPadding: 0,
                                            height: 36,
                                            width: 100,
                                            onTap: () {
                                              Navigator.pop(MyGlobalKeys.navigatorKey.currentContext!);
                                            },
                                          ),
                                          hSizedBox,
                                          RoundEdgedButton(
                                            text:translate("vmail_detail_page.yes"),
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

                        if(result==true){
                          var request = {
                            'sender_id': userId,
                            'receiver_id': widget.vmailData['receiver_id'].toString(),
                            'sender_domain': widget.vmailData['sender_domain'][0]['id'].toString(),
                            'receiver_domain': widget.vmailData['receiver_domain'][0]['id'].toString(),

                          };
                          setState(() {
                            load = true;
                          });

                          var jsonResponse = await Webservices.postData(url: ApiUrls.block_domain, request: request, context: context, showSuccessMessage: true, showErrorMessage: true);
                          setState(() {
                            load = false;
                          });

                        }
                      }, icon: Icon(Icons.block, color: Colors.red,),),


                    ],
                  ),
                ],
              ),
              SubHeadingText(
                text:
                    'By ${widget.vmailData['sender_domain'][0]['domain']}',
                color: MyColors.primaryColor,
              ),
              if(widget.vmailData['is_forwarded']!=1)
              ParagraphText(
                text: widget.vmailData['body'],
                fontSize: 16,
              ),
              if(widget.vmailData['is_forwarded']!=1)
              vSizedBox2,
              if(widget.vmailData['attachments'].length!=0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubHeadingText(
                    text:translate("vmail_detail_page.attachments"),
                    color: MyColors.primaryColor,

                  ),
                  vSizedBox,
                  if(widget.vmailData['attachments'].length==0)
                    ParagraphText(text: translate("vmail_detail_page.noAttachments")),
                  Wrap(
                    spacing: 8,
                    runSpacing: 20,
                    children: [
                      for (int i = 0;
                      i < widget.vmailData['attachments'].length;
                      i++)
                        if (widget.vmailData['attachments'][i]['file_type'] ==
                            'Image')
                          CustomCircularImage(
                            imageUrl: widget.vmailData['attachments'][i]['file'],
                            // fileType: CustomFileType.file,
                            // image: images[index],
                            height: 100,
                            width: 100,
                            borderRadius: 18,
                          )
                        else
                          GestureDetector(
                            onTap: () async {
                              bool isPlaying = false;
                              print('111222');
                              String link = MyGlobalConstants.ipfsLink;
                              link = link +
                                  widget.vmailData['attachments'][i]['file_cid'];
                              print('the link is $link');
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayVideoPage(videoUrl:link)));
                              push(context: context, screen: PlayVideoPage(url: link));

                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayVideoPage(videoUrl: selectedVideoType=='videos'? myVideos[index]['video']: shorts[index]['video'])));
                            },
                            child: Stack(
                              children: [
                                CustomCircularImage(
                                  imageUrl:widget.vmailData['attachments'][i]['thumbnail']?? MyImages.upload_video,
                                  fit: BoxFit.fill,
                                  fileType:widget.vmailData['attachments'][i]['thumbnail']==null? CustomFileType.asset:CustomFileType.network,
                                  height: 100,
                                  width: 100,
                                  borderRadius: 18,
                                ),
                                Positioned(
                                  top: 31,
                                  left: 31,
                                  child: Icon(Icons.play_arrow, color: Colors.white,size: 36,),
                                )
                              ],
                            ),
                          ),
                    ],
                  ),
                ],
              ),

              if(widget.vmailData['parent_id']!=0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox4,
                    CustomDivider(),
                    vSizedBox2,
                    MainHeadingText(text:widget.vmailData['is_forwarded']==1?translate("vmail_detail_page.forwarded") :translate("vmail_detail_page.replied")),

                    SubHeadingText(
                      text: widget.vmailData['subject'],
                    ),
                    vSizedBox,
                    SubHeadingText(
                      text:
                      'By ${widget.vmailData['parent']['sender_domain'][0]['domain']}',
                      color: MyColors.primaryColor,
                    ),
                    ParagraphText(
                      text: widget.vmailData['parent']['body'],

                    ),
                    vSizedBox4,
                    if(widget.vmailData['parent']['attachments'].length!=0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SubHeadingText(
                          text: translate("vmail_detail_page.attachments"),
                          color: MyColors.primaryColor,
                        ),
                        vSizedBox2,
                        Wrap(
                          spacing: 8,
                          runSpacing: 20,
                          children: [
                            for (int i = 0;
                            i < widget.vmailData['parent']['attachments'].length;
                            i++)
                              if (widget.vmailData['parent']['attachments'][i]['file_type'] ==
                                  'Image')
                                CustomCircularImage(
                                  imageUrl: widget.vmailData['parent']['attachments'][i]['file'],
                                  // fileType: CustomFileType.file,
                                  // image: images[index],
                                  height: 100,
                                  width: 100,
                                  borderRadius: 18,
                                )
                              else
                                GestureDetector(
                                  onTap: () async {
                                    bool isPlaying = false;
                                    print('111222');
                                    String link = MyGlobalConstants.ipfsLink;
                                    link = link +
                                        widget.vmailData['parent']['attachments'][i]['file_cid'];
                                    print('the link is $link');
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayVideoPage(videoUrl:link)));
                                    await initializeController(link);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                                return Dialog(
                                                  insetPadding: EdgeInsets.symmetric(
                                                      horizontal: 0, vertical: 0),
                                                  backgroundColor: Colors.transparent,
                                                  child: Container(
                                                    // decoration: BoxDecoration(
                                                    //   color: Colors.white,
                                                    //   borderRadius: BorderRadius.circular(15)
                                                    // ),
                                                    height:
                                                    MediaQuery.of(context).size.height -
                                                        0,
                                                    margin:
                                                    EdgeInsets.symmetric(horizontal: 0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal: 0),
                                                              child: InteractiveViewer(
                                                                maxScale: 3,
                                                                minScale: 1,
                                                                child: AspectRatio(
                                                                  aspectRatio: _controller!
                                                                      .value.aspectRatio,
                                                                  // aspectRatio: 1.4,
                                                                  child: VideoPlayer(
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
                                                                child: IconButton(
                                                                  icon: Icon(
                                                                    isPlaying
                                                                        ? Icons.pause
                                                                        : Icons.play_arrow,
                                                                    color: Colors.white,
                                                                    size: 50,
                                                                  ),
                                                                  onPressed: () {
                                                                    !isPlaying
                                                                        ? _controller?.play()
                                                                        : _controller
                                                                        ?.pause();

                                                                    isPlaying = !isPlaying;
                                                                    setState(() {});
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              right: 0,
                                                              top: 0,
                                                              child: Center(
                                                                child: IconButton(
                                                                  icon: Icon(
                                                                    Icons.close,
                                                                    size: 30,
                                                                    color:
                                                                    MyColors.whiteColor,
                                                                  ),
                                                                  onPressed: () {
                                                                    _controller?.dispose();
                                                                    Navigator.pop(context);
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
                                  child: CustomCircularImage(
                                    imageUrl: MyImages.upload_video,
                                    fit: BoxFit.fill,
                                    fileType: CustomFileType.asset,
                                    height: 100,
                                    width: 100,
                                    borderRadius: 18,
                                  ),
                                ),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),vSizedBox2,
            ],
          ),
        ),
      ),
    );
  }
}
