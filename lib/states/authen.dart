import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ungosp/utility/dialog.dart';
import 'package:ungosp/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screen;
  bool status = true;
  String user, password;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    print('screen = $screen');
    return Scaffold(
      floatingActionButton: buildRegister(),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.25),
            radius: 1.0,
            colors: <Color>[Colors.white, MyStyle().primaryColor],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildLogo(),
              buildText(),
              buildUser(),
              buildPassword(),
              buildLogin(),
            ],
          ),
        ),
      ),
    );
  }

  TextButton buildRegister() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/register'),
      child: Text(
        'New Register',
        style: MyStyle().pinkStyle(),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: MyStyle().darkColor,
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ? Please Fill Every Blank');
          } else {
            checkAuthen();
          }
        },
        child: Text(
          'Login',
          style: MyStyle().whiteStyle(),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().darkColor,
          ),
          hintText: 'User :',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: status,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: status
                ? Icon(Icons.remove_red_eye)
                : Icon(Icons.remove_red_eye_outlined),
            onPressed: () {
              setState(() {
                status = !status;
              });
              print('You Click RedEye status = $status');
            },
          ),
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyStyle().darkColor,
          ),
          hintText: 'Password :',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Text buildText() => Text(
        'Ung Osp',
        style: GoogleFonts.yeonSung(
            textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          // fontStyle: FontStyle.italic,
          color: MyStyle().darkColor,
        )),
      );

  Container buildLogo() {
    return Container(
      width: screen * 0.33,
      child: Image.asset('images/logo.png'),
    );
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        String uid = value.user.uid;
        print('uid = $uid');

        await FirebaseFirestore.instance
            .collection('typeuser')
            .doc(uid)
            .snapshots()
            .listen((event) {
          String typeUser = event.data()['typeuser'];
          print('typeUser = $typeUser');

          Navigator.pushNamedAndRemoveUntil(
              context, '/myService$typeUser', (route) => false);

        });
      }).catchError((value) {
        normalDialog(context, value.message);
      });
    });
  }
}
