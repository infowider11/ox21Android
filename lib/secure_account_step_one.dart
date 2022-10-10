import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/constant_words.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/secure_account_step_next.dart';
import 'package:ox21/secure_account_step_two.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:flutter_translate/flutter_translate.dart';

class Step_one extends StatefulWidget {
  static const String id = "step1";
  const Step_one({Key? key}) : super(key: key);

  @override
  State<Step_one> createState() => _Step_oneState();
}

class _Step_oneState extends State<Step_one> {
  bool viewVisible = true;
  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  List<String> phrasevalues = [];

  bool load = false;

  getPassPhraseValues() {
    phrasevalues.clear();
    Random random = Random();

    print('getting passphrase values');
    for (int i = 0; i < 12; i++) {
      String word = words[random.nextInt(words.length)];
      print(word);
      addWord(word);
    }
  }

  addWord(String word) {
    if (!phrasevalues.contains(word)) {
      phrasevalues.add(word);
    } else {
      word = words[Random().nextInt(words.length - 1)];
      addWord(word);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getPassPhraseValues();
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
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ParagraphText(
                    text: translate("secure_account_step_one.title"),
                    fontSize: 18,
                    fontFamily: 'bold',
                  ),
                ),
                vSizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ParagraphText(
                    text:
                    translate("secure_account_step_one.subTitle"),
                    fontSize: 16,
                    fontFamily: 'regular',
                    color: MyColors.textcolor,
                  ),
                ),
                vSizedBox,
                Container(
                  child: Stack(
                    children: [
                      Container(
                        // height: 600,
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFF4F4F6)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        // child: Column(
                        //   children:
                        //   // generateGrid(),
                        //
                        //   [
                        //
                        //
                        //   Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Expanded(
                        //         flex:2,
                        //           child: Column(
                        //             children: [
                        //               RoundEdgedButton(
                        //                 text: '1.then',
                        //                 textColor: Color(0xFF000000),
                        //                 fontSize: 16,
                        //                 fontfamily: 'regular',
                        //                 verticalPadding: 12,
                        //                 height: 40,
                        //                 borderRadius: 8,
                        //                 horizontalMargin: 2.5,
                        //                 // isSolid:false
                        //               ),
                        //             ],
                        //           )
                        //       ),
                        //       vSizedBox,
                        //       Expanded(
                        //           flex:2,
                        //           child: Column(
                        //             children: [
                        //               RoundEdgedButton(
                        //                 text: '2. vacant',
                        //                 textColor: Color(0xFF090A0B),
                        //                 fontSize: 14,
                        //                 fontfamily: 'regular',
                        //                 verticalPadding: 12,
                        //                 height: 40,
                        //                 borderRadius: 8,
                        //                 horizontalMargin: 2.5,
                        //               ),
                        //             ],
                        //           )
                        //       ),
                        //       vSizedBox,
                        //       Expanded(
                        //           flex:2,
                        //           child: Column(
                        //             children: [
                        //               RoundEdgedButton(
                        //                 text: '3. girl',
                        //                 textColor: Color(0xFF090A0B),
                        //                 fontSize: 16,
                        //                 fontfamily: 'regular',
                        //                 verticalPadding: 12,
                        //                 height: 40,
                        //                 borderRadius: 8,
                        //                 horizontalMargin: 2.5,
                        //               ),
                        //             ],
                        //           )
                        //       ),
                        //     ],
                        //   ),
                        //   SizedBox(height: 16,),
                        //   Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Expanded(
                        //         flex:2,
                        //           child: Column(
                        //             children: [
                        //               RoundEdgedButton(
                        //                 text: '4. exist',
                        //                 textColor: Color(0xFF090A0B),
                        //                 fontSize: 16,
                        //                 fontfamily: 'regular',
                        //                 verticalPadding: 12,
                        //                 height: 40,
                        //                 borderRadius: 8,
                        //                 horizontalMargin: 2.5,
                        //               ),
                        //             ],
                        //           )
                        //       ),
                        //       vSizedBox,
                        //       Expanded(
                        //           flex:2,
                        //           child: Column(
                        //             children: [
                        //               RoundEdgedButton(
                        //                 text: '5. avoid',
                        //                 textColor: Color(0xFF090A0B),
                        //                 fontSize: 16,
                        //                 fontfamily: 'regular',
                        //                 verticalPadding: 12,
                        //                 height: 40,
                        //                 borderRadius: 8,
                        //                 horizontalMargin: 2.5,
                        //               ),
                        //             ],
                        //           )
                        //       ),
                        //       vSizedBox,
                        //       Expanded(
                        //           flex:2,
                        //           child: Column(
                        //             children: [
                        //               RoundEdgedButton(
                        //                 text: '6. usage',
                        //                 textColor: Color(0xFF090A0B),
                        //                 fontSize: 16,
                        //                 fontfamily: 'regular',
                        //                 verticalPadding: 12,
                        //                 height: 40,
                        //                 borderRadius: 8,
                        //                 horizontalMargin: 2.5,
                        //               ),
                        //             ],
                        //           )
                        //       ),
                        //     ],
                        //   ),
                        //     SizedBox(height: 16,),
                        //   Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Expanded(
                        //         flex:2,
                        //           child: Column(
                        //             children: [
                        //               RoundEdgedButton(
                        //                 text: '7. ride',
                        //                 textColor: Color(0xFF090A0B),
                        //                 fontSize: 16,
                        //                 fontfamily: 'regular',
                        //                 verticalPadding: 12,
                        //                 height: 40,
                        //                 borderRadius: 8,
                        //                 horizontalMargin: 2.5,
                        //               ),
                        //             ],
                        //           )
                        //       ),
                        //       vSizedBox,
                        //       Expanded(
                        //           flex:2,
                        //           child: Column(
                        //             children: [
                        //               RoundEdgedButton(
                        //                 text: '8. alien',
                        //                 textColor: Color(0xFF090A0B),
                        //                 fontSize: 16,
                        //                 fontfamily: 'regular',
                        //                 verticalPadding: 12,
                        //                 height: 40,
                        //                 borderRadius: 8,
                        //                 horizontalMargin: 2.5,
                        //               ),
                        //             ],
                        //           )
                        //       ),
                        //       vSizedBox,
                        //       Expanded(
                        //           flex:2,
                        //           child: Column(
                        //             children: [
                        //               RoundEdgedButton(
                        //                 text: '9. comic',
                        //                 textColor: Color(0xFF090A0B),
                        //                 fontSize: 16,
                        //                 fontfamily: 'regular',
                        //                 verticalPadding: 12,
                        //                 height: 40,
                        //                 borderRadius: 8,
                        //                 horizontalMargin: 2.5,
                        //               ),
                        //             ],
                        //           )
                        //       ),
                        //     ],
                        //   ),
                        //     SizedBox(height: 16,),
                        //   Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Expanded(
                        //         flex:2,
                        //           child: Column(
                        //             children: [
                        //               RoundEdgedButton(
                        //                 text: '10. cross',
                        //                 textColor: Color(0xFF090A0B),
                        //                 fontSize: 16,
                        //                 fontfamily: 'regular',
                        //                 verticalPadding: 12,
                        //                 height: 40,
                        //                 borderRadius: 8,
                        //                 horizontalMargin: 2.5,
                        //               ),
                        //             ],
                        //           )
                        //       ),
                        //       vSizedBox,
                        //       Expanded(
                        //           flex:2,
                        //           child: Column(
                        //             children: [
                        //               RoundEdgedButton(
                        //                 text: '11. upon',
                        //                 textColor: Color(0xFF090A0B),
                        //                 fontSize: 16,
                        //                 fontfamily: 'regular',
                        //                 verticalPadding: 12,
                        //                 height: 40,
                        //                 borderRadius: 8,
                        //                 horizontalMargin: 2.5,
                        //               ),
                        //             ],
                        //           )
                        //       ),
                        //       vSizedBox,
                        //       Expanded(
                        //           flex:2,
                        //           child: Column(
                        //             children: [
                        //               RoundEdgedButton(
                        //                 text: '12. huba',
                        //                 textColor: Color(0xFF090A0B),
                        //                 fontSize: 16,
                        //                 fontfamily: 'regular',
                        //                 verticalPadding: 12,
                        //                 height: 40,
                        //                 borderRadius: 8,
                        //                 horizontalMargin: 2.5,
                        //               ),
                        //             ],
                        //           )
                        //       ),
                        //     ],
                        //   ),
                        //   ],
                        // ),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 2.3),
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}. ${phrasevalues[index]}',
                                  style: TextStyle(
                                    fontFamily: 'regular',
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                          child: Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: viewVisible,

                        child: Container(
                          height: 242,
                          clipBehavior: Clip.antiAlias,
                          width: MediaQuery.of(context).size.width,
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                          child: BackdropFilter(
                            filter:
                            ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0,),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: hideWidget,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    MyImages.eyecross,
                                    width: 40,

                                  ),
                                  vSizedBox2,
                                  ParagraphText(
                                    text: translate("secure_account_step_one.tapContainerTitle"),
                                    fontFamily: 'bold',
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  vSizedBox,
                                  ParagraphText(
                                    text: translate("secure_account_step_one.tapContainerSubTitle"),
                                    fontFamily: 'regular',
                                    fontSize: 14,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                vSizedBox4,
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RoundEdgedButton(
              verticalMargin: 20,
              text: translate("secure_account_step_one.continueBtn"),
              textColor: Colors.white,
              color:viewVisible?Colors.grey.shade300: MyColors.primaryColor,
              borderRadius: 12,
              width: MediaQuery.of(context).size.width - 32,
              fontSize: 16,
              horizontalMargin: 16,
              fontfamily: 'medium',
              onTap:viewVisible?null: () {
                // Navigator.pushNamed(context, Step_nextPage.id);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Step_two(
                              passPhrase: phrasevalues,
                            )));
              },
            ),
          ),
        ],
      ),
    );
  }
  //
  // List<Widget> generateGrid() {
  //   List<Widget> wdg = [];
  //   for (var i = 1; i <= rows; i++) {
  //     Widget m = Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Expanded(
  //               flex: 2,
  //               child: Column(
  //                   children: generateBlocks(i)))
  //         ]);
  //     wdg.add(m);
  //     wdg.add(vSizedBox);
  //   };
  //
  //   return wdg;
  // }
  //
  //
  // List<Widget> generateBlocks(i) {
  //   List<Widget> wdg = [];
  //   for(var j = 1; j <= columns; j++){
  //     Widget m = PhraseInput(
  //       text: '${i + j - 1}. ${(i - 1) * j +
  //           j }',
  //       textColor: Color(0xFF000000),
  //       fontSize: 16,
  //       fontfamily: 'regular',
  //       verticalPadding: 12,
  //     );
  //     wdg.add(m);
  //     wdg.add(vSizedBox);
  //   }
  //
  //   return wdg;
  // }
}
