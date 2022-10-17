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

  //navigation function push and remove
  static void pushRemoveNavigator(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }
}
