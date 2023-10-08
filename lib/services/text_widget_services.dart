// // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // class TextWidgetServices {
// // //   static CollectionReference textDataCollection =
// // //       FirebaseFirestore.instance.collection('text_data');

// // //   static Future<bool> addTextData(String text) async {
// // //     try {
// // //       await textDataCollection.add({
// // //         'text': text,
// // //         'timestamp': FieldValue.serverTimestamp(),
// // //       });
// // //       return true;
// // //     } catch (e) {
// // //       print('Error adding text data: $e');
// // //       return false;
// // //     }
// // //   }

// // //   static Future<List<String>> getTextData() async {
// // //     List<String> textDataList = [];

// // //     try {
// // //       QuerySnapshot querySnapshot = await textDataCollection.get();
// // //       querySnapshot.docs.forEach((doc) {
// // //         textDataList.add(doc['text']);
// // //       });
// // //     } catch (e) {
// // //       print('Error retrieving text data: $e');
// // //     }

// // //     return textDataList;
// // //   }
// // // }


// // import 'package:firebase_database/firebase_database.dart';

// // class TextWidgetServices {
// //   // static DatabaseReference textDataReference =
// //   //     FirebaseDatabase.instance.ref().child('text_data');

// //   static Future<bool> addTextData(String text) async {
// //     try {
// //       DatabaseReference textDataReference =
// //       FirebaseDatabase.instance.ref().child('text_data');
// //       await textDataReference.push().set({
// //         'text': text,
// //         'timestamp': ServerValue.timestamp,
// //       });
// //       print('data wirtten');
// //       return true;
// //     } catch (e) {
// //       print('Error adding text data: $e');
// //       return false;
// //     }
// //   }

// //   // static Future<List<String>> getTextData() async {
// //   //   List<String> textDataList = [];

// //   //   try {
// //   //     DataSnapshot dataSnapshot = await textDataReference.once();
// //   //     Map<dynamic, dynamic> data = dataSnapshot.value;
// //   //     if (data != null) {
// //   //       data.forEach((key, value) {
// //   //         textDataList.add(value['text']);
// //   //       });
// //   //     }
// //   //   } catch (e) {
// //   //     print('Error retrieving text data: $e');
// //   //   }

// //     // return textDataList;
// //   // }
// // }


// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';

// final databaseReference = FirebaseDatabase.instance.ref();


