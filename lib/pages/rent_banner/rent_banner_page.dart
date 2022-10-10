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
import '../../constants/global_functions.dart';
import '../../constants/global_keys.dart';
import '../../constants/image_urls.dart';
import '../../constants/sized_box.dart';
import '../../widgets/avatar.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/customtextfield.dart';

class RentBannerPage extends StatefulWidget {
  const RentBannerPage({Key? key}) : super(key: key);

  @override
  _RentBannerPageState createState() => _RentBannerPageState();
}

class _RentBannerPageState extends State<RentBannerPage> {
  List availableBannersForRent = [];
  bool load = false;
  int? selectedMonths;
  TextEditingController dateController = TextEditingController();

  DateTime selectedDate = DateTime.now().add(Duration(days: 10));
  bool rentBannerLoad  = false;
  getAvailableBanners() async {
    setState(() {
      load = true;
    });
    availableBannersForRent = await Webservices.getList(
        ApiUrls.banner_for_rents + '?user_id=$userId');
    setState(() {
      load = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    getAvailableBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Rent a Banner'),
      body: load
          ? CustomLoader()
          : RefreshIndicator(
              onRefresh: () async {
                await getAvailableBanners();
              },
              child: Container(
                child: Column(
                  children: [
                    vSizedBox4,
                    if (availableBannersForRent.length != 0)
                      Expanded(
                        child: ListView.builder(
                            itemCount: availableBannersForRent.length,
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
                                          text: 'Page Number',
                                        ),
                                        SubHeadingText(
                                          text:
                                              '${availableBannersForRent[index]['page_number']}',
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
                                          text:
                                              '${availableBannersForRent[index]['channel_name']}',
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
                                              '${DateFormat.yMMMMEEEEd().format(DateTime.parse(availableBannersForRent[index]['created_at']))}',
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
                                        if (availableBannersForRent[index]
                                                    ['city'] !=
                                                null &&
                                            availableBannersForRent[index]
                                                    ['city'] !=
                                                'null')
                                          ParagraphText(
                                            text:
                                                '${availableBannersForRent[index]['city']}, ${availableBannersForRent[index]['state']},${availableBannersForRent[index]['country']}',
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
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        ParagraphText(
                                          text: 'Rent Price per month',
                                        ),
                                        ParagraphText(
                                            text:
                                                '${(availableBannersForRent[index]['total_rent'] as double).toStringAsFixed(2)} BTC')
                                      ],
                                    ),
                                    vSizedBox05,
                                    vSizedBox,
                                    // if(myBanners[index]['is_for_rent']==0)
                                    RoundEdgedButton(
                                      text: 'Rent This Banner',
                                      onTap: () async {
                                        bool? result =
                                            await showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) {
                                                  return StatefulBuilder(
                                                    builder: (context, setState) {
                                                      return Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 16),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  14),
                                                        ),
                                                        height: 400 +
                                                            MediaQuery.of(context)
                                                                .viewInsets
                                                                .bottom,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            vSizedBox,
                                                            MainHeadingText(
                                                                text:
                                                                    'Rent this banner'),
                                                            vSizedBox,
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                    child:
                                                                        SubHeadingText(
                                                                  text:
                                                                      'Select Date',
                                                                )),
                                                                hSizedBox,
                                                                Expanded(
                                                                    child:
                                                                        GestureDetector(
                                                                  onTap: () async {
                                                                    DateTime? temp =
                                                                        await showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          selectedDate,
                                                                      firstDate: DateTime
                                                                              .now()
                                                                          .add(Duration(
                                                                              days:
                                                                                  5)),
                                                                      lastDate: DateTime
                                                                              .now()
                                                                          .add(Duration(
                                                                              days: 365 *
                                                                                  2)),
                                                                    );
                                                                    if (temp !=
                                                                        null) {
                                                                      setState(() {
                                                                        selectedDate =
                                                                            temp;
                                                                        dateController
                                                                            .text = DateFormat
                                                                                .yMMMd()
                                                                            .format(
                                                                                selectedDate);
                                                                      });
                                                                    }
                                                                  },
                                                                  child: CustomTextField(
                                                                      controller:
                                                                          dateController,
                                                                      hintText:
                                                                          'Select Date',
                                                                      enabled:
                                                                          false),
                                                                )),
                                                              ],
                                                            ),
                                                            vSizedBox,
                                                            Row(
                                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      SubHeadingText(
                                                                    text:
                                                                        'Select Months',
                                                                  ),
                                                                ),
                                                                hSizedBox,
                                                                Expanded(
                                                                  child:
                                                                      CustomDropDown(
                                                                    hint:
                                                                        'Select months',
                                                                    onChanged:
                                                                        (val) {
                                                                      selectedMonths = val;
                                                                          setState(() {

                                                                          });
                                                                        },
                                                                    selectedItem:
                                                                        selectedMonths,
                                                                    items: List
                                                                        .generate(
                                                                      12,
                                                                      (index) =>
                                                                          DropdownMenuItem<int>(
                                                                        value:
                                                                            index + 1,
                                                                        child:
                                                                            ParagraphText(
                                                                          text:
                                                                              '${index + 1}',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            vSizedBox,
                                                            if(selectedMonths!=null)
                                                            Wrap(
                                                              crossAxisAlignment: WrapCrossAlignment.end,
                                                              children: [
                                                                ParagraphText(text: 'You will be charged '),
                                                                ParagraphText(text: '${(selectedMonths! * availableBannersForRent[index]['total_rent']).toStringAsFixed(2)} BTC', fontWeight: FontWeight.w700,)
                                                              ],
                                                            ),
                                                            vSizedBox6,
                                                            RoundEdgedButton(text: 'Rent', onTap: ()async{
                                                              var request = {
                                                                "banner_id":availableBannersForRent[index]['id'].toString(),
                                                                "start_date":selectedDate.toString(),
                                                                "months":selectedMonths.toString(),
                                                                "tenant":userId,
                                                              };

                                                              setState((){
                                                                rentBannerLoad = true;
                                                              });
                                                              var jsonResponse = await Webservices.postData(url: ApiUrls.buy_banner_on_rent, request: request, context: context, showSuccessMessage: true);
                                                              // if(jsonResponse['status']==1){
                                                                Navigator.pop(context);
                                                              // }
                                                              try{
                                                                setState((){
                                                                  rentBannerLoad = false;
                                                                });
                                                              }catch(e){
                                                                try{
                                                                  this.setState((){
                                                                    rentBannerLoad = false;
                                                                  });
                                                                }catch(ef){
                                                                  print("Error in catch block $ef and first was $e");
                                                                }
                                                              }
                                                            },),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  );
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
                          child: Text('No Banners Found'),
                        ),
                      ),
                    vSizedBox,
                  ],
                ),
              )),
    );
  }
}
