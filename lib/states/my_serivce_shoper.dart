import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungosp/states/list_order.dart';
import 'package:ungosp/states/list_product.dart';
import 'package:ungosp/utility/my_style.dart';

class MyServiceShoper extends StatefulWidget {
  @override
  _MyServiceShoperState createState() => _MyServiceShoperState();
}

class _MyServiceShoperState extends State<MyServiceShoper> {
  String nameLogin;
  Widget currentWidget = ListOrder();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findNameLoginAndTypeUser();
  }

  Future<Null> findNameLoginAndTypeUser() async {
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
      appBar: AppBar(backgroundColor: MyStyle().primaryColor,
        title: Text('Shoper'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildUserAccountsDrawerHeader(),
                buildMenuListOrder(),
                buildMenuListProduct(),
              ],
            ),
            buildColumnSignOut(context),
          ],
        ),
      ),
      body: currentWidget,
    );
  }

  ListTile buildMenuListOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = ListOrder();
        });
        Navigator.pop(context);
      },
      leading: Icon(Icons.home),
      title: Text('List Order'),
      subtitle: Text('รายการ Order ของลูกค้า ที่สั่ง'),
    );
  }

  ListTile buildMenuListProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = ListProduct();
        });
        Navigator.pop(context);
      },
      leading: Icon(Icons.list),
      title: Text('List Product'),
      subtitle: Text('รายการ สินค้า ของเรา'),
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      // decoration: BoxDecoration(color: Colors.purple),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/wall.jpg'), fit: BoxFit.cover),
      ),
      currentAccountPicture: Image.asset('images/logo.png'),
      accountName: Text(nameLogin == null ? 'Name' : nameLogin),
      accountEmail: Text('Shoper :'),
    );
  }

  Column buildColumnSignOut(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MyStyle().buildSignOut(context),
      ],
    );
  }
}
