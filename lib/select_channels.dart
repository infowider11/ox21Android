import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/functions/navigation_functions.dart';
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
import 'constants/global_functions.dart';
import 'constants/image_urls.dart';
import 'constants/sized_box.dart';

class SelectChannelPage extends StatefulWidget {
  static const String id="chennel";
  const SelectChannelPage({Key? key}) : super(key: key);

  @override
  State<SelectChannelPage> createState() => _SelectChannelPageState();
}

class _SelectChannelPageState extends State<SelectChannelPage> {

  int counter=0;
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
    channels = await Webservices.getList(ApiUrls.getChannels + '?user_id=$userId');
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
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      appBar:load?null: appBar(context: context,implyLeading: false,
          actions: [
            IconButton(onPressed: (){}, icon: Image.asset(MyImages.logowelcom, width: 35, height: 40, fit: BoxFit.fitHeight,))
          ]
      ),
      body:load?CustomLoader(): Stack(
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ParagraphText(text: 'Select Channels',
                  fontSize: 18,
                  fontFamily: 'bold',
                ),
              ),
              vSizedBox,
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      child: CustomTextFieldlabel(
                        labeltext: 'Search in Channels',
                        controller: searchController,
                        hintText: 'Search in channels',
                        left: 16,
                        fontsize: 12,
                        hintcolor: MyColors.inputbordercolor,
                        // suffixIcon: MyImages.voicesearch,
                        bgColor: Color(0xFFF2F2F2),
                        border: Border.all(color: MyColors.strokelabel),
                        icon: Icons.search,
                        borderRadius: 16,
                        paddingsuffix: 14,
                        onChanged: (value){
                          tempChannels.clear();
    for(int index = 0;index<channels.length;index++){
      if(channels[index]['name'].toString().toLowerCase().contains(searchController.text.toLowerCase())){
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 0),
                  // margin: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ 
                      ParagraphText(text: 'Trending in Daily Lifestyle', fontSize: 16, color: MyColors.primaryColor,),
                      vSizedBox,
                      Expanded(
                        child: Container(
                            // height: 600,
                            // margin: EdgeInsets.only(bottom: 40),
                            child:tempChannels.length==0 ||lengthisZero?Text('No Channels Found', textAlign: TextAlign.center,)
                                : GridView.builder(
                              physics: BouncingScrollPhysics(),
                              // shrinkWrap: true,
                              itemCount: tempChannels.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                              itemBuilder: (context, index){
                                // if(channels[index]['name'].toString().toLowerCase().contains(searchController.text.toLowerCase())) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (selectedChannels
                                                .contains(tempChannels[index])) {
                                              selectedChannels
                                                  .remove(tempChannels[index]);
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
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: Container(
                                                        // height: 48,
                                                        width:
                                                            MediaQuery.of(context)
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
                                                              BorderRadius
                                                                  .circular(12),
                                                          child: Container(
                                                            color: Color.fromRGBO(
                                                                0, 0, 0, 0.6),
                                                            height: 48,
                                                            width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width,
                                                            child: Center(
                                                                child:
                                                                    Image.asset(
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
                      vSizedBox6,
                    ],
                  ),
                ),
              )

            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                vSizedBox2,
                RoundEdgedButton(
                  text: 'Continue',
                  textColor: Colors.white,
                  color:selectedChannels.length==0?Colors.grey.shade300: MyColors.primaryColor,
                  borderRadius: 12,
                  width: MediaQuery.of(context).size.width - 32,
                  fontSize: 16,
                  horizontalMargin: 16,
                  fontfamily: 'medium',
                  onTap:selectedChannels.length==0?null: ()async{
                    setState(() {
                      load = true;
                    });
                    var request =  {
                      "id": userId,
                    };
                   for(int i = 0;i<selectedChannels.length;i++){
                     request['channel_id[$i]'] = selectedChannels[i]['id'].toString();
                   }
                    var response = await Webservices.postData(url: ApiUrls.addChannels, request:request, context: context);
                   setState(() {

                   });
                    if(response['status']==1){
                      await updateSharedPreferenceFromServer();
                      Navigator.popUntil(context, (route) => route.isFirst);
                      pushReplacement(context: MyGlobalKeys.navigatorKey.currentContext!, screen: MyStatefulWidget());
                      // await Navigator.pcontext,  MaterialPageRoute(builder: (context)=>MyStatefulWidget()), (route) => route.isFirst);

                      // await Navigator.pushReplacementNamed(context, MyStatefulWidget.id);
                    }
                    setState(() {
                      load = false;
                    });

                  },
                ),
                vSizedBox2,
              ],
            ),
          )
        ],
      ),
    );
  }


  List<Widget> childrens = [];

  List<Widget> buildGridView(){
    for(int index = 0;index<channels.length;index++){
      if(channels[index]['name'].toString().toLowerCase().contains(searchController.text.toLowerCase())) {
        childrens.add(GestureDetector(
          onTap: () {
            if (selectedChannels
                .contains(channels[index])) {
              selectedChannels
                  .remove(channels[index]);
            } else {
              selectedChannels
                  .add(channels[index]);
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
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(
                          12),
                      child: Container(
                        // height: 48,
                        width:
                        MediaQuery.of(context)
                            .size
                            .width,
                        child: Image.network(
                          channels[index]
                          ['image'],
                          fit: BoxFit.fitHeight,
                          height: 48,
                        ),
                      ),
                    ),
                    if (selectedChannels.contains(
                        channels[index]))
                      Positioned(
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius
                              .circular(12),
                          child: Container(
                            color: Color.fromRGBO(
                                0, 0, 0, 0.6),
                            height: 48,
                            width: MediaQuery.of(
                                context)
                                .size
                                .width,
                            child: Center(
                                child:
                                Image.asset(
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
                  '${channels[index]['name']}',
                  fontSize: 12,
                  color: MyColors.primaryColor,
                )
              ],
            ),
          ),
        ));
    }else{
        counter++;
      }
  }
    if(childrens.length!=0){

    }
    return childrens;
}}
