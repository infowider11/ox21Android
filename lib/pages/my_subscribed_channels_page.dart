import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/create_private_channel.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';

import '../constants/global_functions.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/customLoader.dart';
import 'package:flutter_translate/flutter_translate.dart';
class MySubscribedChannels extends StatefulWidget {
  static const id = 'my_subscribed_channels_page';
  const MySubscribedChannels({Key? key}) : super(key: key);

  @override
  _MySubscribedChannelsState createState() => _MySubscribedChannelsState();
}

class _MySubscribedChannelsState extends State<MySubscribedChannels> {
  int counter = 0;
  bool lengthisZero = false;

  bool load = false;
  // String? selectedChannel;
  List<Map> selectedChannels = [];
  List<Map> tempChannels = [];
  TextEditingController searchController = TextEditingController();

  List mySubscribedChannels = [];
  getChannels() async {
    setState(() {
      load = true;
    });
    mySubscribedChannels =
        await Webservices.getList(ApiUrls.getChannels + '?user_id=$userId');
    tempChannels = [];
    mySubscribedChannels.forEach((element) {
      tempChannels.add(element);
      if (element['is_subscribed'] == 1) {
        selectedChannels.add(element);
      }
    });

    // counter = channels.length;
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getChannels();
    super.initState();
  }

  // TextEditingController searchController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: load
          ? null
          : appBar(
              context: context,
              title: translate("my_subscribed_channels_page.title"),
              titleColor: MyColors.primaryColor),
      body: load
          ? CustomLoader()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // vSizedBox2,
                        Row(
                          children: [
                            MainHeadingText(text: translate("my_subscribed_channels_page.title")),
                          ],
                        ),
                        vSizedBox2,
                        RoundEdgedButton(text:translate("my_subscribed_channels_page.createPrivate"), onTap: ()async{
                          await push(context: context, screen: CreatePrivateChannel(),);
                          getChannels();
                        },horizontalMargin: 40,),
                        vSizedBox2,
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFieldlabel(
                                labeltext: translate("my_subscribed_channels_page.search"),
                                controller: searchController,
                                hintText: translate("my_subscribed_channels_page.search"),
                                left: 16,
                                fontsize: 12,
                                hintcolor: MyColors.inputbordercolor,
                                // suffixIcon: MyImages.voicesearch,
                                bgColor: Color(0xFFF2F2F2),
                                border: Border.all(color: MyColors.strokelabel),
                                icon: Icons.search,
                                borderRadius: 16,
                                paddingsuffix: 14,
                                onChanged: (value) {
                                  tempChannels.clear();
                                  for (int index = 0;
                                      index < channels.length;
                                      index++) {
                                    if (channels[index]['name']
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchController.text
                                            .toLowerCase())) {
                                      tempChannels.add(channels[index]);
                                    }
                                  }
                                  setState(() {
                                    counter = 0;
                                    lengthisZero = false;
                                  });
                                },
                              ),
                            ),

                            if(selectedChannels.length!=0)
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Icon(Icons.clear), onTap: (){
                                setState(() {
                                  selectedChannels.clear();
                                });
                              },),
                            hSizedBox,

                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Image.asset(MyImages.selectAllIcon, height: 20,color: MyColors.green,), onTap: (){

                              selectedChannels.clear();
                              tempChannels.forEach((element) {
                                selectedChannels.add(element);
                              });
                              setState(() {
                              });
                            },),
                            hSizedBox,
                          ],
                        ),
                        vSizedBox2,
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          // margin: EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              vSizedBox,
                              Container(
                                // height: 600,
                                // margin: EdgeInsets.only(bottom: 40),
                                child: tempChannels.length == 0 || lengthisZero
                                    ? Text(
                                  translate("my_subscribed_channels_page.noData"),
                                        textAlign: TextAlign.center,
                                      )
                                    : GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: tempChannels.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3),
                                        itemBuilder: (context, index) {
                                          // if(channels[index]['name'].toString().toLowerCase().contains(searchController.text.toLowerCase())) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (selectedChannels.contains(
                                                  tempChannels[index])) {
                                                selectedChannels.remove(
                                                    tempChannels[index]);
                                              } else {
                                                selectedChannels
                                                    .add(tempChannels[index]);
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        clipBehavior: Clip.hardEdge,
                                                        // height: 48,
                                                        height:MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width/6,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(40),
                                                        ),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width/6,
                                                        child: Image.network(
                                                          tempChannels[index]
                                                              ['image'],
                                                          fit: BoxFit
                                                              .fitHeight,
                                                          height: 60,
                                                        ),
                                                      ),
                                                      if (selectedChannels
                                                          .contains(
                                                              tempChannels[
                                                                  index]))
                                                        Positioned(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            child: Container(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0.6),
                                                              height: 48,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: Center(
                                                                  child: Image
                                                                      .asset(
                                                                MyImages.check,
                                                                fit: BoxFit
                                                                    .contain,
                                                                width: 25,
                                                              )),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                  ),
                                                  vSizedBox,
                                                  ParagraphText(
                                                    text:
                                                        '${tempChannels[index]['name']}',
                                                    fontSize: 14,
                                                    color:
                                                        MyColors.primaryColor,
                                                    textAlign: TextAlign.center,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                          // }
                                          // else{
                                          //   counter++;
                                          //   if(counter==channels.length){
                                          //       lengthisZero = true;
                                          //       counter = 0;
                                          //       Future.delayed(Duration(seconds: 1)).then((value){
                                          //         setState(() {
                                          //
                                          //         });
                                          //       });
                                          //   }
                                          //         return SizedBox();
                                          //       }
                                        },
                                      ),
                              ),
                              vSizedBox6,
                            ],
                          ),
                        ),
                        vSizedBox,
                      ],
                    ),
                  ),
                  RoundEdgedButton(
                    text: translate("my_subscribed_channels_page.update"),
                    isSolid: false,
                    textColor: MyColors.secondary,
                    color: MyColors.secondary,
                    onTap: selectedChannels.length == 0
                        ? null
                        : () async {
                            setState(() {
                              load = true;
                            });
                            var request = {
                              "id": userId,
                            };
                            for (int i = 0; i < selectedChannels.length; i++) {
                              request['channel_id[$i]'] =
                                  selectedChannels[i]['id'].toString();
                            }
                            var response = await Webservices.postData(
                                url: ApiUrls.addChannels,
                                request: request,
                                context: context);
                            setState(() {});
                            if (response['status'] == 1) {
                              await updateSharedPreferenceFromServer();
                              showSnackbar(
                                  context, translate("my_subscribed_channels_page.updateMsg"));
                              // await Navigator.pushReplacementNamed(context, MyStatefulWidget.id);
                            }
                            setState(() {
                              load = false;
                            });
                          },
                  ),
                  vSizedBox2,
                  // RoundEdgedButton(text: 'Add More Channels',
                  //   image: MyImages.addIcon,
                  //   color: MyColors.secondary,
                  //   textColor: Colors.white,),
                  // vSizedBox,
                  // RoundEdgedButton(text: 'Unsubscribe',
                  //   isSolid: false,
                  //   textColor: MyColors.secondary,
                  //   color: MyColors.secondary,
                  // ),
                  // vSizedBox2,
                ],
              ),
            ),
    );
  }
}
