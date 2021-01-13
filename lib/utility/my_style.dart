import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Color(0xff001f57);
  Color primaryColor = Color(0xff0d4584);
  Color lightColor = Color(0xff4c70b4);

  Widget buildSignOut(BuildContext context) {
    return ListTile(
            onTap: () async {
              await Firebase.initializeApp().then((value) async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/authen', (route) => false));
              });
            },
            tileColor: Colors.red.shade700,
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text(
              'Sing Out',
              style: MyStyle().whiteStyle(),
            ),
          );
  }

  Widget showProgress() => Center(child: CircularProgressIndicator());

  TextStyle whiteStyle() => TextStyle(color: Colors.white);

  TextStyle pinkStyle() => TextStyle(color: Colors.pink);

  double findScreen(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  MyStyle();
}
