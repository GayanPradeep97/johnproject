import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
      required this.text1,
      this.fontsize = 16,
      this.weight = FontWeight.w600,
      this.fontcolor = Colors.black})
      : super(key: key);

  final String text1;
  final double fontsize;
  final FontWeight weight;
  final Color fontcolor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text1,
      style: TextStyle(
        fontSize: fontsize,
        color: fontcolor,
        fontWeight: weight,
      ),
    );
  }
}
