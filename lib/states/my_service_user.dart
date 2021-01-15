import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungosp/states/widget/list_all_product.dart';
import 'package:ungosp/utility/my_style.dart';

class MyServiceUser extends StatefulWidget {
  @override
  _MyServiceUserState createState() => _MyServiceUserState();
}

class _MyServiceUserState extends State<MyServiceUser> {
  String nameLogin;
  Widget currentWidget = ListAllProduct();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findNameLogin();
  }

  Future<Null> findNameLogin() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          nameLogin = event.displayName;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('User'),
      ),
      drawer: buildDrawer(context),
      body: currentWidget,
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              buildUserAccountsDrawerHeader(),
              buildListTileListAllProduct(),
              Divider(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyStyle().buildSignOut(context),
            ],
          ),
        ],
      ),
    );
  }

  ListTile buildListTileListAllProduct() {
    return ListTile(
      leading: Icon(Icons.shopping_bag),
      title: Text('List All Product'),
      onTap: () {
        setState(() {
          currentWidget = ListAllProduct();
        });
        Navigator.pop(context);
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 1.5,
          center: Alignment(-1, 0),
          colors: [Colors.white, MyStyle().primaryColor],
        ),
      ),
      currentAccountPicture: Image.asset('images/logo.png'),
      accountName: Text(
        nameLogin == null ? 'Name' : nameLogin,
        style: MyStyle().pinkStyle(),
      ),
      accountEmail: Text(
        'Type User',
        style: MyStyle().titleH2Style(),
      ),
    );
  }
}
