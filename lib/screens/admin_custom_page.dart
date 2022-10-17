import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:johnproject/components/custom_dialog.dart';
import 'package:johnproject/providers/item_provider.dart';
import 'package:johnproject/screens/homepage.dart';
import 'package:johnproject/utility/constant.dart';
import 'package:johnproject/utility/uttility_function.dart';
import '../utility/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AdminCustomPage extends StatefulWidget {
  const AdminCustomPage({super.key});

  @override
  State<AdminCustomPage> createState() => _AdminCustomPageState();
}

class _AdminCustomPageState extends State<AdminCustomPage> {
  XFile? image;
  bool isselectimage = false;
  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      if (image != null) {
        isselectimage = true;
        //ItemProvider().setImage(File(image!.path));
      } else {
        isselectimage = false;
        Logger().i("No image selected");
      }
    });
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: primaycolor,
        appBar: AppBar(
          title: const Text('Add New Items'),
          backgroundColor: primaycolor,
        ),
        body: SingleChildScrollView(
          child: Consumer<ItemProvider>(builder: (context, value, child) {
            return Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Choose Your Photo',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: kWhite),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      myAlert();
                    },
                    child: const Text('Upload Photo'),
                  ),
                  const SizedBox(height: 20),
                  image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            //to show image, you type like this.
                            File(image!.path),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                          ),
                        )
                      : const Text(
                          "No Image",
                          style: TextStyle(fontSize: 15, color: kWhite),
                        ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Add Item Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: kWhite),
                  ),
                  Container(
                    width: Size.width,
                    child: TextField(
                      controller: value.nameController,
                      style: const TextStyle(),
                      //obscureText: true,
                      //controller: _password,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Item Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Dimensions',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: kWhite),
                  ),
                  SizedBox(
                    width: Size.width,
                    height: 100,
                    child: TextField(
                      style: const TextStyle(),
                      controller: value.diamentionController,
                      //obscureText: true,
                      //controller: _password,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Item Dimensions",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                      width: Size.width,
                      height: 65,
                      child: (value.isloding)
                          ? const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 145),
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                if (isselectimage) {
                                  value.startAddItemDetails(
                                      context, File(image!.path));
                                } else {
                                  CustomAwesomDialog().dialogBox(
                                      context,
                                      "Error...!",
                                      "Please upload photo...!",
                                      DialogType.ERROR);
                                }
                              },
                              child: const Text(
                                'Add Item',
                                style: TextStyle(fontSize: 20),
                              ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            UtilFunction.navigateTo(
                                context, const HomeScreen());
                          },
                          child: const Text(
                            'Go Back HomePage',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          )),
                    ],
                  )
                ],
              ),
            );
          }),
        ));
  }
}
