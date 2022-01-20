import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

@override
class imagepicker2 {
  File pickedImage;
  String downloadUrl;
  String MedUrl = '';
  Medicine med;
  imagepicker2(
    @required this.med,
  );

  FirebaseAuth auth = FirebaseAuth.instance;
  AcceptImage(int type) async {
    // await FirebaseAuth.instance.signInAnonymously();
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    if (type == 0) {
      await Permission.camera.request();

      if (true) {
        // ignore: deprecated_member_use
        image = await _picker.getImage(
            source: ImageSource.camera, imageQuality: 80);
      }
    }
    if (type == 1) {
      await Permission.photos.request();
      var permissionSttatuse = await Permission.photos.status;
      if (permissionSttatuse.isGranted) {
        // ignore: deprecated_member_use
        image = await _picker.getImage(source: ImageSource.gallery);
      }
    }
    var file = File(image.path);
    if (image != null) {
      var sn = await _storage
          .ref()
          .child("MedicineImage")
          .child(med.name + '.png')
          .putFile(file);
      var downUrl = await sn.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('medicins')
          .doc(med.id)
          .update({'urlImage': downUrl});
      pickedImage = file;
      downloadUrl = downUrl;
      med.urlImage = downloadUrl;
    } else {
      print(" null image ");
    }
    //return downloadUrl;
  }

  String geturl() {
    return downloadUrl;
  }

  File pickedimage() {
    return pickedImage;
  }

  showMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Medicine Image"),
              content: new Text("Please choose one "),
              actions: <Widget>[
                FlatButton(
                  child: Text('Files'),
                  onPressed: () {
                    AcceptImage(1);
                    // uploadImage();
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Camera'),
                  onPressed: () {
                    // dImage();
                    AcceptImage(0);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
