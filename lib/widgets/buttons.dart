import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/sized_box.dart';


class RoundEdgedButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final double? fontSize;
  final String text;
  final String fontfamily;
  final Function()? onTap;
  final double horizontalMargin;
  final double verticalMargin;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final double width;
  final double? height;
  final String? image;
  // final Gradient? gradient;
  final bool isSolid;

  const RoundEdgedButton(
      {
        Key? key,
        this.color = MyColors.primaryColor,
        required this.text,
        this.textColor = Colors.white,
        this.borderRadius=15,
        this.onTap,
        this.fontSize,
        this.fontfamily = 'bold',
        this.horizontalMargin=0,
        this.verticalMargin=0,
        this.horizontalPadding=15,
        this.verticalPadding=0,
        // this.width= 100,
        this.width = double.infinity,
        this.height = 56,
        this.image,
        // required this.hasGradient,
        this.isSolid=true,

      }

      )
        : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin,vertical: verticalMargin),
        width: width,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: BoxDecoration(
          color:isSolid? color:Colors. white10,
          // gradient: hasGradient?gradient ??
          //     LinearGradient(
          //       colors: <Color>[
          //         Color(0xFF064964),
          //         Color(0xFF73E4D9),
          //       ],
          //     ):null,
          borderRadius:BorderRadius.circular(borderRadius),
          border:isSolid?null: Border.all(color: color, width: 1),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(image!=null)
              Image.asset(image!, height: 14,width: 20, fit: BoxFit.fitHeight, color: isSolid?textColor:color,),
              if(image!=null)
              hSizedBox05,
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:isSolid?textColor:color,
                    fontSize: fontSize??15,
                    fontFamily: fontfamily
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhraseInput extends StatelessWidget {
  final Color color;
  final Color textColor;
  final Color? backgroundColor;
  final double? fontSize;
  final String text;
  final String fontfamily;
  final Function()? onTap;
  final double horizontalMargin;
  final double verticalMargin;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final double width;
  final String? image;
  // final Gradient? gradient;
  // final bool isSolid;

  const PhraseInput(
      {
        Key? key,
        this.color = MyColors.secondary,
        required this.text,
        this.textColor =Colors.black,
        this.backgroundColor =MyColors.whiteColor,
        this.borderRadius=10,
        this.onTap,
        this.fontSize,
        this.fontfamily = 'bold',
        this.horizontalMargin=0,
        this.verticalMargin=0,
        this.horizontalPadding=15,
        this.verticalPadding=12,
        this.width = double.infinity,
        this.image,
        // required this.hasGradient,
        // this.isSolid=true,

      }

      )
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: verticalPadding==4?50:null,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin,vertical: verticalMargin),
        width: width,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [BoxShadow(color:Color(0xFFDDDDDD),offset:Offset.zero, blurRadius: 0.1, spreadRadius:0.1)],
          // gradient: hasGradient?gradient ??
          //     LinearGradient(
          //       colors: <Color>[
          //         Color(0xFF064964),
          //         Color(0xFF73E4D9),
          //       ],
          //     ):null,
          borderRadius:BorderRadius.circular(borderRadius),
          border:Border.all(color: Colors.white, width: 1),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if(image!=null)
                Image.asset(image!, height: 20, fit: BoxFit.fitHeight, color: textColor,),
              if(image!=null)
                hSizedBox,
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:textColor,
                      fontSize: fontSize??15,
                      fontFamily: fontfamily
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class RoundEdgedButtonred extends StatelessWidget {
  final Color color;
  final String text;
  final Function()? onTap;
  final double horizontalMargin;
  // final Gradient? gradient;
  final bool isSolid;

  const RoundEdgedButtonred(
      {Key? key,
        this.color = Colors.white,
        required this.text,
        this.onTap,
        this.horizontalMargin=0,
        // required this.hasGradient,
        this.isSolid=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color:isSolid? color:Colors.transparent,
          // gradient: hasGradient?gradient ??
          //     LinearGradient(
          //       colors: <Color>[
          //         Color(0xFF064964),
          //         Color(0xFF73E4D9),
          //       ],
          //     ):null,
          borderRadius: BorderRadius.circular(30),
          border:isSolid?null: Border.all(color: color),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color:isSolid? MyColors.whiteColor:color,
                fontSize: 18,
                fontFamily: 'semibold'
            ),
          ),
        ),
      ),
    );
  }
}



class TransparentButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function()? onTap;
  final double horizontalMargin;
  // final Gradient? gradient;
  final bool isSolid;

  const TransparentButton(
      {Key? key,
        this.color = Colors.white,
        required this.text,
        this.onTap,
        this.horizontalMargin=0,
        // required this.hasGradient,
        this.isSolid=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 32,vertical: 0),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        decoration: BoxDecoration(
          color:isSolid? color:Colors.transparent,
          // gradient: hasGradient?gradient ??
          //     LinearGradient(
          //       colors: <Color>[
          //         Color(0xFF064964),
          //         Color(0xFF73E4D9),
          //       ],
          //     ):null,
          borderRadius: BorderRadius.circular(30),
          border:isSolid?null: Border.all(color: color),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color:color,
              fontSize: 18,
              fontFamily: 'semibold'
          ),
        ),
      ),
    );
  }
}

class Borderbutton extends StatelessWidget {
  final Color color;
  final String text;
  final Function()? onTap;
  final double horizontalMargin;
  // final Gradient? gradient;
  final bool isSolid;

  const Borderbutton(
      {Key? key,
        this.color = Colors.white,
        required this.text,
        this.onTap,
        this.horizontalMargin=0,
        // required this.hasGradient,
        this.isSolid=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 32,vertical: 0),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color:isSolid? color:Colors.transparent,
          // gradient: hasGradient?gradient ??
          //     LinearGradient(
          //       colors: <Color>[
          //         Color(0xFF064964),
          //         Color(0xFF73E4D9),
          //       ],
          //     ):null,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: MyColors.primaryColor),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: MyColors.primaryColor,
              fontSize: 18,
              fontFamily: 'semibold'
          ),
        ),
      ),
    );
  }
}
