import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_application/src/resources/widgets/home_menu.dart';
import 'package:taxi_application/src/resources/widgets/ride_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            // GoogleMap(
            //   initialCameraPosition: CameraPosition(
            //     target: LatLng(10.7915178, 106.7271422),
            //     zoom: 14.4746,
            //   ),
            // ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Text(
                      "Taxi App",
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: TextButton(
                      onPressed: () {
                        print("click menu");
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: Image.asset("assets/img/ic_menu.png"),
                    ),
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Image.asset("assets/img/ic_notify.png"),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: RidePicker(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }
}
