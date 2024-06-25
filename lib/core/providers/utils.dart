import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/qr_order_model.dart';

void showSnackBar(String text, BuildContext context) {
  final snackBar = SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    animation: CurvedAnimation(
      parent: AnimationController(
        vsync: Scaffold.of(context),
        duration: Duration(milliseconds: 500),
      )..forward(),
      curve: Curves.easeIn,
    ),
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

Future<FilePickerResult?> picImage() async {
  try {
    if (await requestStoragePermission()) {
      final image = await FilePicker.platform.pickFiles(type: FileType.image);
      if (image == null) {
        // User canceled the picker
        return null;
      }
      return image;
    } else {}
  } catch (e) {
    // Handle any errors that occur during file picking
    print("An error occurred while picking the image: $e");
    return null;
  }
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  if (await requestStoragePermission()) {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    return image;
  } else {
    showSnackBar("You have give kamn a permission", context);
  }
}

Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackBar(e.toString(), context);
  }
  return video;
}

Future<bool> requestStoragePermission() async {
  if (await Permission.storage.request().isGranted) {
    return true;
  } else {
    // You can show a dialog explaining why you need the permission and request again
    return false;
  }
}

QrOrderModel qrOrderCommanModel = QrOrderModel(
    orderid: "",
    storeId: "",
    offerId: "",
    userId: "",
    offerTitle: "",
    offerDescription: "",
    offerPrice: "",
    offerDiscount: "",
    category: "",
    image: "",
    serviceProviderId: "",
    qrLink: "",
    date: DateTime.now());
