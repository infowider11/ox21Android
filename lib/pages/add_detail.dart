import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/home.dart';
import 'package:ox21/pages/add_description.dart';
import 'package:ox21/pages/add_screenshot.dart';
import 'package:ox21/pages/create_private_channel.dart';
import 'package:ox21/pages/select_audience.dart';
import 'package:ox21/pages/set_visibility.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:ox21/widgets/fully_custom_dropdown.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../tab.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/avatar.dart';
import '../widgets/buttons.dart';
import '../widgets/customLoader.dart';
import 'package:flutter_translate/flutter_translate.dart';

class Add_Detail_Page extends StatefulWidget {
  static const String id = "add_details";
  final File video;
  final Uint8List image;
  final String videoType;
  const Add_Detail_Page(
      {Key? key,
      required this.video,
      required this.image,
      required this.videoType})
      : super(key: key);

  @override
  State<Add_Detail_Page> createState() => _Add_Detail_PageState();
}

class _Add_Detail_PageState extends State<Add_Detail_Page> {
  bool load = false;
  bool dialogLoad = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<File> screenshots = [];
  bool ageRestricted = false;
  bool madeForKids = true;

  String visibility = 'public';
  DateTime postingTime = DateTime.now();
  List playList = [];

  List domains = [];
  String selectedPlayList = '0';
  Map? selectedChannel;
  String? selectedChannel1;

  Map? selectedDomain;
  bool isFreshnessPurchased = false;
  String? selectedChannelImageUrl;
  String freshness = freshnessList[0];
  getPlayListAndDomain() async {
    setState(() {
      load = true;
    });
    playList = await Webservices.getList(ApiUrls.getUserPlaylist + '$userId');
    domains = await Webservices.getList(ApiUrls.getMyDomains + 'user_id=$userId&status=1');
    if(domains.length==1){
      selectedDomain = domains[0];
    }
    setState(() {
      load = false;
    });
  }




  bool hideCreateChannel = false;

