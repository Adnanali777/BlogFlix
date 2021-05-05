import 'package:blogflix/models/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blogflix/authenticate/login.dart';
import 'package:blogflix/models/user.dart';

class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);
    if (user == null) {
      return Login();
    } else {
      return MyNavbar();
    }
  }
}
