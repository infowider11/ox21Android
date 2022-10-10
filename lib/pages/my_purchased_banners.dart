import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
import 'package:video_thumbnail/video_thumbnail.dart';

import '../constants/colors.dart';
import '../constants/global_functions.dart';
import '../upload_video_view.dart';
import '../widgets/appbar.dart';
import '../widgets/avatar.dart';
import '../widgets/customtextfield.dart';

class MyPurchasedBanners extends StatefulWidget {
  static const String id = "My_videos_page";
  const MyPurchasedBanners({Key? key}) : super(key: key);

  @override
  State<MyPurchasedBanners> createState() => _MyPurchasedBannersState();
}

class _MyPurchasedBannersState extends State<MyPurchasedBanners> {
  bool load = true;
  List myBanners = [];

  String selectedVideoType = 'videos';
  getBanners() async {
    setState(() {
      load = true;
    });
    myBanners =
        await Webservices.getList(ApiUrls.my_banners + 'user_id=$userId');
    setState(() {
      load = false;
    });
  }


  uploadImage({required File file,required Map bannerData})async{
    Navigator.pop(context);
    var request = {
      'user_id': userId,
      'id':bannerData['id'].toString(),
    };
    var files = {
      'image': file
    };
    setState(() {
      load = true;
    });
    var jsonResponse = await Webservices.postDataWithImageFunction(body: request, files: files, context: MyGlobalKeys.navigatorKey.currentContext!, endPoint: ApiUrls.update_banner_image);
    if(jsonResponse['status'] ==1){
      showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'Image Uploaded');
      await getBanners();
    }else{
      showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'Error ${jsonResponse['message']}');
      setState(() {
        load = false;
      });
    }
    // push(context: MyGlobalKeys.navigatorKey.currentContext!, screen: UploadBannerContent());
  }

  @override
  void initState() {
    // TODO: implement initState

    getBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeaedf6),
      appBar: appBar(
        context: context,
        title: 'Your Banners',
        titleColor: MyColors.secondary,
        toolbarHeight: 50,
      ),
      body: load
          ? CustomLoader()
          : RefreshIndicator(
        onRefresh: ()async{
          await getBanners();
        },
            child: Container(
                child: Column(
                  children: [

                    vSizedBox4,
                    if (myBanners.length != 0)
                      Expanded(
                        child: ListView.builder(
                            itemCount: myBanners.length,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                // height:110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                        Border.all(color: MyColors.black54Color)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ParagraphText(
                                          text: 'Page Number',
                                        ),
                                        SubHeadingText(
                                          text: '${myBanners[index]['page_number']}',
                                        ),
                                      ],
                                    ),
                                    vSizedBox05,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ParagraphText(
                                          text: 'Channel',
                                        ),
                                        ParagraphText(
                                          text: '${myBanners[index]['channel_name']}',
                                        ),
                                      ],
                                    ),
                                    vSizedBox05,
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: ParagraphText(
                                            text: 'Language',
                                          ),
                                        ),
                                        ParagraphText(
                                          text: '${myBanners[index]['language_name']}',
                                        ),
                                      ],
                                    ),
                                    vSizedBox05,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        ParagraphText(
                                          text: 'Purchased On',
                                        ),
                                        ParagraphText(
                                          text:
                                              '${DateFormat.yMMMMEEEEd().format(DateTime.parse(myBanners[index]['created_at']))}',
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                    vSizedBox05,

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        ParagraphText(
                                          text: 'Location',
                                        ),
                                        if(myBanners[index]['city']!=null && myBanners[index]['city']!='null')
                                        ParagraphText(
                                          text: '${myBanners[index]['city']}, ${myBanners[index]['state']},${myBanners[index]['country']}',
                                          textAlign: TextAlign.end,
                                        )
                                        else
                                          ParagraphText(text: 'Global')
                                      ],
                                    ),
                                    vSizedBox05,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ParagraphText(
                                          text: 'Banner Content',
                                        ),
                                        hSizedBox,
                                        Expanded(
                                          flex: 5,
                                          child: RoundEdgedButton(
                                            text:myBanners[index]['is_for_sell']==1?'Edit Sale Price' :'Add Sale Price',
                                            horizontalPadding: 6,
                                            verticalPadding: 4,
                                            height: null,
                                            onTap: ()async{
                                              TextEditingController amountController = TextEditingController();
                                              if(myBanners[index]['is_for_sell']==1){
                                                amountController.text = myBanners[index]['sell_price'].toString();
                                              }
                                              showModalBottomSheet(context: context,
                                                  isScrollControlled: true,
                                                  backgroundColor: Colors.transparent,
                                                  builder: (context){
                                                return Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                                  height: 250 + MediaQuery.of(context).viewInsets.bottom,
                                                  decoration: BoxDecoration(
                                                      color: MyColors.whiteColor,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(40),
                                                        topRight: Radius.circular(40),
                                                      )
                                                  ),
                                                  child: Scaffold(
                                                    backgroundColor: MyColors.whiteColor,
                                                    body: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Center(child: SubHeadingText(text: myBanners[index]['is_for_sell']==1?'Edit Resale Price':'Create Resale Price', color: MyColors.primaryColor,)),
                                                        vSizedBox2,
                                                        SubHeadingText(text: 'Resale Price'),
                                                        CustomTextField(controller: amountController, hintText: 'Enter resale price', keyboardType: TextInputType.number,),
                                                        vSizedBox2,
                                                        RoundEdgedButton(
                                                          text: myBanners[index]['is_for_sell']==1?'Edit':'Add',
                                                          onTap: ()async{
                                                            FocusScope.of(context).requestFocus(new FocusNode());
                                                            if(amountController.text==''){

                                                              showSnackbar(context, 'Please type valid price.');
                                                            }else{
                                                              var request = {
                                                                "user_id":userId,
                                                                "id":myBanners[index]['id'].toString(),
                                                                "sell_price":amountController.text
                                                              };

                                                              var response = await Webservices.postData(url: ApiUrls.addResalePrice, request: request, context: context);
                                                              if(response['status']==1){
                                                                Navigator.pop(context);
                                                                getBanners();
                                                                showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, '${response['message']}',);
                                                                await updateSharedPreferenceFromServer();
                                                                setState(() {

                                                                });
                                                              }


                                                            }
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                            },
                                          ),
                                        ),
                                        hSizedBox,
                                        Expanded(
                                          flex: 5,
                                          child: RoundEdgedButton(
                                            // image: MyImages.check,

                                            text: myBanners[index]['image']==null?
                                            // myBanners[index]['upload_status']==2?
                                            // 'Uploading...':
                                            'Upload':'Uploaded',
                                            isSolid:myBanners[index]['image']!=null,
                                            height: null,
                                            color:myBanners[index]['image']!=null? MyColors.green:MyColors.primaryColor,
                                            verticalPadding: 4,
                                            onTap:myBanners[index]['image']!=null?null:myBanners[index]['upload_status']==2?null: ()async{
                                              showModalBottomSheet<void>(
                                                context: context,
                                                backgroundColor: Colors.transparent,
                                                builder: (BuildContext context) {
                                                  return Container(
                                                    height: 220 ,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(24),
                                                        topRight: Radius.circular(24),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                                    child: Scaffold(
                                                      body: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                          vSizedBox,

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              ParagraphText(
                                                                text: 'Upload Banner Image/Video',
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
                                                            onTap:() async {
                                                              print('button poresssed');
                                                              File? image = await pickImage(isGallery: true);
                                                              if (image != null){
                                                                await uploadImage(bannerData: myBanners[index], file: image);
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
                                                                              text: 'Upload a Image',
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
                                                              File? video = await pickVideo(isGallery: true);
                                                              if (video != null){
                                                                await uploadImage(bannerData: myBanners[index], file: video);
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
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    vSizedBox,
                                    // if(myBanners[index]['is_for_rent']==0)
                                    RoundEdgedButton(text:myBanners[index]['is_for_rent']==1?'Open for rent': 'Rent your banner',
                                      onTap:myBanners[index]['is_for_rent']==0? ()async{
                                      var request = {
                                        'user_id': userId,
                                        'id': myBanners[index]['id'].toString()
                                      };
                                      setState(() {
                                        load = true;
                                      });
                                      var jsonResponse = await Webservices.postData(url: ApiUrls.set_banner_for_rent, request: request, context: context, showSuccessMessage: true);
                                      if(jsonResponse['status']==1){
                                        print('jjjj');
                                        await getBanners();
                                      }
                                      setState(() {
                                        load = false;
                                      });

                                    }:null,
                                      horizontalMargin: 20,
                                      verticalPadding: 0,
                                      height: 30,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    else
                      Expanded(
                        child: Center(
                          child: Text('No Banners Found'),
                        ),
                      ),
                    vSizedBox,
                  ],
                ),
              ),
          ),
    );
  }
}
