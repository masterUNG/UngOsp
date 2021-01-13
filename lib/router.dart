import 'package:flutter/material.dart';
import 'package:ungosp/states/add_product.dart';
import 'package:ungosp/states/authen.dart';
import 'package:ungosp/states/my_serivce_shoper.dart';
import 'package:ungosp/states/my_service_user.dart';
import 'package:ungosp/states/register.dart';

final Map<String, WidgetBuilder> myRoutes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/myServiceUser': (BuildContext context) => MyServiceUser(),
  '/myServiceShoper': (BuildContext context) => MyServiceShoper(),
  '/addProduct':(BuildContext context)=> AddProduct(),
};
