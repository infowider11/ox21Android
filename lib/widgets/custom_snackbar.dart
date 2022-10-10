import 'package:flutter/material.dart';

showSnackbar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text),
        // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        // behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 2900),
      )
  );
}