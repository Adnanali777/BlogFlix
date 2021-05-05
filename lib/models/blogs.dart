import 'package:flutter/material.dart';

class Blogs extends StatefulWidget {
  String title;
  String img;
  String desc;
  String name;

  Blogs({this.desc, this.img, this.name, this.title});
  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                  child: Image.network(
                widget.img,
                height: 360,
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
              )),
              SizedBox(height: 30),
              ListTile(
                title: Text(widget.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey[800])),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.10,
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(widget.desc,
                      style: TextStyle(color: Colors.grey[600], height: 1.4))),
            ],
          ),
        ));
  }
}
