import 'package:blogflix/services/auth.dart';
import 'package:blogflix/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  AuthService _auth = AuthService();
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Welcome To ',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                      children: [
                        TextSpan(
                            text: 'BLOGFLIX',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.orange[600])),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/login.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.081,
                    padding: EdgeInsets.all(10),
                    child: FlatButton.icon(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(color: Colors.brown[800]),
                      ),
                      onPressed: () async {
                        dynamic result = await _auth.signInWithGoogle();
                        if (result == null) {
                          setState(() {
                            error = 'Login Unsucessfull';
                            loading = true;
                          });
                        }
                      },
                      color: Colors.white,
                      icon: Icon(
                        AntDesign.google,
                        size: 20,
                        color: Colors.black,
                      ),
                      label: RichText(
                        text: TextSpan(
                            text: 'Continue ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: 'With ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: 'Google',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),
                  Text(
                    error,
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  )
                ],
              ),
            ),
          );
  }
}
