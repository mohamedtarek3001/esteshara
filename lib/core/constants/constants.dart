import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScreenSizing{

  static double height = 0;
  static double width = 0;

  static initScreenSizing(BuildContext context){
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }

}



class Helpers {
  static void showColoredToast({String? message, Color? color, Color? textColor}) {
    Fluttertoast.showToast(
      msg: message ?? 'No Toast',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: color,
      textColor: textColor ?? Colors.white,
    );
  }

}
