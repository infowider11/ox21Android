import 'package:flutter/material.dart';

import '../constants/colors.dart';
class CustomLoader extends StatelessWidget {
  final Color? color;
  const CustomLoader({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color:color?? MyColors.primaryColor,
      ),
    );
  }
}
