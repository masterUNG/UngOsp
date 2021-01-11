import 'package:flutter/material.dart';
import 'package:ungosp/states/authen.dart';
import 'package:ungosp/states/my_service.dart';
import 'package:ungosp/states/register.dart';

final Map<String, WidgetBuilder> myRoutes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/myService': (BuildContext context) => MyService(),
};
