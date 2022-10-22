import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:johnproject/models/item_model.dart';
import 'package:johnproject/screens/admin_page.dart';
import 'package:johnproject/utility/app_colors.dart';
import 'package:johnproject/utility/constant.dart';
import 'package:johnproject/utility/uttility_function.dart';
import 'package:johnproject/controller/item_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

//import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../components/customdrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool isclicked = false;

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
                    onPressed: () => SystemNavigator.pop(),
                    child: const Text('Yes'))
              ],
            ),
          ),
        ) ??
        false;
  }

  String search = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: initBackButton,
      child: Scaffold(
        backgroundColor: primaycolor,
        appBar: AppBar(
          backgroundColor: primaycolor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //SizedBox(width: 100),
              const Text("JOHN DECORATIUNI"),

              IconButton(
                  onPressed: () {
                    setState(() {
                      isclicked = true;
                    });
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          elevation: 5,
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              // width: 200,
              //height: 50,
              child: (!isclicked)
                  ? const SizedBox()
                  : TextField(
                      //controller: searchController,
                      onChanged: (text) {
                        setState(() {
                          search = text;
                        });
                      },
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        //prefixIcon: widget,
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Search",
                        //prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                search = "";
                                isclicked = false;
                              });
                            },
                            icon: const Icon(Icons.close)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                        // focusedBorder: OutlineInputBorder(
                        //     borderSide: BorderSide(color: Colors.black),
                        //     borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: ItemController().getItemFromFirebase(),
                builder: (context, AsyncSnapshot<List<ItemModel>> snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : (snapshot.data!.length == 0)
                          ? const Center(
                              child: Text(
                                "Empty",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : ListView.builder(
                              // separatorBuilder: (context, index) => Container(
                              //   height: 20,
                              // ),
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data![index].catagory;
                                var data1 = snapshot.data![index].name;
                                var data2 = snapshot.data![index].diamansion;

                                if (search.isEmpty) {
                                  return Card(
                                    catogry: snapshot.data![index],
                                    size: size,
                                    model: snapshot.data![index],
                                  );
                                } else if (data.toString().startsWith(search) ||
                                    data
                                        .toString()
                                        .startsWith(search.toUpperCase()) ||
                                    data
                                        .toString()
                                        .startsWith(search.toLowerCase()) ||
                                    data1.toString().startsWith(search) ||
                                    data1
                                        .toString()
                                        .startsWith(search.toUpperCase()) ||
                                    data1
                                        .toString()
                                        .startsWith(search.toLowerCase()) ||
                                    data2.toString().startsWith(search) ||
                                    data2
                                        .toString()
                                        .startsWith(search.toUpperCase()) ||
                                    data2
                                        .toString()
                                        .startsWith(search.toLowerCase())) {
                                  return Card(
                                    catogry: snapshot.data![index],
                                    size: size,
                                    model: snapshot.data![index],
                                  );
                                }
                                return const SizedBox();
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
    required this.catogry,
  }) : super(key: key);

  final Size size;
  final ItemModel model;
  final ItemModel catogry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //UtilFunction.navigateTo(context, DetailScreen(linkk: model.image));
        UtilFunction.navigateTo(
            context,
            ExamplePage(
              linkk: model.image,
              size: size,
            ));

        // Navigator.push(context, MaterialPageRoute(builder: (_) {
        //   return DetailScreen(linkk: model.image);
        // }));
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(10),
            //color: Colors.white,
            // width: size.width - 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
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
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      " ${model.catagory.toString()} \n ${model.name.toString()} \n ${model.diamansion.toString()} ",
                      //'A0100-120X40',
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 15, fontWeight: FontWeight.w500),
                      //style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    //TextButton(onPressed: () {}, child: const Text('Delete'))
                  ],
                ),
                const SizedBox(),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

// class DetailScreen extends StatelessWidget {
//   DetailScreen({required this.linkk});
//   String? linkk;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: GestureDetector(
//         child: Center(
//           child: Hero(
//             tag: 'imageHero',
//             child: Image.network(
//               linkk!,
//             ),
//           ),
//         ),
//         onTap: () {
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }
// }

class ExamplePage extends StatelessWidget {
  ExamplePage({required this.linkk, required this.size});
  String? linkk;
  Size size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PinchZoom(
        child: Center(
            child: Container(
                height: size.height / 2,
                width: size.width,
                color: Colors.black,
                child: Image.network(fit: BoxFit.fill, linkk!))),
        resetDuration: const Duration(seconds: 10),
        maxScale: 2.5,
        zoomEnabled: true,
        onZoomStart: () {
          print('Start zooming');
        },
        onZoomEnd: () {
          print('Stop zooming');
        },
      ),
    );
  }
}
