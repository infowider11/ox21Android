
import 'package:flutter/material.dart';

Future<T?> showCustomBottomSheet<T>(
  BuildContext context, {
  double height = 200,
      required Widget child,

}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: height + MediaQuery.of(context).viewInsets.bottom,
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: child,
        );
      });
}
