import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/pages/my_subscribed_channels_page.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customtextfield.dart';

class TopBannerBidPage extends StatefulWidget {
  static const String id="TopBannerBidPage";
  const TopBannerBidPage({Key? key}) : super(key: key);

  @override
  _TopBannerBidPageState createState() => _TopBannerBidPageState();
}

class _TopBannerBidPageState extends State<TopBannerBidPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController channelController = TextEditingController();
  TextEditingController thoughtsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Top Banner Bid'),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox2,
              Row(
                children: [
                  ParagraphText(text: 'Channel Selected: '),
                  SubHeadingText(text: 'Spa/Beauty'),
                ],
              ),
              vSizedBox2,
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(
                          MyImages.spaBeauty,
                        ),
                        fit: BoxFit.cover)),
              ),
              vSizedBox2,
              Container(
                height: 24,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SubHeadingText(text: 'Select Page Number:', fontSize: 12,),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            // height: 16,
                            width: 24,
                            decoration: BoxDecoration(
                              color:
                                  index == 5 ? MyColors.secondary : Colors.grey,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 10,
                                    color: index == 5
                                        ? Colors.white
                                        : MyColors.darkbackcolor),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              vSizedBox2,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ParagraphText(text: 'Status',fontSize: 10,),
                      ParagraphText(
                        text: 'Open',
                        color: MyColors.secondary,
                        fontSize: 10,
                      ),
                      hSizedBox,
                      ParagraphText(text: 'Time Remaining:',fontSize: 10,),
                      ParagraphText(text: '2 Days', fontSize: 10,),
                    ],
                  ),
                  Row(
                    children: [
                      SubHeadingText(text: 'Minimum Bid: ', fontSize: 10,),
                      ParagraphText(text: '500 JIN', fontSize: 10,),
                    ],
                  ),
                ],
              ),
              vSizedBox2,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainHeadingText(
                          text: 'SPA/Beauty',
                          color: MyColors.secondary,
                        ),
                        ParagraphText(
                          text: 'Mar 03 - Mar 13',
                          color: MyColors.black54Color,
                        )
                      ],
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: RoundEdgedButton(
                      textColor: Colors.white,
                      text: 'Purchase Now',
                      color: MyColors.secondary,
                      fontSize: 12,
                      fontfamily: 'medium',
                      onTap: (){
                        Navigator.pushNamed(context, MySubscribedChannels.id);
                      },
                    ),
                  ),
                ],
              ),
              vSizedBox2,
              CustomDivider(),
              SubHeadingText(text: 'Leaderboard'),
              vSizedBox2,
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: MyColors.secondary.withOpacity(0.2),
                      gradient: LinearGradient(colors: [
                        Color(0xFFF6F6F6),
                        Color(0xFF42E8E0),
                      ]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              image: DecorationImage(
                                  image: AssetImage(
                                    MyImages.femaleAvatar,
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        hSizedBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SubHeadingText(
                                text: 'Daniel Joseph',
                                color: MyColors.hintcolor,
                              ),
                              ParagraphText(
                                text: 'abc',
                                color: MyColors.hintcolor,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ParagraphText(
                                text: '20th Feb',
                                color: MyColors.black54Color,
                              ),
                              SubHeadingText(
                                text: '1200 OX21coins',
                                color: MyColors.secondary,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
