import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/fully_custom_dropdown.dart';

import '../../constants/colors.dart';
import '../../constants/sized_box.dart';
import '../../custom_dialogs/rent_banner_bottom_sheet.dart';
import '../../widgets/buttons.dart';
import '../../widgets/customtextfield.dart';
import'package:flutter_translate/flutter_translate.dart';
class MyRentedBannersPage extends StatefulWidget {
  const MyRentedBannersPage({Key? key}) : super(key: key);

  @override
  _MyRentedBannersPageState createState() => _MyRentedBannersPageState();
}

class _MyRentedBannersPageState extends State<MyRentedBannersPage> {
  List rentedBanners = [];
  bool load = false;
  int? selectedMonths;
  TextEditingController dateController = TextEditingController();

  DateTime selectedDate = DateTime.now().add(Duration(days: 10));
  getRentedBanners() async {
    setState(() {
      load = true;
    });
    rentedBanners = await Webservices.getList(
        ApiUrls.my_buyed_rented_banner + '?user_id=$userId');
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getRentedBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title:translate("setting.myRent")),
      body: load
          ? CustomLoader()
          : RefreshIndicator(
          onRefresh: () async {
            await getRentedBanners();
          },
          child: Container(
            child: Column(
              children: [
                vSizedBox4,
                if (rentedBanners.length != 0)
                  Expanded(
                    child: ListView.builder(
                        itemCount: rentedBanners.length,
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
                                border: Border.all(
                                    color: MyColors.black54Color)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    ParagraphText(
                                      text: translate("rent_banner.pageNumber"),
                                    ),
                                    SubHeadingText(
                                      text:
                                      '${rentedBanners[index]['banner_data']['page_number']}',
                                    ),
                                  ],
                                ),
                                vSizedBox05,
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    ParagraphText(
                                      text: translate("rent_banner.channel"),
                                    ),
                                    ParagraphText(
                                      text:
                                      '${rentedBanners[index]['banner_data']['channel_name']}',
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
                                      text:translate("rent_banner.purchased"),
                                    ),
                                    ParagraphText(
                                      text:
                                      '${DateFormat.yMMMMEEEEd().format(DateTime.parse(rentedBanners[index]['created_at']))}',
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
                                      text: translate("rent_banner.location"),
                                    ),
                                    if (rentedBanners[index]
                                    ['city'] !=
                                        null &&
                                        rentedBanners[index]
                                        ['city'] !=
                                            'null')
                                      ParagraphText(
                                        text:
                                        '${rentedBanners[index]['city']}, ${rentedBanners[index]['state']},${rentedBanners[index]['country']}',
                                        textAlign: TextAlign.end,
                                      )
                                    else
                                      ParagraphText(text:translate("rent_banner.global"))
                                  ],
                                ),
                                vSizedBox05,

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ParagraphText(
                                      text: translate("rent_banner.selectDate"),
                                    ),
                                    ParagraphText(
                                        text:
                                        '${DateFormat.yMMMMEEEEd().format(DateTime.parse(rentedBanners[index]['start_date']))}')
                                  ],
                                ),
                                vSizedBox05,

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ParagraphText(
                                      text: translate("my_rented_banner.endDate"),
                                    ),
                                    ParagraphText(
                                        text:
                                        '${DateFormat.yMMMMEEEEd().format(DateTime.parse(rentedBanners[index]['end_date']))}')
                                  ],
                                ),
                                vSizedBox05,
                                vSizedBox,
                                if(rentedBanners[index]['payment_status']!=1)
                                RoundEdgedButton(
                                  isSolid: false,
                                  color: Colors.yellow,
                                  text:translate("my_rented_banner.payPending"),
                                  onTap: () async {
                                    bool? result =
                                    await showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor:
                                        Colors.transparent,
                                        builder: (context) {
                                          return RentBanner(item: rentedBanners[index],);
                                          // return StatefulBuilder(
                                          //     builder: (context, setState) {
                                          //       return Container(
                                          //         padding:
                                          //         EdgeInsets.symmetric(
                                          //             horizontal: 16),
                                          //         decoration: BoxDecoration(
                                          //           color: Colors.white,
                                          //           borderRadius:
                                          //           BorderRadius.circular(
                                          //               14),
                                          //         ),
                                          //         height: 400 +
                                          //             MediaQuery.of(context)
                                          //                 .viewInsets
                                          //                 .bottom,
                                          //         child: Column(
                                          //           mainAxisSize:
                                          //           MainAxisSize.min,
                                          //           children: [
                                          //             vSizedBox,
                                          //             MainHeadingText(
                                          //                 text:
                                          //                 'Rent this banner'),
                                          //             vSizedBox,
                                          //             Row(
                                          //               mainAxisAlignment:
                                          //               MainAxisAlignment
                                          //                   .spaceBetween,
                                          //               children: [
                                          //                 Expanded(
                                          //                     child:
                                          //                     SubHeadingText(
                                          //                       text:
                                          //                       'Select Date',
                                          //                     )),
                                          //                 hSizedBox,
                                          //                 Expanded(
                                          //                     child:
                                          //                     GestureDetector(
                                          //                       onTap: () async {
                                          //                         DateTime? temp =
                                          //                         await showDatePicker(
                                          //                           context:
                                          //                           context,
                                          //                           initialDate:
                                          //                           selectedDate,
                                          //                           firstDate: DateTime
                                          //                               .now()
                                          //                               .add(Duration(
                                          //                               days:
                                          //                               5)),
                                          //                           lastDate: DateTime
                                          //                               .now()
                                          //                               .add(Duration(
                                          //                               days: 365 *
                                          //                                   2)),
                                          //                         );
                                          //                         if (temp !=
                                          //                             null) {
                                          //                           setState(() {
                                          //                             selectedDate =
                                          //                                 temp;
                                          //                             dateController
                                          //                                 .text = DateFormat
                                          //                                 .yMMMd()
                                          //                                 .format(
                                          //                                 selectedDate);
                                          //                           });
                                          //                         }
                                          //                       },
                                          //                       child: CustomTextField(
                                          //                           controller:
                                          //                           dateController,
                                          //                           hintText:
                                          //                           'Select Date',
                                          //                           enabled:
                                          //                           false),
                                          //                     )),
                                          //               ],
                                          //             ),
                                          //             vSizedBox,
                                          //             Row(
                                          //               // crossAxisAlignment: CrossAxisAlignment.start,
                                          //               mainAxisAlignment:
                                          //               MainAxisAlignment
                                          //                   .spaceBetween,
                                          //               children: [
                                          //                 Expanded(
                                          //                   child:
                                          //                   SubHeadingText(
                                          //                     text:
                                          //                     'Select Months',
                                          //                   ),
                                          //                 ),
                                          //                 hSizedBox,
                                          //                 Expanded(
                                          //                   child:
                                          //                   CustomDropDown(
                                          //                     hint:
                                          //                     'Select months',
                                          //                     onChanged:
                                          //                         (val) {
                                          //                       selectedMonths = val;
                                          //                       setState(() {
                                          //
                                          //                       });
                                          //                     },
                                          //                     selectedItem:
                                          //                     selectedMonths,
                                          //                     items: List
                                          //                         .generate(
                                          //                       12,
                                          //                           (index) =>
                                          //                           DropdownMenuItem<int>(
                                          //                             value:
                                          //                             index + 1,
                                          //                             child:
                                          //                             ParagraphText(
                                          //                               text:
                                          //                               '${index + 1}',
                                          //                             ),
                                          //                           ),
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               ],
                                          //             ),
                                          //             vSizedBox,
                                          //             if(selectedMonths!=null)
                                          //               Wrap(
                                          //                 crossAxisAlignment: WrapCrossAlignment.end,
                                          //                 children: [
                                          //                   ParagraphText(text: 'You will be charged '),
                                          //                   ParagraphText(text: '${(selectedMonths! * rentedBanners[index]['total_rent']).toStringAsFixed(2)} BTC', fontWeight: FontWeight.w700,)
                                          //                 ],
                                          //               ),
                                          //             vSizedBox6,
                                          //             RoundEdgedButton(text: 'Rent', onTap: ()async{
                                          //               var request = {
                                          //                 "banner_id":rentedBanners[index]['id'].toString(),
                                          //                 "start_date":selectedDate.toString(),
                                          //                 "months":selectedMonths.toString(),
                                          //                 "tenant":userId
                                          //               };
                                          //
                                          //               var jsonResponse = await Webservices.postData(url: ApiUrls.buy_banner_on_rent, request: request, context: context);
                                          //               Navigator.pop(context);
                                          //             },),
                                          //           ],
                                          //         ),
                                          //       );
                                          //     }
                                          // );
                                        });
                                  },
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
                      child: Text(translate("my_rented_banner.noData")),
                    ),
                  ),
                vSizedBox,
              ],
            ),
          )),
    );
  }
}
