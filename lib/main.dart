import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ungosp/router.dart';

// void main() {
//   runApp(MyApp());
// }

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: myRoutes,
      initialRoute: '/authen',
    );
  }
}