  @override
  void initState() {
    // TODO: implement initState
    getPlayListAndDomain();
    print('the channels are $channels');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // selectedChannel = null;
    // print(selectedChannel);
    print(selectedChannelImageUrl);


    return Scaffold(
      appBar: appBar(
          context: context,
          toolbarHeight: 50,
          title:translate("add_detail.title"),
          titleColor: MyColors.secondary,
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RoundEdgedButton(
                  text: translate("add_detail.next"),
                  textColor: MyColors.whiteColor,
                  color: MyColors.secondary,
                  width: 65,
                  fontSize: 14,
                  fontfamily: 'regular',
                  height: 40,
                  verticalPadding: 0,
                  horizontalPadding: 0,
                  borderRadius: 5,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if (titleController.text == '') {
                      showSnackbar(context, translate("add_detail.alertTitle"));
                    } else if (descriptionController.text == '') {
                      showSnackbar(context, translate("add_detail.alertDes"));
                    } else if (screenshots.length == 0) {
                      showSnackbar(context, translate("add_detail.alertSs"));
                    } else if (selectedPlayList == '0') {
                      showSnackbar(context, translate("add_detail.alertPlaylist"));
                    }else if(selectedDomain==null && domains.length!=0){
                      showSnackbar(context, translate("add_detail.alertDomain"));
                    } else if (selectedChannel1 == null) {
                      showSnackbar(context, translate("add_detail.alertChanel"));
                    }else if(userData!['points']<1000 && isFreshnessPurchased == true){
                      print(userData!['points']);
                      showSnackbar(context, translate("add_detail.alertPoints"));

                    } else {
                      List? data = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Select_Audience(
                                    ageRestricted: ageRestricted,
                                    madeForKids: madeForKids,
                                  )));

                      print('kldhklfasnklfjklsjfkljafas $data');
                      if (data != null) {
                        madeForKids = data[0];
                        ageRestricted = data[1];
                        setState(() {});
                        var request = {
                          "title": titleController.text,
                          "visibility": visibility,
                          "time": postingTime.toString(),
                          "description": descriptionController.text,
                          "playlist": selectedPlayList,
                          "video_type": widget.videoType,
                          "madeForKids": madeForKids ? '1' : '0',
                          "ageRestricted": ageRestricted ? '1' : '0',
                          "user_id": userId,
                          "channel_id": selectedChannel1,
                          // "ageRestricted": "hello",
                        };

                        if(selectedDomain!=null){
                          request['domain_id'] = selectedDomain!['id'].toString();
                        }
                        print('qqqqwerty00.00');
                        print(request);

                        if(isFreshnessPurchased){
                          request['use_points'] = freshness;
                        }

                        Map<String, dynamic> files = {};

                        // File thumbnail = File.fromRawPath(widget.image);
                        // File thumbnail = await File.;
                        // files['thumbnail'] = thumbnail.path;
                        files['thumbnail'] = screenshots[0];

                        // for(int i = 0;i<screenshots.length;i++){
                        //   files['screenshots[$i]'] = screenshots[i];
                        //   // files['screenshots'] = screenshots;
                        // }
                        // files['screenshots'] = screenshots[0];
                        files['video'] = widget.video;

                        log(files.toString());
                        print(request);
                        setState(() {
                          load = true;
                        });
                        // var response = await Webservices.postDataWithImageFunction(body: request, files: files, context: context, endPoint: ApiUrls.addUserVideos);
                        var response = Webservices.sampleFunction(
                            body: request,
                            files: files,
                            context: context,
                            endPoint: ApiUrls.addUserVideos,
                            screenshots: screenshots);
                        Timer.periodic(Duration(seconds: 25), (timer) {
                          Webservices.getData(
                                  ApiUrls.checkLastPostStatus + '${userId}')
                              .then((value) {
                            if (value.statusCode == 200) {
                              var jsonResponse = jsonDecode(value.body);
                              if (jsonResponse['status'] == 1 ||
                                  jsonResponse['status'] == 0 ||
                                  jsonResponse['status'] == '1' ||
                                  jsonResponse['status'] == 0) {
                                if (jsonResponse['status'] == 1 ||
                                    jsonResponse['status'] == '1')
                                  print(jsonResponse);
                                print('____________UPLOADED_____________');
                                print('cancelling timer');
                                timer.cancel();
                                try {
                                  showSnackbar(
                                      MyGlobalKeys.navigatorKey.currentContext!,
                                      jsonResponse['message']);
                                  // showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'Your Video - ${titleController.text} has been uploaded successfully');
                                } catch (e) {
                                  print('Error in catche block 232 $e');
                                }
                              } else {
                                print(jsonResponse);
                              }
                              print('the print statement is');
                              print(jsonResponse);
                            } else {
                              print(value.statusCode);
                            }
                          });
                        });
                        showSnackbar(context,
                            translate("add_detail.UnderProcess"));
                            // 'Your Video uploading is under progress and will be uploaded soon');
                        Navigator.popUntil(context, (route) => route.isFirst);
                        try {
                          Navigator.pushReplacement(
                              MyGlobalKeys.navigatorKey.currentContext!,
                              MaterialPageRoute(
                                  builder: (context) => MyStatefulWidget()));
                        } catch (e) {
                          print('Error in catch block 433 $e');
                        }
                        // type '_InternalLinkedHashMap<String, dynamic>' is not a subtype of type 'String'
                        // [log] {"status":0,"message":{}}

                        print('the responseeee is ');
                        print(response);
                      }
                    }
                  },
                ),
              ],
            ),
            hSizedBox,
          ]),
      body: load
          ? CustomLoader()
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.memory(
                      widget.image,
                      width: MediaQuery.of(context).size.width,
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                    // Container(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         flex: 2,
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             CircleAvatarcustom(
                    //               image: MyImages.user_avatar,
                    //               width: 30,
                    //               height: 30,
                    //               fit: BoxFit.fitWidth,
                    //               // borderradius: 30,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Expanded(
                    //         flex: 12,
                    //         child: Container(
                    //           padding: EdgeInsets.symmetric(
                    //               vertical: 2, horizontal: 0),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   ParagraphText(
                    //                     text: 'Alex',
                    //                     color: MyColors.heading,
                    //                     fontSize: 12,
                    //                     fontFamily: 'bold',
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Divider(
                    //   height: 2,
                    //   thickness: 2,
                    //   color: MyColors.greyColor,
                    // ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: TextFormField(
                        controller: titleController,
                        // initialValue: 'Create a Title',
                        maxLength: 150,
                        decoration: InputDecoration(
                          labelText:translate("add_detail.title1"),
                          hintText: translate("add_detail.enterTitle"),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 2,
                      thickness: 2,
                      color: MyColors.greyColor,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          // Navigator.pushNamed(context, Add_Description_Page.id);
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Add_Description_Page(
                                        descriptionController:
                                            descriptionController,
                                      )));
                          // if(text!=null){
                          //   descriptionController.text = text;
                          // }
                          print(
                              'the description is ${descriptionController.text}');
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(top: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatarcustom(
                                      image: MyImages.desk,
                                      width: 15,
                                      height: 15,
                                      fit: BoxFit.contain,
                                      borderradius: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 2, bottom: 2, left: 10, right: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ParagraphText(
                                                  text: descriptionController
                                                              .text ==
                                                          ''
                                                      ? translate("add_detail.title")
                                                      : translate("add_detail.enterDes"),
                                                  color: MyColors.heading,
                                                  fontSize: 14,
                                                  fontFamily: 'regular',
                                                ),
                                                if (descriptionController
                                                        .text !=
                                                    '')
                                                  ParagraphText(
                                                      text:
                                                          descriptionController
                                                              .text)
                                                // if(descriptionController.text)
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 15,
                                              color: MyColors.blackColor
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          // Navigator.pushNamed(context, Set_visibility_Page.id);
                          List? data = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Set_visibility_Page(
                                        postingTime: postingTime,
                                        visibility: visibility,
                                      )));
                          if (data != null) {
                            postingTime = data[0];
                            visibility = data[1];
                          }
                          setState(() {});

                          print('the posting time is $postingTime');
                          print('the posting time is $visibility');
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatarcustom(
                                    image: MyImages.globe,
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.fitWidth,
                                    borderradius: 0,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 2, bottom: 2, left: 10, right: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ParagraphText(
                                                text: translate("add_detail.visibility"),
                                                color: MyColors.blackColor
                                                    .withOpacity(0.5),
                                                fontSize: 10,
                                                fontFamily: 'light',
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              ParagraphText(
                                                text: '$visibility',
                                                color: MyColors.heading,
                                                fontSize: 14,
                                                fontFamily: 'regular',
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 15,
                                            color: MyColors.blackColor
                                                .withOpacity(0.5),
                                          ),
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          // Navigator.pushNamed(context, Add_Screenshot_page.id);
                          List<File>? data = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Add_Screenshot_page(
                                        screenshots: screenshots,
                                      )));
                          if (data != null) {
                            screenshots = data;
                          }
                          setState(() {});
                          print('the screenshots are $screenshots');
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatarcustom(
                                    image: MyImages.screenshot,
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.fitWidth,
                                    borderradius: 0,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 2, bottom: 2, left: 10, right: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ParagraphText(
                                                text: translate("add_detail.addSs"),
                                                color: MyColors.heading,
                                                fontSize: 14,
                                                fontFamily: 'regular',
                                              ),
                                              if (screenshots.length != 0)
                                                ParagraphText(text: translate("add_detail.added")),
                                            ],
                                          ),
                                          Icon(
                                            Icons.add_outlined,
                                            size: 20,
                                            color: MyColors.blackColor
                                                .withOpacity(0.5),
                                          ),
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatarcustom(
                                  image: MyImages.add_playlist,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.fitWidth,
                                  borderradius: 0,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 12,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 2, bottom: 2, left: 10, right: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            // bool show = false;
                                            return StatefulBuilder(
                                              builder: (BuildContext context,
                                                  setState /*You can rename this!*/) {
                                                return dialogLoad
                                                    ? CustomLoader()
                                                    : Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                // horizontal: 16,
                                                                vertical: 32),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  SubHeadingText(
                                                                      text:
                                                                      translate("add_detail.addPlaylist")),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        // Navigator.pushNamed(context, Select_Audience.id);
                                                                        TextEditingController
                                                                            playListNameController =
                                                                            TextEditingController();
                                                                        await showModalBottomSheet(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Scaffold(
                                                                                resizeToAvoidBottomInset: false,
                                                                                body: Container(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      SubHeadingText(text: translate("add_detail.createPlaylist")),
                                                                                      vSizedBox2,
                                                                                      CustomTextField(controller: playListNameController, hintText: translate("add_detail.enterPlaylist")),
                                                                                      vSizedBox2,
                                                                                      RoundEdgedButton(
                                                                                        text: translate("add_detail.create"),
                                                                                        textColor: Colors.white,
                                                                                        color: MyColors.primaryColor,
                                                                                        onTap: () async {
                                                                                          if (playListNameController.text == '') {
                                                                                            showSnackbar(context, translate("add_detail.enterName"));
                                                                                          } else {
                                                                                            Navigator.pop(context);
                                                                                            var request = {
                                                                                              "user_id": userId,
                                                                                              "name": playListNameController.text
                                                                                            };
                                                                                            setState(() {
                                                                                              dialogLoad = true;
                                                                                            });
                                                                                            await Webservices.postData(url: ApiUrls.addPlaylist, request: request, context: context);
                                                                                            await getPlayListAndDomain();
                                                                                            setState(() {
                                                                                              dialogLoad = false;
                                                                                            });
                                                                                          }
                                                                                        },
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            });
                                                                        setState(
                                                                            () {});
                                                                        // Navigator.pop(context);
                                                                      },
                                                                      child:
                                                                          ParagraphText(
                                                                        text:
                                                                        translate("my_purchased_banners.add1"),
                                                                        color: MyColors
                                                                            .secondary,
                                                                        fontSize:
                                                                            16,
                                                                        fontFamily:
                                                                            'semibold',
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                            CustomDivider(),
                                                            vSizedBox,
                                                            if (playList
                                                                    .length ==
                                                                0)
                                                              Center(
                                                                  child: Column(
                                                                children: [
                                                                  ParagraphText(
                                                                      text:
                                                                          translate("add_detail.noPlayList")),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      TextEditingController
                                                                          playListNameController =
                                                                          TextEditingController();
                                                                      await showModalBottomSheet(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return Scaffold(
                                                                              resizeToAvoidBottomInset: false,
                                                                              body: Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    SubHeadingText(text:translate("add_detail.createPlaylist")),
                                                                                    vSizedBox2,
                                                                                    CustomTextField(controller: playListNameController, hintText: 'Enter playlist name'),
                                                                                    vSizedBox2,
                                                                                    RoundEdgedButton(
                                                                                      text: translate("add_detail.create"),
                                                                                      textColor: Colors.white,
                                                                                      color: MyColors.primaryColor,
                                                                                      onTap: () async {
                                                                                        if (playListNameController.text == '') {
                                                                                          showSnackbar(context, translate("add_detail.enterName"));
                                                                                        } else {
                                                                                          Navigator.pop(context);
                                                                                          var request = {
                                                                                            "user_id": userId,
                                                                                            "name": playListNameController.text
                                                                                          };
                                                                                          setState(() {
                                                                                            dialogLoad = true;
                                                                                          });
                                                                                          await Webservices.postData(url: ApiUrls.addPlaylist, request: request, context: context);
                                                                                          await getPlayListAndDomain();
                                                                                          setState(() {
                                                                                            dialogLoad = false;
                                                                                          });
                                                                                        }
                                                                                      },
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          });
                                                                    },
                                                                    child:
                                                                        ParagraphText(
                                                                      text:
                                                                      translate("add_detail.createNewPlaylist"),
                                                                      color: MyColors
                                                                          .primaryColor,
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                            for (int i = 0;
                                                                i <
                                                                    playList
                                                                        .length;
                                                                i++)
                                                              GestureDetector(
                                                                behavior:
                                                                    HitTestBehavior
                                                                        .translucent,
                                                                onTap: () {
                                                                  print(
                                                                      'button pressed');
                                                                  selectedPlayList =
                                                                      playList[i]
                                                                              [
                                                                              'id']
                                                                          .toString();
                                                                  print(
                                                                      selectedPlayList);
                                                                  setState(
                                                                      () {});
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  // margin:
                                                                  //     const EdgeInsets
                                                                  //             .symmetric(
                                                                  //         vertical:
                                                                  //             8),
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          16,
                                                                      horizontal:
                                                                          16),
                                                                  color: selectedPlayList ==
                                                                          playList[i]['id']
                                                                              .toString()
                                                                      ? MyColors
                                                                          .primaryColor
                                                                      : null,
                                                                  child:
                                                                      ParagraphText(
                                                                    text:
                                                                        '${playList[i]['name']}',
                                                                    color: selectedPlayList ==
                                                                            playList[i]['id']
                                                                                .toString()
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      );
                                              },
                                            );
                                          });
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ParagraphText(
                                                text: translate("add_detail.addPlaylist"),
                                                color: MyColors.heading,
                                                fontSize: 14,
                                                fontFamily: 'regular',
                                              ),
                                              if (selectedPlayList != '0')
                                                ParagraphText(
                                                    text: translate("add_detail.playlistAdded"))
                                            ],
                                          ),
                                          Icon(
                                            Icons.add_outlined,
                                            size: 20,
                                            color: MyColors.blackColor
                                                .withOpacity(0.5),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
                    // Container(
                    //   padding:
                    //   EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         flex: 1,
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             CircleAvatarcustom(
                    //               image: MyImages.add_playlist,
                    //               width: 20,
                    //               height: 20,
                    //               fit: BoxFit.fitWidth,
                    //               borderradius: 0,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Expanded(
                    //         flex: 12,
                    //         child: Container(
                    //           padding: EdgeInsets.only(
                    //               top: 2, bottom: 2, left: 10, right: 0),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               GestureDetector(
                    //                 behavior: HitTestBehavior.translucent,
                    //                 onTap: () {
                    //                   FocusScope.of(context)
                    //                       .requestFocus(new FocusNode());
                    //                   showModalBottomSheet(
                    //                       context: context,
                    //                       builder: (context) {
                    //                         // bool show = false;
                    //                         return StatefulBuilder(
                    //                           builder: (BuildContext context,
                    //                               setState /*You can rename this!*/) {
                    //                             return dialogLoad?CustomLoader():Container(
                    //                               padding: EdgeInsets.symmetric(
                    //                                 // horizontal: 16,
                    //                                   vertical: 32),
                    //                               child: Column(
                    //                                 crossAxisAlignment:
                    //                                 CrossAxisAlignment
                    //                                     .start,
                    //                                 children: [
                    //                                   Padding(
                    //                                     padding:
                    //                                     const EdgeInsets
                    //                                         .symmetric(
                    //                                         horizontal: 16),
                    //                                     child: Row(
                    //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                                       children: [
                    //                                         SubHeadingText(
                    //                                             text:
                    //                                             'Select Channel'),
                    //                                         // TextButton(
                    //                                         //     onPressed: ()async {
                    //                                         //       // Navigator.pushNamed(context, Select_Audience.id);
                    //                                         //       TextEditingController
                    //                                         //       playListNameController =
                    //                                         //       TextEditingController();
                    //                                         //       await showModalBottomSheet(
                    //                                         //           context:
                    //                                         //           context,
                    //                                         //           builder:
                    //                                         //               (context) {
                    //                                         //             return Scaffold(
                    //                                         //               resizeToAvoidBottomInset: false,
                    //                                         //               body: Container(
                    //                                         //                 padding: EdgeInsets.symmetric(
                    //                                         //                     horizontal:
                    //                                         //                     16,
                    //                                         //                     vertical:
                    //                                         //                     32),
                    //                                         //                 child:
                    //                                         //                 Column(
                    //                                         //                   mainAxisSize:
                    //                                         //                   MainAxisSize.min,
                    //                                         //                   crossAxisAlignment:
                    //                                         //                   CrossAxisAlignment.start,
                    //                                         //                   children: [
                    //                                         //                     SubHeadingText(text: 'Create a Playlist'),
                    //                                         //                     vSizedBox2,
                    //                                         //                     CustomTextField(
                    //                                         //                         controller: playListNameController,
                    //                                         //                         hintText: 'Enter playlist name'),
                    //                                         //                     vSizedBox2,
                    //                                         //                     RoundEdgedButton(
                    //                                         //                       text: 'Create',
                    //                                         //                       textColor: Colors.white,
                    //                                         //                       color: MyColors.primaryColor,
                    //                                         //                       onTap: () async{
                    //                                         //                         if(playListNameController.text==''){
                    //                                         //                           showSnackbar(context, 'Please enter the name of playlist');
                    //                                         //                         }else{
                    //                                         //                           Navigator.pop(context);
                    //                                         //                           var request = {
                    //                                         //                             "user_id": userId,
                    //                                         //                             "name": playListNameController.text
                    //                                         //                           };
                    //                                         //                           setState((){
                    //                                         //                             dialogLoad = true;
                    //                                         //                           });
                    //                                         //                           await Webservices.postData(url: ApiUrls.addPlaylist, request: request, context: context);
                    //                                         //                           await getPlayList();
                    //                                         //                           setState((){
                    //                                         //                             dialogLoad = false;
                    //                                         //                           });
                    //                                         //                         }
                    //                                         //                       },
                    //                                         //                     )
                    //                                         //                   ],
                    //                                         //                 ),
                    //                                         //               ),
                    //                                         //             );
                    //                                         //           });
                    //                                         //       setState((){});
                    //                                         //       // Navigator.pop(context);
                    //                                         //     },
                    //                                         //     child: ParagraphText(
                    //                                         //       text: 'Add',
                    //                                         //       color: MyColors.secondary,
                    //                                         //       fontSize: 16,
                    //                                         //       fontFamily: 'semibold',
                    //                                         //     ))
                    //                                       ],
                    //                                     ),
                    //                                   ),
                    //                                   CustomDivider(),
                    //                                   vSizedBox,
                    //                                   if (channels.length == 0)
                    //                                     Center(
                    //                                         child: Column(
                    //                                           children: [
                    //                                             ParagraphText(
                    //                                                 text:
                    //                                                 'No Channel Found'),
                    //                                           ],
                    //                                         )),
                    //                                   for (int i = 0;
                    //                                   i < channels.length;
                    //                                   i++)
                    //                                     GestureDetector(
                    //                                       behavior: HitTestBehavior.translucent,
                    //                                       onTap: () {
                    //                                         print(
                    //                                             'button pressed');
                    //                                         selectedChannel =
                    //                                             channels[i]
                    //                                             ['id']
                    //                                                 .toString();
                    //                                         print(
                    //                                             selectedPlayList);
                    //                                         setState(() {});
                    //                                         Navigator.pop(
                    //                                             context);
                    //                                       },
                    //                                       child: Container(
                    //                                         width:
                    //                                         MediaQuery.of(
                    //                                             context)
                    //                                             .size
                    //                                             .width,
                    //                                         // margin:
                    //                                         //     const EdgeInsets
                    //                                         //             .symmetric(
                    //                                         //         vertical:
                    //                                         //             8),
                    //                                         padding:
                    //                                         const EdgeInsets
                    //                                             .symmetric(
                    //                                             vertical:
                    //                                             16,
                    //                                             horizontal:
                    //                                             16),
                    //                                         color: selectedPlayList ==
                    //                                             playList[i][
                    //                                             'id']
                    //                                                 .toString()
                    //                                             ? MyColors
                    //                                             .primaryColor
                    //                                             : null,
                    //                                         child:
                    //                                         ParagraphText(
                    //                                           text:
                    //                                           '${playList[i]['name']}',
                    //                                           color: selectedPlayList ==
                    //                                               playList[i]
                    //                                               [
                    //                                               'id']
                    //                                                   .toString()
                    //                                               ? Colors.white
                    //                                               : Colors
                    //                                               .black,
                    //                                         ),
                    //                                       ),
                    //                                     ),
                    //                                 ],
                    //                               ),
                    //                             );
                    //                           },
                    //                         );
                    //                       });
                    //                 },
                    //                 child: Row(
                    //                     mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Column(
                    //                         crossAxisAlignment: CrossAxisAlignment.start,
                    //                         children: [
                    //                           ParagraphText(
                    //                             text: 'Select Channel',
                    //                             color: MyColors.heading,
                    //                             fontSize: 14,
                    //                             fontFamily: 'regular',
                    //                           ),
                    //                           if(selectedPlayList!='0')
                    //                             ParagraphText(text: 'Playlist added')
                    //                         ],
                    //                       ),
                    //                       Icon(
                    //                         Icons.add_outlined,
                    //                         size: 20,
                    //                         color: MyColors.blackColor
                    //                             .withOpacity(0.5),
                    //                       ),
                    //                     ]),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    if(domains.length!=0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                            CircleAvatarcustom(
                              image: MyImages.add_playlist,
                              width: 20,
                              height: 20,
                              fit: BoxFit.fitWidth,
                              borderradius: 0,
                            ),
                          Expanded(
                            child: domains.length==1?Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                '${domains[0]['domain']}(${translate("add_detail.domainName")})'
                              )
                            ): CustomDropDown(
                              onChanged: (value) {
                                selectedDomain = value;
                                setState(() {});
                              },
                              hint: translate("add_detail.selectDomain"),
                              selectedItem: selectedChannel,
                              items: List.generate(
                                domains.length,
                                    (index) => DropdownMenuItem(
                                  value: domains[index],
                                  child: Text(
                                    domains[index]['domain'],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DropdownSearch<dynamic>(

                        onChanged: (dynamic value){
                          selectedChannel1 = value['id'].toString();
                          selectedChannelImageUrl = value['image'];
                          // print(selectedChannel);
                          setState(() {});
                        },
                       dropdownBuilder: (context,dynamic m){

                         print('drowpdown builder---'+m.toString());
                         if(m!=null){
                           return Row(
                             children: [
                                 hSizedBox05,
                                 Container(
                                   height: 20,
                                   width: 20,
                                   decoration: BoxDecoration(
                                       image: DecorationImage(
                                         image: NetworkImage(
                                           selectedChannelImageUrl!,
                                         ),
                                         fit: BoxFit.fitHeight,
                                       )),
                                 ),
                               hSizedBox2,
                               Text(m['name']),
                             ],
                           );
                         }
                         else{
                           return Row(
                             children:[
                               hSizedBox05,
                           CircleAvatarcustom(
                             image: MyImages.add_playlist,
                             width: 20,
                             height: 20,
                             fit: BoxFit.fitWidth,
                             borderradius: 0)
                           ,
                               hSizedBox2,
                               Text(translate("add_detail.selectChannel")),
                             ],
                           );
                         }

                       },

                        items: channels,

                        dropdownDecoratorProps: DropDownDecoratorProps(

                          dropdownSearchDecoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            border: InputBorder.none,
                            labelText: "",
                            hintText:translate("add_detail.selectChannel"),
                          ),
                        ),
                        popupProps: PopupProps.bottomSheet(
                          
                          title: Center(child: Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 5),
                            child: Text(translate("add_detail.selectChannel"), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          )),
                          // itemBuilder: channels,
                          itemBuilder: (context,dynamic m, isSelected){
                            return Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                child: Row(
                                  children:
                                  [

                                  Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          m['image'],
                                        ),
                                        fit: BoxFit.fitHeight,
                                      )),
                                ),
                                  hSizedBox,  Text(m['name']),
                                  ],
                                )
                            );
                          },
                          //   title: Text("mizan"),
                            showSearchBox: true,
                            bottomSheetProps: BottomSheetProps(
                                elevation: 16,

                                backgroundColor: Colors.white
                            )),
                      ),

                    // DropdownSearch<String>(
                    //   popupProps: PopupProps.menu(
                    //     showSelectedItems: true,
                    //     disabledItemFn: (String s) => s.startsWith('I'),
                    //   ),
                    //   items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                    //   // dropdownSearchDecoration: InputDecoration(
                    //   //   labelText: "Menu mode",
                    //   //   hintText: "country in menu mode",
                    //   // ),
                    //   onChanged: print,
                    //   selectedItem: "Brazil",
                    // ),
                    ///hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee

                    if(!hideCreateChannel)
                    Center(
                      child: ParagraphText(
                        text: translate("add_detail.or"),
                      ),
                    ),
                    if(!hideCreateChannel)
                    vSizedBox2,
                    if(!hideCreateChannel)
                    RoundEdgedButton(
                      text:translate("add_detail.createPrivateChannel"),
                      horizontalMargin: 120,
                      height: null,
                      verticalPadding: 10,
                      onTap: ()async{
                        print(channels);
                        String? name = await push(context: context, screen: CreatePrivateChannel());
                        if(name!=null){
                          channels = await Webservices.getList(ApiUrls.getChannels);
                          channels.forEach((element) {
                            if(element['name']==name){
                              print('the channel name existsss');
                              print(selectedChannel1);
                              print('the channel1');
                              print(selectedChannel);
                              print('the channel1');
                             selectedChannel = element;
                              selectedChannelImageUrl = element['image'];
                             selectedChannel1 = element['id'].toString();
                             hideCreateChannel = true;
                            }
                          });
                          setState(() {

                          });
                        }

                      },
                    ),
                    vSizedBox2,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [

                              CircleAvatarcustom(
                                image: MyImages.add_playlist,
                                height: 20,
                                width: 20,
                               fit: BoxFit.fitWidth,
                                borderradius: 0,
                              ),

                            Expanded(
                              child: CustomDropDown(
                                onChanged: (value) {
                                  freshness = value;
                                  if(freshness!=freshnessList[0]){
                                    isFreshnessPurchased = true;
                                  }else{
                                    isFreshnessPurchased = false;
                                  }
                                  setState(() {});
                                },
                                hint: translate("add_detail.buy"),
                                selectedItem: freshness,
                                items: List.generate(
                                  freshnessList.length,
                                      (index) => DropdownMenuItem(
                                    value: freshnessList[index],
                                    child: Text(
                                      freshnessList[index]=='0'?translate("add_detail.noFreshness"):freshnessList[index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // child: Row(
                      //   children: [
                      //     Checkbox(
                      //       visualDensity:
                      //       VisualDensity(horizontal: -4, vertical: 0),
                      //       materialTapTargetSize:
                      //       MaterialTapTargetSize.shrinkWrap,
                      //       checkColor: Colors.white,
                      //       fillColor:
                      //       MaterialStateProperty.all(MyColors.primaryColor),
                      //       value: isFreshnessPurchased,
                      //       onChanged: (bool? value) {
                      //         setState(() {
                      //           isFreshnessPurchased = value!;
                      //         });
                      //       },
                      //     ),
                      //     hSizedBox,
                      //     Expanded(
                      //       child: Padding(
                      //         padding: EdgeInsets.symmetric(
                      //             vertical: 0, horizontal: 8),
                      //         child: RichText(
                      //           text: TextSpan(
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.w400,
                      //                 fontSize: 13,
                      //
                      //                 letterSpacing: 0,
                      //               ),
                      //               children: [
                      //                 TextSpan(
                      //                     text:
                      //                     "Buy Freshness For Post"),
                      //               ]),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),


                  ],
                ),
              ),
            ),
    );
  }
}
