import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ungosp/utility/dialog.dart';
import 'package:ungosp/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double screen;
  String typeUser, token, name, user, password;
  double lat, lng;

  @override
  void initState() {
    super.initState();
    findLatLng();
    findToken();
  }

  Future<Null> findToken() async {
    // await Firebase.initializeApp().then((value) {
    //   print('################ Initialize Success ####################');
    // });

    FirebaseMessaging messaging = FirebaseMessaging();
    token = await messaging.getToken();
    print('token = $token');
  }

  Future<Null> findLatLng() async {
    LocationData data = await findLocationData();
    setState(() {
      lat = data.latitude;
      lng = data.longitude;
    });
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
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
        onChanged: (value) => user = value.trim(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          prefixIcon: Icon(
            Icons.email_outlined,
            color: MyStyle().darkColor,
          ),
          hintText: 'Email :',
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
        decoration: InputDecoration(
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

  @override
  Widget build(BuildContext context) {
    screen = MyStyle().findScreen(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.cloud_upload_outlined),
            onPressed: () {
              print(
                  'name = $name, user = $user, password = $password, typeUser = $typeUser');
              if ((name == null || name.isEmpty) ||
                  (user?.isEmpty ?? true) ||
                  (password?.isEmpty ?? true)) {
                normalDialog(context, 'Have Space ? Please Fill Every Blank');
              } else if (typeUser == null) {
                normalDialog(context, 'Type User ? Plese Choose Type User');
              } else {
                registerAndInsertData();
                              }
                            },
                          )
                        ],
                        backgroundColor: MyStyle().primaryColor,
                        title: Text('Register'),
                      ),
                      body: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              buildName(),
                              buildRadioUser(),
                              buildRadioShoper(),
                              buildUser(),
                              buildPassword(),
                              buildMap()
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                
                  Set<Marker> markers() => <Marker>[
                        Marker(
                          markerId: MarkerId('idMarker1'),
                          position: LatLng(lat, lng),
                          infoWindow: InfoWindow(
                              title: 'คุณอยู่่ที่นี่', snippet: 'Lat = $lat, Lng = $lng'),
                        ),
                      ].toSet();
                
                  Widget buildMap() {
                    return Container(
                      margin: EdgeInsets.all(16),
                      width: screen,
                      height: screen * 0.6,
                      child: lat == null
                          ? MyStyle().showProgress()
                          // : Text('Lat = $lat, lng = $lng'),
                          : GoogleMap(
                              markers: markers(),
                              initialCameraPosition: CameraPosition(
                                target: LatLng(lat, lng),
                                zoom: 16,
                              ),
                              onMapCreated: (controller) {},
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
                
                  Future<Null> registerAndInsertData()async {}
}
