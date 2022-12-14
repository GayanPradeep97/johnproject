import 'dart:io';
import 'package:flutter/material.dart';
import 'package:johnproject/components/custom_dialog.dart';
import 'package:johnproject/controller/item_controller.dart';
import 'package:johnproject/screens/admin_custom_page.dart';
import 'package:johnproject/screens/homepage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:johnproject/utility/uttility_function.dart';
import 'package:logger/logger.dart';
import 'package:image_picker/image_picker.dart';

class ItemProvider extends ChangeNotifier {
  final _catagory = TextEditingController();
  TextEditingController get catagoryController => _catagory;

  final _name = TextEditingController();
  TextEditingController get nameController => _name;

  final _diamention = TextEditingController();
  TextEditingController get diamentionController => _diamention;

  bool _isLoading = false;

  bool get isloding => _isLoading;

  Future<bool> startAddItemDetails(BuildContext context, File file) async {
    try {
      if (inputValidation()) {
        setLoading(true);

        await ItemController()
            .saveContactDetails(
          _name.text,
          _diamention.text,
          file,
          _catagory.text,
        )
            .whenComplete(() {
          // UserProvider().fetchSingleUser(
          //   AuthController().userCredential2.user!.uid.toString(),
          // );

          CustomAwesomDialog().dialogBox(context, "Success...!",
              "Congratulations...! Successfully added.", DialogType.SUCCES);

          Future.delayed(const Duration(seconds: 2), () {
            cleardata();
          });
        });

        setLoading();
        return true;
      } else {
        CustomAwesomDialog().dialogBox(
            context, "Error!", "Please check fields.", DialogType.SUCCES);
      }
    } catch (e) {
      setLoading();
      Logger().e(e);
    }
    return false;
  }

  Future<void> deleteCard(String id) async {
    ItemController().deleteNews(id);
  }

  bool inputValidation() {
    var isValid = false;
    if (_name.text.isEmpty ||
        _diamention.text.isEmpty ||
        _catagory.text.isEmpty) {
      isValid = false;
    } else {
      isValid = true;
    }
    return isValid;
  }

  void setLoading([bool val = false]) {
    _isLoading = val;
    notifyListeners();
  }

  void cleardata() {
    _name.clear();
    _diamention.clear();
    _catagory.clear();
  }
}
