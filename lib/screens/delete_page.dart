import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:johnproject/components/custom_dialog.dart';
import 'package:johnproject/components/customdrawer.dart';
import 'package:johnproject/models/item_model.dart';
import 'package:johnproject/utility/app_colors.dart';
import 'package:johnproject/controller/item_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:johnproject/providers/item_provider.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class DelatePage extends StatefulWidget {
  const DelatePage({Key? key}) : super(key: key);

  @override
  State<DelatePage> createState() => _DelatePageState();
}

bool isclicked = false;

class _DelatePageState extends State<DelatePage> {
  String search = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaycolor,
      appBar: AppBar(
        backgroundColor: primaycolor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //SizedBox(width: 100),
            const Text("Delete Items"),

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
      //drawer: const CustomDrawer(),
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
                      hintText: "search",
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
                              var data = snapshot.data![index].name;
                              // return Card(
                              //   size: size,
                              //   model: snapshot.data![index],
                              // );

                              if (search.isEmpty) {
                                return Card(
                                  size: size,
                                  model: snapshot.data![index],
                                );
                              } else if (data
                                  .toString()
                                  .startsWith(search.toLowerCase())) {
                                return Card(
                                  size: size,
                                  model: snapshot.data![index],
                                );
                              }
                              return Container(
                                height: 0,
                              );
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
    return Column(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                // Image.asset(
                //   Constants.imageAsset('first.jpg'),
                // ),
              ),
              Column(
                children: [
                  Text(
                    "${model.catagory.toString()} \n ${model.name.toString()} \n ${model.diamansion.toString()} ",
                    //'A0100-120X40',
                    style: GoogleFonts.getFont('Poppins',
                        fontSize: 15, fontWeight: FontWeight.w500),
                    //style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () async {
                        await Provider.of<ItemProvider>(context, listen: false)
                            .deleteCard(model.id.toString());
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ))
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
    );
  }
}
