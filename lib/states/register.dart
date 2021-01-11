import 'package:flutter/material.dart';
import 'package:ungosp/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double screen;
  String typeUser;

  Container buildName() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 50),
      width: screen * 0.6,
      child: TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.fingerprint,
            color: MyStyle().darkColor,
          ),
          hintText: 'Name :',
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

  Container buildUser() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
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
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.lock_outline,
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

  @override
  Widget build(BuildContext context) {
    screen = MyStyle().findScreen(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          children: [
            buildName(),
            buildRadioUser(),
            buildRadioShoper(),
            buildUser(),
            buildPassword(),
            Expanded(
              child: Container(margin: EdgeInsets.all(16),
                width: screen,
                color: Colors.grey,
                child: Text('This is Map'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRadioUser() {
    return Container(
      width: screen * 0.6,
      child: RadioListTile(
        subtitle: Text('Type User For Buyer'),
        title: Text('User'),
        value: 'User',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value;
          });
        },
      ),
    );
  }

  Widget buildRadioShoper() {
    return Container(
      width: screen * 0.6,
      child: RadioListTile(
        subtitle: Text('สำหรับ ร้านค้า ที่ต้องการขายสินค้า'),
        title: Text('Shoper'),
        value: 'Shoper',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value;
          });
        },
      ),
    );
  }
}
