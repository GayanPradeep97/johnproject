import 'package:flutter/material.dart';
//import 'package:food_app/utility/app_colors.dart';
//import 'package:food_app/utility/constants.dart';
import 'package:johnproject/utility/app_colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kWhite,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xff838383),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red))),
      ),
    );
  }
}
