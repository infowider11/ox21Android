import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';


import 'CustomTexts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final BoxBorder? border;
  final bool horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final Color inputbordercolor;
  final Color hintcolor;
  final double fontsize;
  final double left;
  final double verticalPadding;
  final String? prefixIcon;
  final Widget? prefix;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? errorText;
  final bool? enabled;
  final bool showBorder;
  CustomTextField({
    Key? key,
    required this.controller,
    this.keyboardType,
    required this.hintText,
    this.border,
    this.maxLines,
    this.showBorder = true,
    this.horizontalPadding = false,
    // this.verticalPadding = false,
    this.obscureText = false,
    this.bgColor = Colors.transparent,
    this.inputbordercolor = Colors.transparent,
    this.hintcolor = Colors.black,
    this.verticalPadding = 4,
    this.fontsize = 16,
    this.left = 10,
    this.prefixIcon,
    this.prefix,
    this.onChanged,
    this.textAlign = TextAlign.left,
    this.errorText,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 76,
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding ? 16 : 0, vertical: verticalPadding),
      decoration: BoxDecoration(
          color: bgColor,
          border: showBorder?(border?? Border.all(color: MyColors.inputbordercolor.withOpacity(0.4))):null,
          // border: Border,
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.only(left: left, bottom: 5, top: 5),
      child: TextField(
        style: TextStyle(color: Colors.black, fontSize: fontsize),
        maxLines: maxLines ?? 1,
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlign: textAlign,
        // textAlignVertical: TextAlignVertical.center,
        enabled: enabled,

        decoration: InputDecoration(
          errorText: errorText,
          hintText: hintText,
          isDense: true,
          hintStyle: TextStyle(fontSize: fontsize, color: hintcolor,),
          // border: InputBorder.none ,
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: inputbordercolor)
          // ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: inputbordercolor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: inputbordercolor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: inputbordercolor),
          ),

          prefixIcon:prefix??(prefixIcon==null?null:
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              prefixIcon!,
              width: 10,
              height: 10,
              fit: BoxFit.fitHeight,
            ),
          )),
        ),
      ),
    );
  }
}

class CustomTextFieldlabel extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labeltext;
  final BoxBorder? border;
  final bool horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final Color inputbordercolor;
  // final Color labelcolor;
  final Color hintcolor;
  final double fontsize;
  final double left;
  final double verticalPadding;
  final double paddingsuffix;
  final double borderRadius;
  final String? prefixIcon;
  final String? suffixIcon;
  final IconButton? suffixIconButton;
  final IconData? icon;
  final TextAlign textAlign;
  final Function(String value)? onChanged;
  CustomTextFieldlabel({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labeltext,
    this.border,
    this.maxLines,
    this.horizontalPadding = false,
    // this.verticalPadding = false,
    this.obscureText = false,
    this.suffixIconButton,
    this.bgColor = Colors.transparent,
    this.inputbordercolor = Colors.transparent,
    // this.labelcolor = Colors.white12,
    this.hintcolor = Colors.black,
    this.verticalPadding = 4,
    this.paddingsuffix = 12,
    this.borderRadius = 8,
    this.fontsize = 16,
    this.left = 10,
    this.prefixIcon,
    this.suffixIcon,
    this.icon,
    this.textAlign = TextAlign.left,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding ? 16 : 0, vertical: verticalPadding),
      decoration: BoxDecoration(
          color: bgColor,
          border: border?? Border.all(color: MyColors.inputbordercolor),
          // border: Border,
          borderRadius: BorderRadius.circular(borderRadius)),
      padding: EdgeInsets.only(left: left,top: 4),
      child: TextField(
        style: TextStyle(color: Colors.black, fontSize: fontsize),
        onChanged: onChanged,
        maxLines: maxLines ?? 1,
        controller: controller,
        obscureText: obscureText,
        textAlign: textAlign,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: fontsize, color: hintcolor,),
          // border: InputBorder.none ,
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: inputbordercolor)
          // ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: inputbordercolor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: inputbordercolor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: inputbordercolor),
          ),
          icon: icon==null?null:Icon(icon),
          prefixIcon:prefixIcon==null?null:
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              prefixIcon!,
              width: 10,
              height: 10,
              fit: BoxFit.fitHeight,
            ),
          ),
          suffixIcon:suffixIconButton!=null?suffixIconButton: suffixIcon==null?null:
          Padding(
            padding: EdgeInsets.all(paddingsuffix),
            child: Image.asset(
              suffixIcon!,
              // color: Colors.black,
              width: 10,
              height: 10,
              fit: BoxFit.fitHeight,
            ),
          ),
          labelText: labeltext,
          labelStyle: TextStyle(
            color: Color(0xFFAFB4C0),
          )
        ),
      ),
    );
  }
}

class CustomTextFieldapply extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final BoxBorder? border;
  final bool horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final double verticalPadding;
  final String? prefixIcon;
  final TextAlign textAlign;
  CustomTextFieldapply({
    Key? key,
    required this.controller,
    required this.hintText,
    this.border,
    this.maxLines,
    this.horizontalPadding = false,
    // this.verticalPadding = false,
    this.obscureText = false,
    this.bgColor = MyColors.whiteColor,
    this.verticalPadding = 4,
    this.prefixIcon,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48,
        width: double.infinity,
        margin: EdgeInsets.symmetric(
            horizontal: horizontalPadding ? 16 : 0, vertical: verticalPadding),
        decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: MyColors.primaryColor),
            // border: Border,
            borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(
              child: TextField(

                maxLines: maxLines ?? 1,
                controller: controller,
                obscureText: obscureText,
                textAlign: textAlign,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: 16),
                  border: InputBorder.none,
                  prefixIcon:prefixIcon==null?null:
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      prefixIcon!,
                      width: 10,
                      height: 10,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(onPressed: (){},
                child: Text('apply',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15
                  ),
                )
            )
          ],
        )


    );
  }
}

class CustomTextFields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final BoxBorder? border;
  final bool horizontalPadding;
  final bool obscureText;
  final int? maxLines;
  final Color bgColor;
  final double verticalPadding;
  final String? prefixIcon;
  const CustomTextFields({
    Key? key,
    required this.controller,
    required this.hintText,
    this.border,
    this.maxLines,
    this.horizontalPadding = false,
    this.obscureText = false,
    this.bgColor = MyColors.whiteColor,
    this.verticalPadding = 8,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: horizontalPadding ? 16 : 0, vertical: verticalPadding),
      decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: MyColors.primaryColor),
          // border: Border,
          borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.only(left: 10),
      child: TextField(
        maxLines: maxLines ?? 1,
        controller: controller,
        obscureText: obscureText,
        // textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 13),
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Image.asset(
              'assets/images/user.png',
              width: 10,
              height: 10,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldEditProfile extends StatelessWidget {
  final TextEditingController controller;
  final String headingText;
  final String hintText;
  const CustomTextFieldEditProfile({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.headingText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubHeadingText(text: headingText),
          TextField(
            controller: controller,
            decoration: InputDecoration(hintText: hintText,
                hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                )
            ),
          )
        ],
      ),
    );
  }
}
