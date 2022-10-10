import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';

import 'CustomTexts.dart';

AppBar appBar(
    {String? title,
      Color appBarColor = Colors.transparent,
      Color titleColor = Colors.black,
      bool implyLeading = true,
      IconData backIcon = Icons.arrow_back_outlined,
      double fontsize = 16,
      double size = 20,
      double toolbarHeight = 70,
      // bool showTitleIcon = false,
      Widget? titleIcon,
      String badge = '0',
      String fontfamily = 'bold',
      required BuildContext context,
      List<Widget>? actions, leading}) {
  return AppBar(
    toolbarHeight: toolbarHeight,
    automaticallyImplyLeading: false,
    backgroundColor: appBarColor,

    elevation: 0,
    title: Row(
      children: [
        if(titleIcon!=null)
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: titleIcon,
        ),

        title == null
            ? Container()
            : Padding(
            padding: EdgeInsets.all(0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
            AppBarHeadingText(
              text: title,
              color: titleColor,
              fontSize: fontsize,
              fontFamily: fontfamily,
            ),
            if(badge!='0')
            Positioned(
                right: -25,
                top: 0,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 1),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ParagraphText(text: badge,color: MyColors.blackColor, fontSize: 12,fontWeight: FontWeight.bold,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    // AppBarHeadingText(
    //   text: title,
    //   color: titleColor,
    //   fontSize: fontsize,
    // ),
    // centerTitle: true,
    leading: implyLeading
        ? IconButton(
      icon:  Icon(
       backIcon,
        color: titleColor,
        size: size,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    )
        : leading,
    actions: actions,
  );
}