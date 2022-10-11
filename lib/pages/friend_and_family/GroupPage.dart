import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_functions.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/friend_and_family/group_members_page.dart';
import 'package:ox21/pages/friend_and_family/pending_group_members_page.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_circular_image.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:ox21/widgets/play_video_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../widgets/confirmation_dialog.dart';
import 'package:flutter_translate/flutter_translate.dart';

class GroupPage extends StatefulWidget {
  final Map groupDetail;
  const GroupPage({Key? key, required this.groupDetail}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  TextEditingController messageController = TextEditingController();
  File? file;
  String? fileType;

  List messages = [];
  Timer? chatTimer;
  bool load = false;

  getChatMessages({bool showLoad = false}) async {
    if (showLoad) {
      setState(() {
        load = true;
      });
    }
    var request = {
      'id': widget.groupDetail['id'].toString(),
      'is_chat': '1',
      'user_id': userId,
    };

    messages = (await Webservices.postData(
            url: ApiUrls.getGroupDetail,
            request: request,
            context: context,
            isGetMethod: true))['data']['chat'] ??
        [];

    if (showLoad) {
      load = false;
    }
    try {
      setState(() {});
    } catch (e) {
      print('Error in catch block 6463 $e');
    }
  }

  sendMessage({required String messageType, required dynamic message}) async {
    var request = {
      'user_id': userId,
      'type': messageType,
      'group_id': widget.groupDetail['id'].toString(),
    };
    Map<String, dynamic> files = {};
    if (messageType == 'text') {
      request['message'] = message;
    } else {
      files['message'] = message;
    }
    if (messageType == 'video') {
      Uint8List? uint8list = await VideoThumbnail.thumbnailData(
        video: message.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth:
            400, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        maxHeight: 400,
        quality: 50,
      );
      final tempDir = await getTemporaryDirectory();

      File thumbnail = await File('${tempDir.path}/image.png').create();
      thumbnail.writeAsBytesSync(uint8list!.toList());
      files['thumbnail'] = thumbnail;
    }
    var jsonResponse = await Webservices.postDataWithImageFunction(
        body: request,
        files: files,
        context: context,
        endPoint: ApiUrls.send_message_in_group);
  }

  @override
  void initState() {
    // TODO: implement initState
    getChatMessages(showLoad: true);
    chatTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      getChatMessages();
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    chatTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context: context,
          title: widget.groupDetail['title'],
          titleIcon: CustomCircularImage(
            imageUrl: widget.groupDetail['image'],
            height: 40,
            width: 40,
          ),
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              vSizedBox2,
                              SubHeadingText(
                                text: translate("GroupPage.scan"),
                                color: MyColors.primaryColor,
                              ),
                              vSizedBox,
                              QrImage(
                                data: '${widget.groupDetail['groupID']}',
                                version: QrVersions.auto,
                                size: 300,
                                // embeddedImage: AssetImage(MyImages.bitcoinLogo),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Icon(
                Icons.qr_code,
                color: Colors.black,
              ),
            ),
            // if (widget.groupDetail['owner_id'].toString() == userId)
            // hSizedBox,
            IconButton(
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                      // margin: viewInset,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                          color: MyColors.whiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          vSizedBox,
                          MainHeadingText(
                            text: translate("GroupPage.options"),
                            color: MyColors.primaryColor,
                          ),
                          CustomDivider(),
                          vSizedBox,
                          GestureDetector(
                            child: SubHeadingText(text: translate("group_members_page.members")),
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              push(
                                  context: context,
                                  screen: GroupMembersPage(
                                      groupDetail: widget.groupDetail));
                            },
                          ),
                          if (widget.groupDetail['owner_id'].toString() ==
                              userId)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 100),
                                  child: CustomDivider(),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    print('__________________________');
                                    push(
                                        context: context,
                                        screen: PendingGroupMembers(
                                            groupDetail: widget.groupDetail));
                                  },
                                  child: SubHeadingText(
                                      text:  translate("GroupPage.view")),
                                ),
                              ],
                            ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 100),
                                child: CustomDivider(),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  bool? result = await showCustomConfirmationDialog(
                                      description:
                                      translate("GroupPage.remove"));
                                  print('the confirmation result is $result');
                                  if (result == true) {
                                    var request = {
                                      'group_id':
                                          widget.groupDetail['id'].toString(),
                                      'user_id': userId,
                                    };
                                    setState(() {
                                      load = true;
                                    });
                                    var jsonResponse =
                                        await Webservices.postData(
                                            url: ApiUrls.leave_group,
                                            request: request,
                                            context: context,
                                            isGetMethod: true,
                                            showSuccessMessage: true);
                                    // getMembers(showLoad: true);
                                    Navigator.pop(context);
                                    Navigator.pop(MyGlobalKeys
                                        .navigatorKey.currentContext!);
                                  }
                                },
                                child: SubHeadingText(
                                  text: widget.groupDetail['owner_id']
                                              .toString() ==
                                          userId
                                      ? translate("GroupPage.delete")
                                      : translate("GroupPage.leave"),
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          vSizedBox,
                        ],
                      ),
                    );
                  },
                );
              },
              // padding: Edg,
              icon: Icon(
                Icons.more_vert_sharp,
                color: Colors.black,
              ),
            )
            // else
            //     hSizedBox,
          ]),
      body: load
          ? CustomLoader()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: messages.length == 0
                        ? Center(
                            child: ParagraphText(
                              text: translate("GroupPage.typeMsg"),
                            ),
                          )
                        : ListView.builder(
                            itemCount: messages.length,
                            reverse: true,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: messages[index]['sender'][0]
                                                ['user_id']
                                            .toString() !=
                                        userId
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.end,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width -
                                                160),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (messages[index]['type'] ==
                                                    'text' ||
                                                messages[index]['sender'][0]
                                                            ['user_id']
                                                        .toString() !=
                                                    userId)
                                              SubHeadingText(
                                                text:
                                                    '${messages[index]['sender'][0]['nickname']}:  ',
                                                color: MyColors.primaryColor,
                                              ),
                                            if (messages[index]['type'] ==
                                                'text')
                                              ParagraphText(
                                                text:
                                                    '${messages[index]['message']}',
                                              ),
                                          ],
                                        ),
                                        if (messages[index]['type'] == 'image')
                                          CustomCircularImage(
                                            imageUrl: messages[index]
                                                ['message'],
                                            height: 140,
                                            width: 140,
                                            borderRadius: 20,
                                          ),
                                        if (messages[index]['type'] == 'video')
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: ()async{
                                              push(context: context, screen: PlayVideoPage(url: messages[index]['message']));
                                            },
                                            child: CustomCircularImage(
                                              imageUrl: messages[index]
                                                      ['thumbnail'] ??
                                                  '',
                                              height: 140,
                                              width: 140,
                                              borderRadius: 20,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 6,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      // height: 80,
                      decoration: BoxDecoration(
                        // color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Container(
                                    // margin: viewInset,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                        color: MyColors.whiteColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40),
                                        )),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        vSizedBox,
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () async {
                                            File? temp = await pickImage(
                                                isGallery: true);
                                            if (temp != null) {
                                              Navigator.pop(context);

                                              await sendMessage(
                                                  messageType: 'image',
                                                  message: temp);
                                            }
                                          },
                                          child: SubHeadingText(
                                              text:translate("GroupPage.selectImg")),
                                        ),
                                        CustomDivider(),
                                        vSizedBox,
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () async {
                                            File? temp = await pickVideo(
                                                isGallery: true);
                                            if (temp != null) {
                                              Navigator.pop(context);

                                              await sendMessage(
                                                  messageType: 'video',
                                                  message: temp);
                                            }
                                          },
                                          child: SubHeadingText(
                                              text: translate("GroupPage.uploadVideo")),
                                        ),
                                        vSizedBox,
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.file_upload_sharp,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: CustomTextField(
                              controller: messageController,
                              hintText:  translate("GroupPage.typeHere"),
                              showBorder: true,
                              bgColor: Colors.white,
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                sendMessage(
                                    messageType: translate("GroupPage.text"),
                                    message: messageController.text);
                                messageController.clear();
                              },
                              icon: Icon(Icons.send)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
