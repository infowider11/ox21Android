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

class MyPrivateChannels extends StatefulWidget {
  static const id = 'my_private_channels';
  const MyPrivateChannels({Key? key}) : super(key: key);

  @override
  _MyPrivateChannelsState createState() => _MyPrivateChannelsState();
}

class _MyPrivateChannelsState extends State<MyPrivateChannels> {

  bool load = false;

  List myPrivateChannels = [];
  getChannels() async {
    setState(() {
      load = true;
    });
    myPrivateChannels =
    await Webservices.getList(ApiUrls.getChannels + '?user_id=$userId&my_channel=1');

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
          title: 'My Private Channels',
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
                      MainHeadingText(text: 'My Private Channels'),
                    ],
                  ),
                  vSizedBox2,
                  RoundEdgedButton(text: 'Create Private Channel', onTap: ()async{
                    await push(context: context, screen: CreatePrivateChannel(),);
                    getChannels();
                  },horizontalMargin: 40,),
                  vSizedBox2,
                  Row(
                    children: [
                      // Expanded(
                      //   child: CustomTextFieldlabel(
                      //     labeltext: 'Search in Channels',
                      //     controller: searchController,
                      //     hintText: 'Search in channels',
                      //     left: 16,
                      //     fontsize: 12,
                      //     hintcolor: MyColors.inputbordercolor,
                      //     // suffixIcon: MyImages.voicesearch,
                      //     bgColor: Color(0xFFF2F2F2),
                      //     border: Border.all(color: MyColors.strokelabel),
                      //     icon: Icons.search,
                      //     borderRadius: 16,
                      //     paddingsuffix: 14,
                      //     onChanged: (value) {
                      //       tempChannels.clear();
                      //       for (int index = 0;
                      //       index < channels.length;
                      //       index++) {
                      //         if (channels[index]['name']
                      //             .toString()
                      //             .toLowerCase()
                      //             .contains(searchController.text
                      //             .toLowerCase())) {
                      //           tempChannels.add(channels[index]);
                      //         }
                      //       }
                      //       setState(() {
                      //         counter = 0;
                      //         lengthisZero = false;
                      //       });
                      //     },
                      //   ),
                      // ),
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
                          child: myPrivateChannels.length == 0 ? Text(
                            'No Channels Found',
                            textAlign: TextAlign.center,
                          )
                              : GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: myPrivateChannels.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              // if(channels[index]['name'].toString().toLowerCase().contains(searchController.text.toLowerCase())) {
                              return Container(
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
                                            myPrivateChannels[index]
                                            ['image'],
                                            fit: BoxFit
                                                .fitHeight,
                                            height: 60,
                                          ),
                                        ),
                                      ],
                                      clipBehavior:
                                      Clip.antiAlias,
                                    ),
                                    vSizedBox,
                                    ParagraphText(
                                      text:
                                      '${myPrivateChannels[index]['name']}',
                                      fontSize: 14,
                                      color:
                                      MyColors.primaryColor,
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              );
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

            // vSizedBox2,
          ],
        ),
      ),
    );
  }
}
