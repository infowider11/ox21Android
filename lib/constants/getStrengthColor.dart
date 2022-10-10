import 'package:ox21/constants/global_constants.dart';
import 'package:flutter/material.dart';
Color getStrengthColor(String message){
  if(message==passwordStrength[0]){
    return Colors.red;
  }else if(message==passwordStrength[1]){
    return Colors.orange;
  }
  else if(message==passwordStrength[2]){
    return Colors.green;
  }
  else if(message==passwordStrength[3]){
    return Colors.green;
  } else {
    return Colors.brown;
  }
}