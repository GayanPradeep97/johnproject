import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:johnproject/screens/admin_page.dart';
import 'package:johnproject/utility/app_colors.dart';
import 'package:johnproject/utility/constant.dart';
import 'package:johnproject/utility/uttility_function.dart';
//import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../components/customdrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaycolor,
      appBar:
          AppBar(backgroundColor: primaycolor, elevation: 10, actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Show Snac',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search Your catagory')));
          },
        ),
      ]),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          Expanded(
              child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                width: size.width - 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 130,
                      child: Image.asset(
                        Constants.imageAsset('first.jpg'),
                      ),
                    ),
                    Container(
                      //color: Colors.black,
                      width: 50,
                      child: const Text(
                        'A0100-120X40',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox()
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
