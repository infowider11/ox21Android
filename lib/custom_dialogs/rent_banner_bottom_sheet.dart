import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/widgets/custom_snackbar.dart';

import '../constants/global_constants.dart';
import '../constants/sized_box.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';
import '../widgets/fully_custom_dropdown.dart';
class RentBanner extends StatefulWidget {
  final Map item;
  const RentBanner({Key? key, required this.item}) : super(key: key);

  @override
  State<RentBanner> createState() => _RentBannerState();
}

class _RentBannerState extends State<RentBanner> {
  int? selectedMonths;
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now().add(Duration(days: 10));
  bool rentBannerLoad  = false;
  @override
  Widget build(BuildContext context) {
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
                ParagraphText(text: '${(selectedMonths! * widget.item['total_rent']).toStringAsFixed(2)} BTC', fontWeight: FontWeight.w700,)
              ],
            ),
          vSizedBox6,
          RoundEdgedButton(text: 'Rent', onTap: ()async{
            var request = {
              "banner_id":widget.item['banner_id'].toString(),
              "start_date":selectedDate.toString(),
              "months":selectedMonths.toString(),
              "tenant":userId,
            };

            setState((){
              rentBannerLoad = true;
            });
            var jsonResponse = await Webservices.postData(url: ApiUrls.buy_banner_on_rent, request: request, context: context, showSuccessMessage: true,showErrorMessage: false);
            print('imhereeeee with n$jsonResponse');
            if(jsonResponse['status'].toString()=='1'){
              showSnackbar(context, jsonResponse['message']);
            }
            if(jsonResponse['status'].toString()=='2'){
              print('imhereeeee');
              // Navigato
             await showModalBottomSheet( context: MyGlobalKeys.navigatorKey.currentContext!,
                  isScrollControlled: true,
                  backgroundColor:
                  Colors.transparent,
                  builder: (context){
                return Container(
                  // height: 400 +
                  //     MediaQuery.of(context)
                  //         .viewInsets
                  //         .bottom,
                  padding:EdgeInsets.symmetric(
                      horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(
                        14),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      vSizedBox2,
                      ParagraphText(text: 'You need to buy ${jsonResponse['domain_name']} first to rent this banner, it will cost you extra ${double.parse(jsonResponse['cost']).toStringAsFixed(4)}BTC. Are you sure?', textAlign: TextAlign.center,),
                      vSizedBox2,
                      Row(
                        children: [
                          RoundEdgedButton(text: 'Yes', width: 120,
                          onTap: ()async{
                            Map<String,dynamic> domainRequest = {
                              "domain":jsonResponse['domain_name'],
                              "user_id":userId,
                              "payment_by":"btc",
                            };
                            var jsonDomainResponse = await Webservices.postData(url: ApiUrls.buyDomain, request: domainRequest, context: context);
                            var jsonBannerResponse = await Webservices.postData(url: ApiUrls.buy_banner_on_rent, request: request, context: context);
                            Navigator.pop(context);
                          },),
                          hSizedBox2,
                          RoundEdgedButton(text: 'No', width: 120,
                            onTap: ()async{
                              Navigator.pop(context);
                            },),
                        ],
                      ),
                      vSizedBox4,
                    ],
                  ),
                );
              });
            }
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
}
