import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';

class MainHeadingText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final double? height;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  const MainHeadingText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textAlign,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color??Colors.black,
        // fontWeight:fontWeight??FontWeight.w500,
        fontSize: fontSize??20,
        // fontFamily:
        fontWeight: fontWeight?? FontWeight.bold,
        fontFamily: fontFamily,
        height: height,
        letterSpacing: 1,
      ),
    );
  }
}



class AppBarHeadingText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  const AppBarHeadingText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color??Colors.black,
          fontWeight:fontWeight??FontWeight.w500,
          fontSize: fontSize??22,
          // fontFamily:
          fontFamily: fontFamily
      ),
    );
  }
}

class SubHeadingText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign textAlign;
  final bool underlined;
  const SubHeadingText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textAlign=TextAlign.start,
    this.underlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: color??Colors.black,
          fontWeight:fontWeight??FontWeight.w500,
          fontSize: fontSize??16,
          // fontFamily:
          fontFamily: fontFamily??'bold',
        decoration:underlined? TextDecoration.underline:null,
      ),
    );
  }
}



class ParagraphText extends StatelessWidget {
  final String text;
  final double? letterspaceing;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final bool underlined;
  final int? maxLines;
  final TextOverflow? overflow;
  const ParagraphText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.letterspaceing,
    this.fontWeight,
    this.fontFamily,
    this.textAlign,
    this.overflow,
    this.maxLines,

    this.underlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign??TextAlign.start,
      maxLines: maxLines,
      style: TextStyle(
          color: color??Colors.black,
          fontWeight:fontWeight??FontWeight.w400,
          fontSize: fontSize??13,
          // fontFamily:
          fontFamily: fontFamily,
          decoration:underlined? TextDecoration.underline:null,
          letterSpacing: letterspaceing?? 0,
          overflow: overflow,

      ),
    );
  }
}

class CustomDivider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Divider(
      height: 40,
      thickness: 0.2,
      color:MyColors.black54Color,
    );
  }
}



TextStyle textFieldHintTextStyle = TextStyle(
  // color: MyColors.blackColor,
  color: MyColors.blackColor,
  fontSize: 13,
);

TextStyle textFieldTextStyle = TextStyle(
  // color: MyColors.blackColor,
  color: MyColors.blackColor,
  fontSize: 13,
);