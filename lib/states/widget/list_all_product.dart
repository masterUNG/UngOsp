import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungosp/models/product_model.dart';
import 'package:ungosp/utility/my_constant.dart';
import 'package:ungosp/utility/my_style.dart';

class ListAllProduct extends StatefulWidget {
  @override
  _ListAllProductState createState() => _ListAllProductState();
}

class _ListAllProductState extends State<ListAllProduct> {
  List<Widget> widgets = List();
  List<ProductModel> productModels = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllProduct();
  }

  Future<Null> readAllProduct() async {
    String path = 'https://www.androidthai.in.th/osp/getAllProductUng.php';
    await Dio().get(path).then((value) {
      int index = 0;
      for (var item in json.decode(value.data)) {
        ProductModel model = ProductModel.fromMap(item);
        productModels.add(model);
        setState(() {
          widgets.add(createWidget(model, index));
        });
        index++;
      }
    });
  }

  Widget createWidget(ProductModel model, int index) {
    return GestureDetector(
      onTap: () {
        print('You Click Card at name = ${productModels[index].name}');
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        color: MyStyle().lightColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              child: CachedNetworkImage(
                imageUrl: '${MyConstant().domain}${model.urlproduct}',
                placeholder: (context, url) => MyStyle().showProgress(),
                errorWidget: (context, url, error) =>
                    Image.asset('images/image.png'),
              ),
            ),
            Text(model.name, style: MyStyle().whiteStyle()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.length == 0 ? MyStyle().showProgress() : buildGridView(),
    );
  }

  Widget buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.extent(
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        maxCrossAxisExtent: 200,
        children: widgets,
      ),
    );
  }
}
