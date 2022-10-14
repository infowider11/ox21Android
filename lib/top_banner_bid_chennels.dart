import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ox21/pages/select_page_number_page.dart';
import 'package:ox21/pages/top_banner_bid_page.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/tab.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/customtextfield.dart';

import 'constants/colors.dart';
import 'constants/global_constants.dart';
import 'constants/image_urls.dart';
import 'constants/sized_box.dart';
import 'package:flutter_translate/flutter_translate.dart';
class top_banner_chennel extends StatefulWidget {
  // static const String id="topbidchennel";
  Map<String, dynamic> request;
  top_banner_chennel({Key? key, required this.request}) : super(key: key);

  @override
  State<top_banner_chennel> createState() => _top_banner_chennelState();
}

class _top_banner_chennelState extends State<top_banner_chennel> {
  int counter = 0;
  bool lengthisZero = false;

  bool load = false;
  // String? selectedChannel;
  List<Map> selectedChannels = [];
  List<Map> tempChannels = [];
  TextEditingController searchController = TextEditingController();

  getChannels() async {
    setState(() {
      load = true;
    });
    channels =
        await Webservices.getList(ApiUrls.getChannels + '?user_id=$userId');
    channels.forEach((element) {
      tempChannels.add(element);
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

  @override
  Widget build(BuildContext context) {
    print(widget.request);
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      appBar: load
          ? null
          : appBar(
              context: context,
              title: translate("top_banner_bid_chennels.title"),
              titleColor: MyColors.primaryColor,
            ),
      body: load
          ? CustomLoader()
          : Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox,
                    vSizedBox,
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      child: CustomTextFieldlabel(
                        labeltext: translate("top_banner_bid_chennels.searchChannel"),
                        controller: searchController,
                        hintText: translate("top_banner_bid_chennels.searchChannel"),
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
                                .contains(
                                    searchController.text.toLowerCase())) {
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
                    vSizedBox2,
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 0),
                        // height: 600,
                        // margin: EdgeInsets.only(bottom: 40),
                        child: tempChannels.length == 0 || lengthisZero
                            ? Text(
                          translate("top_banner_bid_chennels.noData"),
                                textAlign: TextAlign.center,
                              )
                            : GridView.builder(
                                itemCount: tempChannels.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemBuilder: (context, index) {
                                  // if(channels[index]['name'].toString().toLowerCase().contains(searchController.text.toLowerCase())) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (selectedChannels
                                          .contains(tempChannels[index])) {
                                        selectedChannels
                                            .remove(tempChannels[index]);
                                      } else {
                                        selectedChannels.clear();
                                        selectedChannels
                                            .add(tempChannels[index]);
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Container(
                                                  // height: 48,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Image.network(
                                                    tempChannels[index]
                                                        ['image'],
                                                    fit: BoxFit.fitHeight,
                                                    height: 66,
                                                  ),
                                                ),
                                              ),
                                              if (selectedChannels.contains(
                                                  tempChannels[index]))
                                                Positioned(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Container(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.6),
                                                      height: 48,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Center(
                                                          child: Image.asset(
                                                        MyImages.check,
                                                        fit: BoxFit.contain,
                                                        width: 25,
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                            clipBehavior: Clip.antiAlias,
                                          ),
                                          vSizedBox,
                                          ParagraphText(
                                            text:
                                                '${tempChannels[index]['name']}',
                                            fontSize: 14,
                                            color: MyColors.primaryColor,
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
                    ),
                    RoundEdgedButton(
                      text:translate("top_banner_bid_chennels.continue"),
                      horizontalMargin: 16,
                      color: selectedChannels.length==0?MyColors.inactiveButtonColor: MyColors.primaryColor,
                      onTap:  selectedChannels.length==0?null:(){
                        print(widget.request);
                        print(selectedChannels[0]['id'].runtimeType);
                        widget.request['channel'] = selectedChannels[0]['id'].toString();
                        widget.request['channelName'] = selectedChannels[0]['name'].toString();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectPageNumberPage(request: widget.request,)));


                      },
                    ),
                    vSizedBox2,
                  ],
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       vSizedBox2,
                //       RoundEdgedButton(
                //         text: 'Continue',
                //         textColor: Colors.white,
                //         color: MyColors.primaryColor,
                //         borderRadius: 12,
                //         width: MediaQuery.of(context).size.width - 32,
                //         fontSize: 16,
                //         verticalPadding: 20,
                //         horizontalMargin: 16,
                //         fontfamily: 'medium',
                //         onTap: (){
                //           Navigator.pushNamed(context, MyStatefulWidget.id);
                //         },
                //       ),
                //       vSizedBox2,
                //     ],
                //   ),
                // )
              ],
            ),
    );
  }
}
