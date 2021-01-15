import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungosp/utility/dialog.dart';
import 'package:ungosp/utility/my_constant.dart';
import 'package:ungosp/utility/my_style.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  double screen;
  File file;
  String name, descrip, price, urlPath, uid;
  bool statusProcess = false;

  @override
  void initState() {
    super.initState();
    findUid();
  }

  Future<Null> findUid() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        uid = event.uid;
      });
    });
  }

  Container buildName() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.card_giftcard,
            color: MyStyle().darkColor,
          ),
          hintText: 'Name Product :',
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

  Container buildDescription() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) => descrip = value.trim(),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.description,
            color: MyStyle().darkColor,
          ),
          hintText: 'Description :',
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

  Container buildPrice() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: (value) => price = value.trim(),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.money,
            color: MyStyle().darkColor,
          ),
          hintText: 'Price :',
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
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('Add Product'),
      ),
      body: Stack(
        children: [
          statusProcess ? MyStyle().showProgress() : SizedBox(),
          buildSingleChildScrollView(),
        ],
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          buildRowImage(),
          buildName(),
          buildDescription(),
          buildPrice(),
          buildSaveProduct(),
        ],
      ),
    );
  }

  Container buildSaveProduct() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: MyStyle().darkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          if (file == null) {
            normalDialog(
                context, 'Please Choose Image ? by Click Camera or Gallery');
          } else if ((name?.isEmpty ?? true) ||
              (descrip?.isEmpty ?? true) ||
              (price?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ? Please Fill Every Blank');
          } else {
            confirmSave();
          }
        },
        child: Text('Save Product'),
      ),
    );
  }

  Future<Null> confirmSave() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: Image.file(file),
          title: Text(name),
          subtitle: Text(descrip),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Price = $price BTH',
                style: TextStyle(color: Colors.red, fontSize: 30),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  uploadImageAndIndertData();
                  setState(() {
                    statusProcess = true;
                  });
                  Navigator.pop(context);
                },
                child: Text('Save Product'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> chooseSourceImage(ImageSource source) async {
    try {
      var result = await ImagePicker()
          .getImage(source: source, maxWidth: 800, maxHeight: 800);
      setState(() {
        file = File(result.path);
      });
    } catch (e) {}
  }

  Row buildRowImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => chooseSourceImage(ImageSource.camera)),
        Container(
          width: screen * 0.6,
          child:
              file == null ? Image.asset('images/image.png') : Image.file(file),
        ),
        IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () => chooseSourceImage(ImageSource.gallery)),
      ],
    );
  }

  Future<Null> uploadImageAndIndertData() async {
    int i = Random().nextInt(1000000);
    String nameImage = 'product$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData data = FormData.fromMap(map);

      await Dio()
          .post(MyConstant().urlSaveFile, data: data)
          .then((value) async {
        urlPath = 'ungproduct/$nameImage';
        print('${MyConstant().domain}$urlPath');

        String urlAPI =
            'https://www.androidthai.in.th/osp/addDataUng.php?isAdd=true&uidshop=$uid&name=$name&detail=$descrip&price=$price&urlproduct=$urlPath';
        await Dio().get(urlAPI).then((value) => Navigator.pop(context));
      });
    } catch (e) {
      print('Error ==>> ${e.toString()}');
    }
  }
}
