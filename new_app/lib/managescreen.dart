import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_app/splash.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({Key? key}) : super(key: key);

  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  late double _myLat = 6.927079;
  late double _myLang = 79.861244;
  bool _flood = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          onPressed: () {},
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
            child: ClipRect(
              child: Image.asset(
                'assets/worldimg.png',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          // Replace this container with your Map widget
          Container(
            child: GoogleMap(
              zoomControlsEnabled: true,

              onMapCreated: (GoogleMapController controller) {
                //controlle.setMapStyle(Util.mapstyle);

                setState(() {
                  //mapController = controller;
                });
                super.initState();
              },
              initialCameraPosition: CameraPosition(
                  //target: const LatLng(6.927079, 79.861244),
                  target: LatLng(this._myLat, this._myLang),
                  zoom: 18,
                  tilt: 90,
                  bearing: 40),
              // markers: _markers,
              //markers: Set<Marker>.of(_markers),
              //onLongPress: showModal,
              myLocationButtonEnabled: false,

              //  tiltGesturesEnabled: true,
              // trafficEnabled: true,
              myLocationEnabled: true,
              // liteModeEnabled: true,
              compassEnabled: true,
              mapType: MapType.normal,
            ),
          ),

          // Positioned(
          //   top: 10,
          //   right: 15,
          //   left: 15,
          //   child: Container(
          //     color: Colors.white,
          //     child: Row(
          //       children: <Widget>[
          //         IconButton(
          //           splashColor: Colors.grey,
          //           icon: Icon(Icons.menu),
          //           onPressed: () {},
          //         ),
          //         Expanded(
          //           child: TextField(
          //             cursorColor: Colors.black,
          //             keyboardType: TextInputType.text,
          //             textInputAction: TextInputAction.go,
          //             decoration: InputDecoration(
          //                 border: InputBorder.none,
          //                 contentPadding: EdgeInsets.symmetric(horizontal: 15),
          //                 hintText: "Search..."),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 8.0),
          //           child: CircleAvatar(
          //             backgroundColor: Colors.deepPurple,
          //             child: Text('RD'),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _flood ? 56 : 300,
                    height: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.white,
                        boxShadow: kElevationToShadow[6]),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.only(left: 16),
                                child: !_flood
                                    ? TextField(
                                        decoration: InputDecoration(
                                            hintText: "Job Title Key Word",
                                            hintStyle:
                                                TextStyle(color: Colors.blue),
                                            border: InputBorder.none))
                                    : null)),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Material(
                              type: MaterialType.transparency,
                              child: InkWell(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(_flood ? 32 : 0),
                                  topRight: Radius.circular(32),
                                  bottomLeft: Radius.circular(_flood ? 32 : 0),
                                  bottomRight: Radius.circular(32),
                                ),
                                child: Icon(
                                  _flood ? Icons.search : Icons.close,
                                  color: Colors.blue,
                                ),
                                onTap: () {
                                  setState(() {
                                    _flood = !_flood;
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
