import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/global_functions.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/pages/select_audience.dart';
import 'package:ox21/widgets/CustomTexts.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../widgets/appbar.dart';
import 'package:flutter_translate/flutter_translate.dart';

class Add_Screenshot_page extends StatefulWidget {
  static const String id = "Add_Screenshot_page";
  List<File> screenshots;
  Add_Screenshot_page({Key? key, required this.screenshots}) : super(key: key);

  @override
  State<Add_Screenshot_page> createState() => _Add_Screenshot_pageState();
}

class _Add_Screenshot_pageState extends State<Add_Screenshot_page> {
  int selectedIndex= -1;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context, widget.screenshots);
        return false;
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFeaedf6),
        appBar: appBar(
            context: context,
            title: translate("add_detail.addSs"),
            titleColor: MyColors.secondary,
            toolbarHeight: 50,
            actions: [
              TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, Select_Audience.id);
                    Navigator.pop(context,  widget.screenshots);
                  },
                  child: ParagraphText(
                    text:translate("add_description.done"),
                    color: MyColors.secondary,
                    fontSize: 16,
                    fontFamily: 'semibold',
                  ))
            ]),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                vSizedBox6,

                if(selectedIndex!=-1)
                Image.file(
                  widget.screenshots[selectedIndex],
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),

                if(selectedIndex==-1 && widget.screenshots.length!=0)
                  Image.file(
                    widget.screenshots[0],
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                vSizedBox2,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     ParagraphText(
                //       text: 'Download Screenshot',
                //       fontSize: 16,
                //     ),
                //     Icon(
                //       Icons.download_outlined,
                //       color: Colors.black.withOpacity(0.4),
                //       size: 20,
                //     ),
                //   ],
                // ),
                vSizedBox4,

                // Row(
                //   children: [
                //     Expanded(
                //         child: GestureDetector(
                //           onTap: ()async{
                //             print('nbutton pressed');
                //             screenshots =  await pickMultipleImages();
                //             print(screenshots);
                //             setState(() {
                //
                //             });
                //           },
                //           child: Image.asset(
                //             MyImages.change,height: 100, width: MediaQuery.of(context).size.width,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //     ),
                //     hSizedBox,
                //     Expanded(
                //         child: Image.asset(MyImages.unsplash,height: 100, width: MediaQuery.of(context).size.width,
                //           fit: BoxFit.cover,),
                //     ),
                //   ],
                //
                // ),
                // vSizedBox,
                Container(
                  // height: 300,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.screenshots.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 150),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return GestureDetector(
                          onTap: () async {
                            print('nbutton pressed');
                            widget.screenshots += await pickMultipleImages();
                            if(widget.screenshots.length==0){
                              selectedIndex = -1;
                            }else{
                              selectedIndex = 0;
                            }
                            print(widget.screenshots);
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, size: 48,),
                                vSizedBox,
                                SubHeadingText(text:  translate("my_purchased_banners.add1"), fontSize: 20,)
                              ],
                            ),
                          ),
                          //
                          // child: Image.asset(
                          //   MyImages.change,
                          //   width: MediaQuery.of(context).size.width,
                          //   fit: BoxFit.fill,
                          // ),
                        );
                      }
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedIndex = index-1;
                          });
                        },
                        child: Image.file(
                          widget.screenshots[index - 1],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                vSizedBox,
                // Row(
                //   children: [
                //     Expanded(
                //       child: Image.asset(MyImages.unsplash,height: 100, width: MediaQuery.of(context).size.width,
                //         fit: BoxFit.cover,),
                //     ),
                //     hSizedBox,
                //     Expanded(
                //       child: Image.asset(MyImages.unsplash, height: 100, width: MediaQuery.of(context).size.width,
                //         fit: BoxFit.cover,),
                //     ),
                //   ],
                //
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
