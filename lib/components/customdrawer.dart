import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:johnproject/utility/app_colors.dart';
import 'package:johnproject/utility/uttility_function.dart';

import '../screens/admin_page.dart';
import '../utility/constant.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        UserAccountsDrawerHeader(
          decoration: const BoxDecoration(color: primaycolor),
          accountName: const Text('John'),
          accountEmail: const Text('ionapostol.com'),
          currentAccountPicture: CircleAvatar(
            radius: 80,
            backgroundColor: kWhite,
            child: Image.asset(
              Constants.imageAsset('logo.png'),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            UtilFunction.navigateTo(context, const MyLogin());
          },
          child: const Text(
            "Admin Page",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: "Streetbrush",
                color: Colors.black),
          ),
        )
      ]),
    );
  }
}
