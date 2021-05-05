import 'dart:io';

import 'package:blogflix/models/user.dart';
import 'package:blogflix/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  String title;
  String desc;
  String name;
  bool isloading = false;

  CrudMethods crudMethods = new CrudMethods();

  File selectedimage;

  Future getImage() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        selectedimage = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadBlog() async {
    if (selectedimage != null) {
      setState(() {
        isloading = true;
      });
      Reference firebasestorageref = FirebaseStorage.instance
          .ref()
          .child("blogimages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebasestorageref.putFile(selectedimage);

      var imageUrl;
      await task.whenComplete(() async {
        try {
          imageUrl = await firebasestorageref.getDownloadURL();
        } catch (onError) {
          print("Error");
        }

        print(imageUrl);
      });
      Map<String, String> blogMap = {
        "imageurl": imageUrl,
        "title": title,
        "name": name,
        "desc": desc,
      };
      crudMethods.addData(blogMap).then((result) {
        setState(() {
          isloading = false;
        });
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<TheUser>(context);
    name = user.name;
    var image = user.image;
    print(image);
    return Scaffold(
      backgroundColor: Colors.white,
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: selectedimage != null
                        ? Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                selectedimage,
                                fit: BoxFit.cover,
                              ),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: size.height * 0.02),
                            width: size.width,
                            height: size.height * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.height * 0.02),
                            width: size.width,
                            height: size.height * 0.25,
                            child: Center(
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.025,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            maxLines: 1,
                            onChanged: (val) {
                              title = val;
                            },
                            decoration: InputDecoration(
                              hintText: 'Title',
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            onChanged: (val) {
                              desc = val;
                            },
                            maxLength: 500,
                            maxLengthEnforced: true,
                            decoration: InputDecoration(
                              labelText: 'Write Your Blog Here',
                              labelStyle: TextStyle(fontSize: 15),
                              alignLabelWithHint: true,
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    style: BorderStyle.solid),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    style: BorderStyle.solid),
                              ),
                            ),
                            maxLines: 25,
                            minLines: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => uploadBlog(),
        backgroundColor: Colors.orange[600],
        child: Icon(Icons.add),
      ),
    );
  }
}
