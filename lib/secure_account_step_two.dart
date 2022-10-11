import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/congratulations.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/create_password.dart';
import 'package:ox21/intro.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:flutter_translate/flutter_translate.dart';

class Step_two extends StatefulWidget {
  static const String id = "step2";
  final List passPhrase;
  const Step_two({Key? key, required this.passPhrase}) : super(key: key);

  @override
  State<Step_two> createState() => _Step_twoState();
}

class _Step_twoState extends State<Step_two> {
  List<int> chooseFromNumbers = [2, 5, 8];
  List shuffledPassPhrase = [];

  int noOfAttemptsLeft = 3;

  addRandomNumbers() {
    chooseFromNumbers.clear();
    for (int i = 0; i < 3; i++) {
      int number = Random().nextInt(12);
      addNumber(number);
    }
  }

  addNumber(int number) {
    print('the number is $number');
    if (!chooseFromNumbers.contains(number)) {
      print('false');
      chooseFromNumbers.add(number);
    } else {
      print('true');
      int number = Random().nextInt(12);
      addNumber(number);
    }
  }

  List filledValues = [];

  int currentPosition = 0;

  @override
  void initState() {
    // TODO: implement initState
    addRandomNumbers();
    widget.passPhrase.forEach((element) {
      shuffledPassPhrase.add(element);
    });
    // shuffledPassPhrase = widget.passPhrase;
    shuffledPassPhrase.shuffle();
    print(widget.passPhrase);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backcolor,
      appBar: appBar(context: context, actions: [
        IconButton(
            onPressed: () {},
            icon: Image.asset(
              MyImages.logowelcom,
              width: 35,
              height: 40,
              fit: BoxFit.fitHeight,
            ))
      ]),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ParagraphText(
                  text: translate("secure_account_step_two.title"),
                  fontSize: 18,
                  fontFamily: 'bold',
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: ParagraphText(
                        text:
                        translate("secure_account_step_two.subTitle"),
                        fontSize: 16,
                        fontFamily: 'regular',
                        color: MyColors.blackColor,
                      ),
                    ),
                    vSizedBox2,
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentPosition = 0;
                              });
                            },
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(8),
                              dashPattern: [5, 5],
                              color: Color(0xFFDDDFE4),
                              strokeWidth: currentPosition == 0 ? 2 : 0,
                              padding: EdgeInsets.all(0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: filledValues.length == 0
                                      ? Colors.white
                                      : MyColors.greenlight,
                                  borderRadius: BorderRadius.circular(8),
                                  // border: BoxBorder.
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: Center(
                                  child: Text(
                                    filledValues.length == 0
                                        ? '${chooseFromNumbers[0] + 1}'
                                        : '${filledValues[0]}',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        hSizedBox,
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filledValues.length > 0)
                                  currentPosition = 1;
                              });
                            },
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(8),
                              dashPattern: [5, 5],
                              color: Color(0xFFDDDFE4),
                              strokeWidth: currentPosition == 1 ? 2 : 0,
                              padding: EdgeInsets.all(0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: filledValues.length < 2
                                      ? Colors.white
                                      : MyColors.greenlight,
                                  borderRadius: BorderRadius.circular(8),
                                  // border: BoxBorder.
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: Center(
                                  child: Text(
                                    filledValues.length <= 1
                                        ? '${chooseFromNumbers[1] + 1}'
                                        : '${filledValues[1]}',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        hSizedBox,
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filledValues.length > 1)
                                  currentPosition = 2;
                              });
                            },
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(8),
                              dashPattern: [5, 5],
                              color: Color(0xFFDDDFE4),
                              strokeWidth: currentPosition == 2 ? 2 : 0,
                              padding: EdgeInsets.all(0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: filledValues.length == 3
                                      ? MyColors.greenlight
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  // border: BoxBorder.
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: Center(
                                  child: Text(
                                    filledValues.length <= 2
                                        ? '${chooseFromNumbers[2] + 1}'
                                        : '${filledValues[2]}',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    vSizedBox,
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //         flex: 2,
                    //         child: Column(
                    //           children: [
                    //             RoundEdgedButton(
                    //               text: 'then',
                    //               textColor: MyColors.green,
                    //               color: MyColors.greenlight,
                    //               fontSize: 16,
                    //               fontfamily: 'regular',
                    //               verticalPadding: 8,
                    //               height: 40,
                    //               borderRadius: 8,
                    //               horizontalMargin: 2.5,
                    //             ),
                    //           ],
                    //         )),
                    //     hSizedBox,
                    //     Expanded(
                    //         flex: 2,
                    //         child: Column(
                    //           children: [
                    //             DottedBorder(
                    //               borderType: BorderType.RRect,
                    //               radius: Radius.circular(8),
                    //               dashPattern: [5, 5],
                    //               color: Color(0xFFDDDFE4),
                    //               strokeWidth: 2,
                    //               padding: EdgeInsets.symmetric(
                    //                   vertical: 0, horizontal: 0),
                    //               child: RoundEdgedButton(
                    //                 text: '8',
                    //                 textColor: Color(0xFF095A0B),
                    //                 fontSize: 16,
                    //                 fontfamily: 'regular',
                    //                 height: 40,
                    //                 borderRadius: 8,
                    //                 horizontalMargin: 2.5,
                    //                 verticalMargin: 0,
                    //                 // verticalPadding: 10,
                    //               ),
                    //             )
                    //           ],
                    //         )),
                    //     hSizedBox,
                    //     Expanded(
                    //         flex: 2,
                    //         child: Column(
                    //           children: [
                    //             DottedBorder(
                    //               borderType: BorderType.RRect,
                    //               radius: Radius.circular(8),
                    //               dashPattern: [5, 5],
                    //               color: Color(0xFFDDDFE4),
                    //               strokeWidth: 2,
                    //               padding: EdgeInsets.symmetric(
                    //                   vertical: 0, horizontal: 0),
                    //               child: RoundEdgedButton(
                    //                 text: '12',
                    //                 textColor: Color(0xFF095A0B),
                    //                 fontSize: 16,
                    //                 fontfamily: 'regular',
                    //                 verticalPadding: 8,
                    //                 height: 40,
                    //                 borderRadius: 8,
                    //                 horizontalMargin: 2.5,
                    //                 // verticalPadding: 8,
                    //               ),
                    //             )
                    //           ],
                    //         )),
                    //   ],
                    // ),
                  ],
                ),
              ),
              vSizedBox,
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFF4F4F6)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 2.3),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (currentPosition <= 2) {
                            if (filledValues.isEmpty ||
                                filledValues.length <= currentPosition) {
                              filledValues.add(shuffledPassPhrase[index]);
                            } else {
                              filledValues[currentPosition] =
                                  shuffledPassPhrase[index];
                            }
                            setState(() {
                              currentPosition++;
                            });
                          } else {
                            print('cuuuuuuuu');
                          }
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              '${shuffledPassPhrase[index]}',
                              style: TextStyle(
                                fontFamily: 'regular',
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // child: Column(
                  //   children: [
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Expanded(
                  //             flex:2,
                  //             child: Column(
                  //               children: [
                  //                 RoundEdgedButton(
                  //                   text: '1.then',
                  //                   textColor: Color(0xFF095A0B),
                  //                   fontSize: 16,
                  //                   fontfamily: 'regular',
                  //                   verticalPadding: 12,
                  //                   height: 40,
                  //                   borderRadius: 8,
                  //                 ),
                  //               ],
                  //             )
                  //         ),
                  //         hSizedBox,
                  //         Expanded(
                  //             flex:2,
                  //             child: Column(
                  //               children: [
                  //                 RoundEdgedButton(
                  //                   text: '2. vacant',
                  //                   textColor: Color(0xFF095A0B),
                  //                   fontSize: 14,
                  //                   fontfamily: 'regular',
                  //                   verticalPadding: 12,
                  //                   height: 40,
                  //                   borderRadius: 8,
                  //                 ),
                  //               ],
                  //             )
                  //         ),
                  //         hSizedBox,
                  //         Expanded(
                  //             flex:2,
                  //             child: Column(
                  //               children: [
                  //                 RoundEdgedButton(
                  //                   text: '3. girl',
                  //                   textColor: Color(0xFF095A0B),
                  //                   fontSize: 16,
                  //                   fontfamily: 'regular',
                  //                   verticalPadding: 12,
                  //                   height: 40,
                  //                   borderRadius: 8,
                  //                 ),
                  //               ],
                  //             )
                  //         ),
                  //       ],
                  //     ),
                  //     vSizedBox2,
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Expanded(
                  //             flex:2,
                  //             child: Column(
                  //               children: [
                  //                 RoundEdgedButton(
                  //                   text: '4. exist',
                  //                   textColor: Color(0xFF095A0B),
                  //                   fontSize: 16,
                  //                   fontfamily: 'regular',
                  //                   verticalPadding: 12,
                  //                   height: 40,
                  //                   borderRadius: 8,
                  //                 ),
                  //               ],
                  //             )
                  //         ),
                  //         hSizedBox,
                  //         Expanded(
                  //             flex:2,
                  //             child: Column(
                  //               children: [
                  //                 RoundEdgedButton(
                  //                   text: '5. avoid',
                  //                   textColor: Color(0xFF095A0B),
                  //                   fontSize: 16,
                  //                   fontfamily: 'regular',
                  //                   verticalPadding: 12,
                  //                   height: 40,
                  //                   borderRadius: 8,
                  //                 ),
                  //               ],
                  //             )
                  //         ),
                  //        hSizedBox,
                  //         Expanded(
                  //             flex:2,
                  //             child: Column(
                  //               children: [
                  //                 RoundEdgedButton(
                  //
                  //                   text: '6. usage',
                  //                   textColor: Color(0xFF095A0B),
                  //                   fontSize: 16,
                  //                   fontfamily: 'regular',
                  //                   verticalPadding: 12,
                  //                   height: 40,
                  //                   borderRadius: 8,
                  //                 ),
                  //               ],
                  //             )
                  //         ),
                  //       ],
                  //     ),
                  //     vSizedBox2,
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Expanded(
                  //             flex:2,
                  //             child: Column(
                  //               children: [
                  //                 RoundEdgedButton(
                  //
                  //                   text: '7. ride',
                  //                   textColor: Color(0xFF095A0B),
                  //                   fontSize: 16,
                  //                   fontfamily: 'regular',
                  //                   verticalPadding: 12,
                  //                   height: 40,
                  //                   borderRadius: 8,
                  //                 ),
                  //               ],
                  //             )
                  //         ),
                  //         hSizedBox,
                  //         Expanded(
                  //             flex:2,
                  //             child: Column(
                  //               children: [
                  //                 RoundEdgedButton(
                  //                   text: '8. alien',
                  //                   textColor: Color(0xFF095A0B),
                  //                   fontSize: 16,
                  //                   fontfamily: 'regular',
                  //                   verticalPadding: 12,
                  //                   height: 40,
                  //                   borderRadius: 8,
                  //                 ),
                  //               ],
                  //             )
                  //         ),
                  //         hSizedBox,
                  //         Expanded(
                  //             flex:2,
                  //             child: Column(
                  //               children: [
                  //                 RoundEdgedButton(
                  //
                  //                   text: '9. comic',
                  //                   textColor: Color(0xFF095A0B),
                  //                   fontSize: 16,
                  //                   fontfamily: 'regular',
                  //                   verticalPadding: 12,
                  //                   height: 40,
                  //                   borderRadius: 8,
                  //                 ),
                  //               ],
                  //             )
                  //         ),
                  //       ],
                  //     ),
                  //     vSizedBox2,
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Expanded(
                  //             flex:2,
                  //             child: Column(
                  //               children: [
                  //                 RoundEdgedButton(
                  //                   color: Colors.white,
                  //                   text: '10. cross',
                  //                   textColor: Color(0xFF095A0B),
                  //                   fontSize: 16,
                  //                   fontfamily: 'regular',
                  //                   verticalPadding: 12,
                  //                   height: 40,
                  //                   borderRadius: 8,
                  //                 ),
                  //               ],
                  //             )
                  //         ),
                  //         hSizedBox,
                  //         Expanded(
                  //             flex:2,
                  //             child: Column(
                  //               children: [
                  //                 RoundEdgedButton(
                  //                   text: '11. upon',
                  //                   textColor: Color(0xFF095A0B),
                  //                   fontSize: 16,
                  //                   fontfamily: 'regular',
                  //                   verticalPadding: 12,
                  //                   height: 40,
                  //                   borderRadius: 8,
                  //                 ),
                  //               ],
                  //             )
                  //         ),
                  //         hSizedBox,
                  //         Expanded(
                  //             flex:2,
                  //             child: Column(
                  //               children: [
                  //                 RoundEdgedButton(
                  //                   text: '12. huba',
                  //                   textColor: Color(0xFF095A0B),
                  //                   fontSize: 16,
                  //                   fontfamily: 'regular',
                  //                   verticalPadding: 12,
                  //                   height: 40,
                  //                   borderRadius: 8,
                  //                 ),
                  //               ],
                  //             )
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RoundEdgedButton(
              text:translate("secure_account_step_two.continueBtn"),
              textColor: Colors.white,
              verticalMargin: 20,
              color: filledValues.length == 3
                  ? MyColors.primaryColor
                  : Colors.grey.shade300,
              borderRadius: 12,
              width: MediaQuery.of(context).size.width - 32,
              fontSize: 16,
              horizontalMargin: 16,
              fontfamily: 'medium',
              onTap: filledValues.length != 3
                  ? null: () {
                print(filledValues);
                int matched = 0;
                for(int i = 0;i<3;i++){
                  print('______________');
                  print(filledValues[i]);
                  print(widget.passPhrase[chooseFromNumbers[i]]);
                  print(chooseFromNumbers[i]);
                  if(filledValues[i]==widget.passPhrase[chooseFromNumbers[i]]){
                    matched++;
                  }
                }
                print(widget.passPhrase);
                print(chooseFromNumbers);
                print('words matched $matched');
                if(matched==3){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePassword(passPhrase: widget.passPhrase,)));
                }
                else{
                  noOfAttemptsLeft--;
                  if(noOfAttemptsLeft<=0) {
                    showSnackbar(context, translate("secure_account_step_two.maximumAttempt"));
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>EntroPage()), (route) => route.isFirst);
                  }
                  else{
                    showSnackbar(context,translate("secure_account_step_two.attemptsLeft"));
                    setState(() {
                      currentPosition = 0;
                      filledValues.clear();
                    });
                  }



                }
                // Navigator.pushNamed(context, CreatePassword.id);
              },
            ),
          )
        ],
      ),
    );
  }
}
