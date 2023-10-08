import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ImageWidgetServices {
// Function to upload an image to Firebase Storage
  static Future<bool> uploadImage(pickedFile) async {
    if (pickedFile != null) {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');
      UploadTask uploadTask = storageReference.putFile(File(pickedFile.path));

      await uploadTask.whenComplete(() => print('Image uploaded'));
      return true;
    } else {
      print('No image selected.');
      return false;
    }
  }

// Function to retrieve an image from Firebase Storage
  static Future<String> getImageUrl(String imagePath) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child(imagePath);

    final imageUrl = await storageReference.getDownloadURL();
    return imageUrl;
  }
}
