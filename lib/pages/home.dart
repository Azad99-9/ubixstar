import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ubixstar/pages/widget_selection_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ubixstar/services/image_wiget_services.dart';
import 'package:ubixstar/services/text_widget_services.dart';

class AssignmentApp extends StatefulWidget {
  const AssignmentApp({super.key});

  @override
  State<AssignmentApp> createState() => _AssignmentAppState();
}

class _AssignmentAppState extends State<AssignmentApp> {
  List<int> selectedWidgets = [];
  TextEditingController textWidgetController = TextEditingController();
  XFile? selectedImage = null;
  final databaseReference = FirebaseDatabase.instance.ref();

  // Replace "textData" with the key you want to use and "yourText" with the actual text data.
  Future<bool> storeTextData(txt) async {
    print("hello");
    await databaseReference.child("textData").set(txt);
    return true;
  }

  // Future<void> uploadImage() async {
  //   await ;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            // width: MediaQuery.of(context).size.width*0.9,
            padding: EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Assignment App',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Color(0xFF90EE90).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: selectedWidgets.length == 0
                            ? Center(
                                child: Text(
                                'No Widget is added',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ))
                            : Padding(
                                padding:
                                    EdgeInsets.fromLTRB(40.0, 120, 40, 120),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (selectedWidgets.contains(0))
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFADADAD)
                                                .withOpacity(0.5),
                                          ),
                                          child: TextField(
                                            controller: textWidgetController,
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(left: 10),
                                                border: InputBorder.none,
                                                hintText: "Enter Text",
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ),
                                      if (selectedWidgets.contains(1))
                                        InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFADADAD)
                                                  .withOpacity(0.5),
                                              image: selectedImage != null
                                                  ? DecorationImage(
                                                      image: FileImage(File(
                                                          selectedImage!.path)),
                                                      fit: BoxFit.cover)
                                                  : null,
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25,
                                            child: Center(
                                                child: selectedImage == null
                                                    ? Text('Upload Image',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500))
                                                    : Container()),
                                          ),
                                          onTap: () async {
                                            final picker = ImagePicker();
                                            final pickedFile =
                                                await picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            setState(() {
                                              selectedImage = pickedFile;
                                            });
                                          },
                                        ),
                                      if (selectedWidgets.contains(2))
                                        TextButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  BeveledRectangleBorder()),
                                              side: MaterialStateProperty.all(
                                                  BorderSide(
                                                color: Colors
                                                    .black, // Border color
                                                width: 1, // Border width
                                              )),
                                              backgroundColor:
                                                  MaterialStateColor
                                                      .resolveWith(
                                                (states) => Color(0xFF90EE90)
                                                    .withOpacity(0.6),
                                              ),
                                              foregroundColor:
                                                  MaterialStateColor
                                                      .resolveWith((states) =>
                                                          Colors.black)),
                                          child: Text('Save'),
                                          onPressed: () async {
                                            String textFieldText =
                                                textWidgetController.text;
                                            bool imageUploaded = false;
                                            bool textUploaded = false;

                                            if (!selectedWidgets.contains(0) &&
                                                !selectedWidgets.contains(1))
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Container(
                                                color: Colors.black,
                                                child: Text(
                                                    'Please select atleast 1 widget'),
                                              )));
                                            else {
                                              if (selectedImage != null) {
                                                ImageWidgetServices.uploadImage(selectedImage).then((done) {
                                                  if (done) ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Image Successfully Saved')));
                                                });
                                              }
                                              databaseReference.child("textData").set("yourText").then((done) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'text Successfully Saved')));
                                              });
                                            }
                                          },
                                        )
                                    ],
                                  ),
                                ),
                              )),
                  ),
                  TextButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(
                          color: Colors.black, // Border color
                          width: 2.0, // Border width
                        )),
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color(0xFF90EE90).withOpacity(0.6),
                        ),
                        foregroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: Text('Add Widgets'),
                      ),
                      onPressed: () async {
                        List<int> widgets = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WidgetSelection()));
                        // print("hi");
                        // print(widgets);
                        setState(() {
                          selectedWidgets = widgets;
                          print(selectedWidgets);
                          print("hi");
                        });
                      })
                ],
              ),
              scrollDirection: Axis.vertical,
            )));
  }
}
