import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/pages/play_video_page.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:video_player/video_player.dart';

import '../constants/colors.dart';
import '../constants/global_functions.dart';
import '../widgets/appbar.dart';
import '../widgets/customtextfield.dart';
import'package:flutter_translate/flutter_translate.dart';
class MyPurchasedDomains extends StatefulWidget {
  static const String id = "My_videos_page";
  const MyPurchasedDomains({Key? key}) : super(key: key);

  @override
  State<MyPurchasedDomains> createState() => _MyPurchasedDomainsState();
}

class _MyPurchasedDomainsState extends State<MyPurchasedDomains> {

  bool load = true;
  List myDomains = [
  ];


  String selectedVideoType = 'videos';
  getDomains() async {
    setState(() {
      load = true;
    });
    myDomains = await Webservices.getList(
        ApiUrls.getMyDomains + 'user_id=$userId&status=1');
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getDomains();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeaedf6),
      appBar: appBar(
          context: context,
          title:translate("my_purchased_domains.title"),
          titleColor: MyColors.secondary,
          // toolbarHeight: 50,
      ),
      body: load
          ? CustomLoader()
          : Container(
        child: Column(
          children: [
            // if (showSearch)
            //   Container(
            //     padding: EdgeInsets.symmetric(horizontal: 16),
            //     child: CustomTextField(
            //       bgColor: Colors.white,
            //       controller: searchController,
            //       hintText: 'Search by keyword',
            //       onChanged: (value) {
            //         setState(() {
            //           count = 0;
            //         });
            //       },
            //     ),
            //   ),

            // vSizedBox2,


          if(myDomains.length!=0)
              // Expanded(
              //   child:ListView.builder(
              //     itemCount: myDomains.length,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              //         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              //         // height:110,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         border: Border.all(color: MyColors.black54Color)
              //       ),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               ParagraphText(text: 'Domain Name',),
              //               SubHeadingText(text: '${myDomains[index]['domain']}',),
              //             ],
              //           ),
              //           vSizedBox05,
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             // crossAxisAlignment: CrossAxisAlignment.end,
              //             children: [
              //
              //               ParagraphText(text: 'Purchased On',),
              //               ParagraphText(text: '${DateFormat.yMMMMEEEEd().format(DateTime.parse(myDomains[index]['created_at']))}',textAlign: TextAlign.end,),
              //             ],
              //           ),
              //           vSizedBox05,
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             // crossAxisAlignment: CrossAxisAlignment.end,
              //             children: [
              //
              //               ParagraphText(text: 'Cost',),
              //               if(myDomains[index]['payment_by']=='paypal')
              //                 ParagraphText(text: '${myDomains[index]['usd_cost']} BTC',textAlign: TextAlign.end,),
              //               // if(myDomains[index]['btc_cost']!=0)
              //               if(myDomains[index]['payment_by']=='btc')
              //                 ParagraphText(text: '${myDomains[index]['btc_cost']} USD',textAlign: TextAlign.end,),
              //               // if(myDomains[index]['jin_cost']!=0)
              //               if(myDomains[index]['payment_by']=='jin')
              //                 ParagraphText(text: '${myDomains[index]['jin_cost']} JINS',textAlign: TextAlign.end,),
              //               // if(myDomains[index]['points']!='0')
              //               if(myDomains[index]['payment_by']=='points')
              //               ParagraphText(text: '${myDomains[index]['points']} OX21 points',textAlign: TextAlign.end,),
              //
              //             ],
              //           ),
              //           vSizedBox05,
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             // crossAxisAlignment: CrossAxisAlignment.end,
              //             children: [
              //
              //               ParagraphText(text: 'Order Id',),
              //               ParagraphText(text: '${myDomains[index]['orderID']}',textAlign: TextAlign.end,),
              //             ],
              //           ),
              //         ],
              //       ),
              //       );
              //     }),
              // )
          Expanded(
      child:ListView.builder(
        physics: BouncingScrollPhysics(),
      itemCount: myDomains.length,
          // padding: EdgeInsets.symmetric( vertical: 20),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              margin: EdgeInsets.symmetric(horizontal: 8,vertical: 1),
              // height:110,
              decoration: BoxDecoration(
                color: Colors.white,

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      ParagraphText(text: '#${myDomains[index]['orderID']}',textAlign: TextAlign.end,color: Colors.black54,),
                    ],
                  ),
                  vSizedBox05,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: SubHeadingText(text: '${myDomains[index]['domain']}',)),

                      SubHeadingText(
                        fontSize: 20,
                        color: MyColors.primaryColor,
                        text:
                        myDomains[index]['payment_by']=='paypal'?
                        '${myDomains[index]['usd_cost']} USD':
                        myDomains[index]['payment_by']=='btc'?
                        '${myDomains[index]['btc_cost']} BTC':
                        myDomains[index]['payment_by']=='jin'?
                        '${myDomains[index]['jin_cost']} JIN':
                        '${myDomains[index]['points']} OX21 points'

                        ,
                      ),

                      // if(myDomains[index]['payment_by']=='paypal')
                      //   ParagraphText(text: '${myDomains[index]['usd_cost']} BTC',textAlign: TextAlign.end,),
                      // // if(myDomains[index]['btc_cost']!=0)
                      // if(myDomains[index]['payment_by']=='btc')
                      //   ParagraphText(text: '${myDomains[index]['btc_cost']} USD',textAlign: TextAlign.end,),
                      // // if(myDomains[index]['jin_cost']!=0)
                      // if(myDomains[index]['payment_by']=='jin')
                      //   ParagraphText(text: '${myDomains[index]['jin_cost']} JINS',textAlign: TextAlign.end,),
                      // // if(myDomains[index]['points']!='0')
                      // if(myDomains[index]['payment_by']=='points')
                      //   ParagraphText(text: '${myDomains[index]['points']} OX21 points',textAlign: TextAlign.end,),

                    ],
                  ),
                  vSizedBox05,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      ParagraphText(text: '${DateFormat.yMMMMEEEEd().add_jm().format(DateTime.parse(myDomains[index]['created_at']))}',textAlign: TextAlign.end,color: Colors.black45,),
                    ],
                  ),

                ],
              ),
            );
          }),
    )
            else
              Expanded(
                child: Center(
                  child: Text('No Domains Found'),
                ),
              ),
            vSizedBox,
          ],
        ),
      ),
    );
  }
}
