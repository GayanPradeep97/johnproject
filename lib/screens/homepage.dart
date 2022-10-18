import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:johnproject/models/item_model.dart';
import 'package:johnproject/screens/admin_page.dart';
import 'package:johnproject/utility/app_colors.dart';
import 'package:johnproject/utility/constant.dart';
import 'package:johnproject/utility/uttility_function.dart';
import 'package:johnproject/controller/item_controller.dart';
//import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../components/customdrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> initBackButton() async {
    //when in home screen if you try to exit it shows dialog box
    return await showDialog(
          context: context,
          builder: (context) => ElasticIn(
            child: AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Do you want to really exit an App'),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('No')),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'))
              ],
            ),
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: initBackButton,
      child: Scaffold(
        backgroundColor: primaycolor,
        appBar: AppBar(
            backgroundColor: primaycolor,
            elevation: 10,
            actions: <Widget>[
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
              child: StreamBuilder(
                stream: ItemController().getItemFromFirebase(),
                builder: (context, AsyncSnapshot<List<ItemModel>> snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => Container(
                            height: 20,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data![index].name;
                            return Card(
                              size: size,
                              model: snapshot.data![index],
                            );

                            // if (search.isEmpty) {
                            //   return ContactCard(
                            //     size: size,
                            //     model: snapshot.data![index],
                            //     num: snapshot.data!.length - index,
                            //   );
                            // } else if (data
                            //     .toString()
                            //     .startsWith(search.toLowerCase())) {
                            //   return ContactCard(
                            //     size: size,
                            //     model: snapshot.data![index],
                            //     num: snapshot.data!.length - index,
                            //   );
                            //}
                            //return Container();
                          },
                        );

                  // print("-------------");
                  // print(snapshot.data!.length);
                  // print("-------------");

                  // if (snapshot.hasData) {
                  //   return ListView.separated(
                  //     separatorBuilder: (context, index) => Container(
                  //       height: 20,
                  //     ),
                  //     physics: const BouncingScrollPhysics(),
                  //     itemCount: snapshot.data!.length,
                  //     itemBuilder: (context, index) {
                  //       return ContactCard(
                  //         size: size,
                  //         model: snapshot.data![index],
                  //         num: snapshot.data!.length - index,
                  //       );
                  //     },
                  //   );
                  // }
                  // else if (snapshot.hasError) {
                  //   return Center(
                  //     child: Text('Error fetching data: ' +
                  //         snapshot.error.toString()),
                  //   );
                  // } else {
                  //   return const Center(
                  //       child: CircularProgressIndicator());
                  // }
                },
              ),

              // ListView.separated(
              //   physics: const BouncingScrollPhysics(),
              //   itemCount: 10,
              //   separatorBuilder: (BuildContext context, int index) =>
              //       const Divider(),
              //   itemBuilder: (BuildContext context, int index) {
              // Card(size: size);
              //   },
              // ),
            )
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    Key? key,
    required this.size,
    required this.model,
  }) : super(key: key);

  final Size size;
  final ItemModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      width: size.width - 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 130,
            width: 200,
            child: Image.network(
              fit: BoxFit.fill,
              model.image.toString(),
              height: 295,
              width: 310,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Container(
                  height: 295,
                  width: 310,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
                );
              },
            ),
            // Image.asset(
            //   Constants.imageAsset('first.jpg'),
            // ),
          ),
          Container(
            //color: Colors.black,
            width: 50,
            child: Text(
              "${model.name.toString()}-\n${model.diamansion.toString()}",
              //'A0100-120X40',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox()
        ],
      ),
    );
  }
}
