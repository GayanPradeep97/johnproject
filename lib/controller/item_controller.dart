import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:johnproject/models/item_model.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class ItemController {
  //Firestore instance create
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //create a collection reference
  CollectionReference itemDetails =
      FirebaseFirestore.instance.collection('itemDetails');

  Future<void> saveContactDetails(
    String name,
    String dimention,
    File img,
    String catagory,
  ) async {
    DateTime timeNow = DateTime.now();

    {
      UploadTask? task = uploadFile(img);
      final snapshot = await task!.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      Logger().i(downloadUrl);

      //get the unique document id auto genrator
      String docId = itemDetails.doc().id;

      await itemDetails.doc(docId).set({
        'name': name,
        'image': downloadUrl,
        'id': docId,
        'time': timeNow,
        'dimention': dimention,
        'catagory': catagory,
      });
    }

    //upload the image task
  }

  // uplod image to db
  UploadTask? uploadFile(File file) {
    try {
      final fileName = basename(file.path);
      final destination = 'resImages/$fileName';
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Stream<List<ItemModel>> getItemFromFirebase() {
    Stream<List<ItemModel>> l = firestore
        .collection('itemDetails')
        .orderBy('catagory', descending: false)
        .orderBy('name', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => ItemModel.fromMap(e.data())).toList());

    return l;
  }

  // Stream<List<ItemModel>> getItemFromFirebase2() {
  //   Stream<List<ItemModel>> l = firestore
  //       .collection('itemDetails')
  //       .orderBy('name', descending: false)
  //       .snapshots()
  //       .map((snapshot) =>
  //           snapshot.docs.map((e) => ItemModel.fromMap(e.data())).toList());

  //   return l;
  // }

  Future<void> deleteNews(String id) async {
    firestore.collection('itemDetails').doc(id).delete();
  }
}
