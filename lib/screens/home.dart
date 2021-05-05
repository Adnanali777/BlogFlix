import 'package:blogflix/models/blogs.dart';
import 'package:blogflix/services/auth.dart';
import 'package:blogflix/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CrudMethods crudMethods = new CrudMethods();
  QuerySnapshot blogsnapshot;

  AuthService _auth = AuthService();

  @override
  void initState() {
    crudMethods.getData().then((result) {
      setState(() {
        blogsnapshot = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0.0,
          actions: [
            FlatButton.icon(
              onPressed: () async {
                await _auth.Signout();
              },
              icon: Icon(
                AntDesign.poweroff,
                size: 15,
              ),
              label: Text(
                'logout',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ],
          centerTitle: true,
          title: Text(
            'BLOGFLIX',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.orange[600]),
          ),
          backgroundColor: Colors.white),
      body: (blogsnapshot != null)
          ? Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.03),
              child: ListView.builder(
                  itemCount: blogsnapshot.docs.length,
                  itemBuilder: (context, index) {
                    return blog_card_template(
                      image: blogsnapshot.docs[index].get('imageurl'),
                      title: blogsnapshot.docs[index].get('title'),
                      name: blogsnapshot.docs[index].get('name'),
                      desc: blogsnapshot.docs[index].get('desc'),
                    );
                  }),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class blog_card_template extends StatefulWidget {
  String image;
  String title;
  String name;
  String desc;
  blog_card_template({this.image, this.title, this.name, this.desc});

  @override
  _blog_card_templateState createState() => _blog_card_templateState();
}

class _blog_card_templateState extends State<blog_card_template>
    with SingleTickerProviderStateMixin {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 10, vertical: MediaQuery.of(context).size.width * 0.05),
      child: Card(
          margin: EdgeInsets.zero,
          elevation: 5,
          child: Row(
            children: [
              FlatButton(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Blogs(
                                    title: widget.title,
                                    img: widget.image,
                                    name: widget.name,
                                    desc: widget.desc,
                                  )));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Image.network(
                          widget.image,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * 0.45,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 5),
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 0.9),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '-By ${widget.name}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
