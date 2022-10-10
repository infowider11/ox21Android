import 'package:flutter/material.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/widgets/CustomTexts.dart';
class HomePageCard extends StatelessWidget {
  const HomePageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            MyImages.add_playlist
          ),
          fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Column(
                children: [
                  SubHeadingText(text: 'Lorem Ipsum'),
                  ParagraphText(text: 'kl okljfsd oljnv dsk dkgn kfjgndk fgkn'),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
