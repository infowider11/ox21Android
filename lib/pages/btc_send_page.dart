import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/pages/qr_code_page.dart';
import 'package:ox21/pages/search_domain_page.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';

class BTCSendPage extends StatefulWidget {
  static const String id = 'btc_send_page';
  const BTCSendPage({Key? key}) : super(key: key);

  @override
  _BTCSendPageState createState() => _BTCSendPageState();
}

class _BTCSendPageState extends State<BTCSendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        title: 'BTC SEND',
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, ScanQRCodePage.id);
            },
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset(MyImages.scan, height: 20,fit: BoxFit.fitHeight,),
            ),
          )
        ]
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  vSizedBox2,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubHeadingText(text: 'Transfer Amount'),
                      Row(
                        children: [
                          Image.asset(
                            MyImages.bitcoinLogo,
                            height: 20,
                            fit: BoxFit.fitHeight,
                          ),
                          SubHeadingText(text: 'BTC')
                        ],
                      )
                    ],
                  ),
                  vSizedBox2,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SubHeadingText(text: '0.00'),
                        ParagraphText(
                          text: '0.00',
                          color: MyColors.black54Color,
                        )
                      ],
                    ),
                  ),
                  CustomDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubHeadingText(text: 'Receiving Address'),
                      // Image.asset(
                      //   MyImages.contactsIcon,
                      //   height: 26,
                      //   fit: BoxFit.fitHeight,
                      // )
                    ],
                  ),
                  vSizedBox2,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SubHeadingText(text: ''),
                        ParagraphText(
                          text: '',
                          color: MyColors.black54Color,
                        )
                      ],
                    ),
                  ),
                  vSizedBox2,
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey.shade200,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    vSizedBox2,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubHeadingText(
                            text: 'Sending Address',
                            color: Colors.grey,
                          ),
                          vSizedBox,
                          ParagraphText(
                            text: '11PEEokWFSFNYshLfuLvZfMuPE93aMJd4',
                            color: MyColors.black54Color,
                          )
                        ],
                      ),
                    ),
                    vSizedBox2,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubHeadingText(
                            text: 'Minor Fee',
                            color: Colors.grey,
                          ),
                          Slider(
                            value: 0,
                            onChanged: (val) {},
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ParagraphText(
                                  text: 'Slow',
                                  color: MyColors.black54Color,
                                ),
                                ParagraphText(
                                  text: 'Fast',
                                  color: MyColors.black54Color,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    vSizedBox2,
                    Row(
                      children: [
                        Expanded(
                            child: RoundEdgedButton(
                          text: 'Confirm',
                          color: MyColors.secondary,
                          // color: Colors.grey.shade300,
                          // textColor: Colors.grey,
                              textColor: Colors.white,
                              onTap: (){
                            // Navigator.pushNamed(context, SearchDomainPage.id);
                              },
                        )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
