import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UtilFunction {
  
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  //goback
  static void goBackto(BuildContext context) {
    Navigator.of(context).pop();
  }
}
