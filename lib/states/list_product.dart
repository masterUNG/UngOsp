import 'package:flutter/material.dart';
import 'package:ungosp/utility/my_style.dart';

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  void initState() {
    super.initState();
    readAllProduct();
  }

  Future<Null> readAllProduct() async {
    print('Read All Product Work');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyStyle().primaryColor,
        onPressed: () => Navigator.pushNamed(context, '/addProduct').then((value) => readAllProduct()),
        child: Icon(Icons.add),
      ),
      body: Text('This is List Product'),
    );
  }
}
