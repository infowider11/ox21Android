import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/widgets/CustomTexts.dart';

import '../constants/colors.dart';
import '../widgets/appbar.dart';
import 'package:flutter_translate/flutter_translate.dart';

List visibilityOptions = ['public', 'unlisted', 'private'];

// enum SingingCharacter{ public, jefferson, hello }
class Set_visibility_Page extends StatefulWidget {
  String visibility;
  DateTime postingTime;
  Set_visibility_Page(
      {Key? key, required this.postingTime, required this.visibility})
      : super(key: key);
  static const String id = "Set_visibility_Page";
  @override
  State<Set_visibility_Page> createState() => _Set_visibility_PageState();
}

class _Set_visibility_PageState extends State<Set_visibility_Page> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  // SingingCharacter? _character = SingingCharacter.lafayette;
  @override
  Widget build(BuildContext context) {
    print(widget.postingTime);
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return MyColors.blackColor.withOpacity(0.5);
    }

    return Scaffold(
      backgroundColor: Color(0xFFeaedf6),
      appBar: appBar(
          context: context,
          title: translate("set_visibility.setVisibility"),
          titleColor: MyColors.secondary,
          toolbarHeight: 50,
          actions: [
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context, [
                    widget.postingTime,
                    widget.visibility,
                  ]);
                },
                child: SubHeadingText(
                  text: translate("set_visibility.done"),
                  color: MyColors.primaryColor,
                ),
              ),
            ),
            hSizedBox2,
          ]),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox2,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ParagraphText(
                      text:translate("set_visibility.publishNow"),
                      fontSize: 16,
                    ),
                    vSizedBox2,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Radio<String>(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            activeColor: MyColors.secondary,
                            focusColor: MyColors.whiteColor,
                            value: visibilityOptions[0],
                            groupValue: widget.visibility,
                            onChanged: (String? value) {
                              setState(() {
                                widget.visibility = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ParagraphText(
                                text: translate("set_visibility.Public"),
                                color: MyColors.heading,
                                fontSize: 14,
                                fontFamily: 'regular',
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              ParagraphText(
                                text: translate("set_visibility.searchView"),
                                color: MyColors.blackColor.withOpacity(0.5),
                                fontSize: 12,
                                fontFamily: 'light',
                              ),
                              Row(
                                children: [
                                  Transform.translate(
                                    child: Checkbox(
                                      visualDensity: VisualDensity.compact,
                                      checkColor: Colors.white,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              getColor),
                                      value: isChecked1,
                                      onChanged: (bool? value) {
                                        if(value==true)
                                          widget.postingTime = DateTime.now();
                                        setState(() {
                                          isChecked1 = value!;
                                        });
                                      },
                                    ),
                                    offset: Offset(-10, 0),
                                  ),
                                  ParagraphText(
                                    text: translate("set_visibility.setPermier"),
                                    color: MyColors.heading,
                                    fontSize: 14,
                                    fontFamily: 'regular',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 30,
                      thickness: 1,
                      color: Color(0xFF8ebfe0),
                      indent: 55,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Radio<String>(
                            visualDensity: VisualDensity.compact,
                            // materialTapTargetSize:
                            // MaterialTapTargetSize.shrinkWrap,
                            activeColor: MyColors.secondary,
                            focusColor: MyColors.whiteColor,
                            value: visibilityOptions[1],
                            groupValue: widget.visibility,
                            onChanged: (String? value) {
                              setState(() {
                                widget.visibility = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ParagraphText(
                                text: translate("set_visibility.Unlisted"),
                                color: MyColors.heading,
                                fontSize: 14,
                                fontFamily: 'regular',
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              ParagraphText(
                                text:translate("set_visibility.linkView"),
                                color: MyColors.blackColor.withOpacity(0.5),
                                fontSize: 12,
                                fontFamily: 'light',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 30,
                      thickness: 1,
                      color: Color(0xFF8ebfe0),
                      indent: 55,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Radio<String>(
                            visualDensity: VisualDensity.compact,
                            // materialTapTargetSize:
                            // MaterialTapTargetSize.shrinkWrap,
                            activeColor: MyColors.secondary,
                            focusColor: MyColors.whiteColor,
                            value: visibilityOptions[2],
                            groupValue: widget.visibility,
                            onChanged: (String? value) {
                              setState(() {
                                widget.visibility = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ParagraphText(
                                text:translate("set_visibility.private"),
                                color: MyColors.heading,
                                fontSize: 14,
                                fontFamily: 'regular',
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              ParagraphText(
                                text:translate("set_visibility.chooseView"),
                                color: MyColors.blackColor.withOpacity(0.5),
                                fontSize: 12,
                                fontFamily: 'light',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 50,
                thickness: 1,
                color: Color(0xFF8ebfe0),
                indent: 0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ParagraphText(
                          text: translate("set_visibility.Schedule"),
                          fontSize: 16,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black.withOpacity(0.4),
                          size: 20,
                        ),
                      ],
                    ),
                    vSizedBox2,
                    ParagraphText(
                      text: translate("set_visibility.public"),
                      fontSize: 16,
                    ),
                    vSizedBox,
                    GestureDetector(
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: widget.postingTime,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.utc(DateTime.now().year + 1));
                        if (dateTime != null) {
                          TimeOfDay? timeOfDay = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (timeOfDay != null) {
                            isChecked1 = false;
                            isChecked2 = false;
                            print('the time is ${timeOfDay.toString()}');
                            Duration duration = Duration(
                                hours: timeOfDay.hour,
                                minutes: timeOfDay.minute);
                            print('the duration is ${duration.toString()}');
                            dateTime = dateTime.add(duration);
                            widget.postingTime = dateTime;
                          }

                          setState(() {});
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Color(0xFFdff9f8),
                            border: Border.all(
                              color: Color(0xFFc9f9fb),
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.all(16),
                        // child: ParagraphText(text: 'Aprail,10,2022, 12:00AM Local Time', fontSize: 14, ),
                        child: ParagraphText(
                          text: DateFormat.yMMMMEEEEd().add_jm().format(widget.postingTime),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    vSizedBox2,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ParagraphText(
                          text: translate("set_visibility.privateVideo"),
                          color: MyColors.blackColor.withOpacity(0.5),
                          fontSize: 12,
                          fontFamily: 'light',
                        ),
                        // Row(
                        //   children: [
                        //     Transform.translate(
                        //       child: Checkbox(
                        //         visualDensity: VisualDensity.compact,
                        //         checkColor: Colors.white,
                        //         fillColor:
                        //             MaterialStateProperty.resolveWith(getColor),
                        //         value: isChecked2,
                        //         onChanged: (bool? value) {
                        //           if(value==true)
                        //             widget.postingTime = DateTime.now();
                        //           setState(() {
                        //             isChecked2 = value!;
                        //           });
                        //         },
                        //       ),
                        //       offset: Offset(0, 0),
                        //     ),
                        //     ParagraphText(
                        //       text: 'Set as Premier',
                        //       color: MyColors.heading,
                        //       fontSize: 14,
                        //       fontFamily: 'regular',
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 50,
                thickness: 1,
                color: Color(0xFF8ebfe0),
                indent: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
