import 'dart:convert';
import 'dart:io';

import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';

import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';

import 'package:new_app/locationModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

//flutter run --no-sound-null-safety

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Set<Marker> _markers = {};
  List<Marker> _markers = <Marker>[];
  List<Marker> _markers2 = <Marker>[];
  final Geolocator geolocator = Geolocator();

  late double _myLat = 6.927079;
  late double _myLang = 79.861244;
  int pinID = 0;
  int markerCount = 1;

  late BitmapDescriptor customIcon;
  late GoogleMapController mapController;
  File? image;
  bool isloading = true;
  dynamic pinurl = 'assets/pin1.png';

  @override
  void initState() {
    super.initState();
    createIcon(pinurl);
    getLocation();
    _loadAllMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        floatingActionButton: DraggableFab(
          child: FloatingActionButton(
            onPressed: () {
              getuserLocation();
            },
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
        body: //isloading == false
            //     ? Center(
            //         // Display Progress Indicator
            //         child: CircularProgressIndicator(),
            //       ):
            Container(
              
           child: GoogleMap(
            zoomControlsEnabled: true,

            onMapCreated: (GoogleMapController controller) {
              //controlle.setMapStyle(Util.mapstyle);

              setState(() {
                mapController = controller;
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
            markers: Set<Marker>.of(_markers),
            onLongPress: showModal,
            myLocationButtonEnabled: false,

            //  tiltGesturesEnabled: true,
            // trafficEnabled: true,
            myLocationEnabled: true,
            // liteModeEnabled: true,
            compassEnabled: true,
            mapType: MapType.normal,
          ),
        ),
      ),
    );
  }

  _addMarker(LatLng pos, dynamic url) async {
    print(url);
    createIcon(url);
    final coordinates = new Coordinates(pos.latitude, pos.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    var title = first.featureName;
    var address = first.addressLine;
    // print("${first.featureName} : ${first.addressLine}: ${first.locality}: ${first.thoroughfare}");

    //---------------------------------------------------------------
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(pinID.toString()),
        position: LatLng(pos.latitude, pos.longitude),

        infoWindow: InfoWindow(
            title: "${first.featureName} ", snippet: "${first.addressLine}"),
        //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        icon: customIcon,
      ));
      _saveMarker(new LocationModal(
          id: "LocateID" + title,
          lat: pos.latitude,
          lang: pos.longitude,
          title: title,
          address: address,
          marker: customIcon));
    });
  }

  //-------------------marker gallery--------------------------------------
  Widget buildSheeet(double latitude, double longitude) => Container(
        padding: EdgeInsets.all(5),
        height: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Center(
                child: ListView(
                  children: [
                    ListTile(
                      dense: true,
                      title: Text("Keelse Super Center"),
                      onTap: () {
                        setState(() {
                          this.pinurl = 'assets/pin9.png';
                          print(pinurl);
                          isloading = false;
                        });
                        Navigator.pop(context);
                        showModal(LatLng(latitude, longitude));
                      },
                      leading: new Image.asset(
                        "assets/pin9.png",
                        width: 50.0,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      dense: true,
                      title: Text("Keelse Super Center"),
                      onTap: () {
                        setState(() {
                          pinurl = 'assets/33.png';
                          print(pinurl);
                          isloading = false;
                        });
                        Navigator.pop(context);
                        showModal(LatLng(latitude, longitude));
                      },
                      leading: new Image.asset(
                        "assets/33.png",
                        width: 50.0,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      dense: true,
                      title: Text("Keelse Super Center"),
                      onTap: () {
                        setState(() {
                          pinurl = 'assets/pin7.png';
                          print(pinurl);
                          isloading = false;
                        });
                        Navigator.pop(context);
                        showModal(LatLng(latitude, longitude));
                      },
                      leading: new Image.asset(
                        "assets/pin7.png",
                        width: 50.0,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      dense: true,
                      title: Text("Keelse Super Center"),
                      onTap: () {
                        setState(() {
                          pinurl = 'assets/pin9.png';
                          isloading = false;
                        });
                        Navigator.pop(context);
                        showModal(LatLng(latitude, longitude));
                      },
                      leading: new Image.asset(
                        "assets/pin9.png",
                        width: 50.0,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      dense: true,
                      title: Text("Keelse Super Center"),
                      onTap: () {
                        setState(() {
                          pinurl = 'assets/pin3.png';
                          isloading = false;
                        });
                        Navigator.pop(context);
                        showModal(LatLng(latitude, longitude));
                      },
                      leading: new Image.asset(
                        "assets/pin3.png",
                        width: 50.0,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      dense: true,
                      title: Text("Keelse Super Center"),
                      onTap: () {
                        setState(() {
                          pinurl = 'assets/pin10.png';
                          isloading = false;
                        });
                        Navigator.pop(context);
                        showModal(LatLng(latitude, longitude));
                      },
                      leading: new Image.asset(
                        "assets/pin10.png",
                        width: 50.0,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      dense: true,
                      title: Text("Keelse Super Center"),
                      onTap: () {
                        setState(() {
                          pinurl = 'assets/pin1.png';
                          isloading = false;
                        });
                        Navigator.pop(context);
                        showModal(LatLng(latitude, longitude));
                      },
                      leading: new Image.asset(
                        "assets/pin1.png",
                        width: 50.0,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      dense: true,
                      title: Text("Keelse Super Center"),
                      onTap: () {
                        setState(() {
                          pinurl = 'assets/pin2.png';
                          isloading = false;
                        });
                        Navigator.pop(context);
                        showModal(LatLng(latitude, longitude));
                      },
                      leading: new Image.asset(
                        "assets/pin2.png",
                        width: 50.0,
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text('Change your Map Icon',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: 400.0,
              child: Column(children: [
                isloading
                    ? CircularProgressIndicator()
                    : CircleAvatar(
                        radius: 50,
                        child: CircleAvatar(
                          radius: 50,
                          child: ClipRect(
                            child: Image.asset(
                              pinurl,
                              width: 70,
                              height: 70,
                            ),
                          ),
                          // backgroundImage: AssetImage(pinurl),
                          backgroundColor: Colors.white,
                          // backgroundColor: Colors.transparent,
                        ),
                      )

                // : image != null
                //     ? Image.file(
                //         image!,
                //         width: 260,
                //         fit: BoxFit.fill,
                //       )
                //     : Center(child: FlutterLogo(size: 100)),
              ]),
            ),
            ButtonTheme(
                minWidth: 200.0,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {
                    //streamController.add(1);
                    // Scaffold.of(context).openDrawer();
                    _addMarker(LatLng(latitude, longitude), pinurl);
                    Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => BookMarkScreen()),
                    // );
                  },
                  color: Colors.pink,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Save Marker"),
                )),
            Container(
              child: Center(
                child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galle',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 10,
                        // fontWeight: FontWeight.bold,
                        color: Colors.grey)),
              ),
            )
          ],
        ),
      );

  //-------------------show bottom modal-------------------------------------
  showModal(LatLng pos) {
    showModalBottomSheet(
        context: context,
        enableDrag: true, //drag option
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => buildSheeet(pos.latitude, pos.longitude));
  }

  //---------------get user location--------------------------------------------
  getLocation() async {
    Location location = new Location();
    LocationData _pos = await location.getLocation();
    setState(() {
      this._myLat = _pos.latitude!;
      this._myLang = _pos.longitude!;
    });
    _loadAllMarker();
    _addMarker(LatLng(_myLat, _myLang), 'assets/pin1.png');
  }

  //---------------------create marker-------------------------------------

  createIcon(dynamic userStr) async {
    print("============marker image======================");
    print(userStr);
    print("============marker image======================");
    await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(12, 12), devicePixelRatio: 1.0),
      userStr,
    ).then((value) => {
          setState(() {
            this.customIcon = value;
          })
        });
  }

  //---------------------load save markers--------------------------------------
  void _saveMarker(LocationModal modal) async {
    genid();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(pinID.toString(), json.encode(modal));
    _loadAllMarker();
  }

//---------------------load All  markers--------------------------------------
  _loadAllMarker() async {
    //_markers.clear();
    final prefs = await SharedPreferences.getInstance();
    //final counter = prefs.getString(key.toString()) ?? null;
    Map<String, dynamic> userMap = {};
    for (var i = 0; i <= markerCount; i++) {
      // ignore: unnecessary_question_mark
      String? userStr = prefs.getString(i.toString());

      if (userStr != null) {
        userMap = jsonDecode(userStr) as Map<String, dynamic>;

        print("======================load All Data========================");
        print(markerCount); //2
        print(_markers.length); //0
        setState(() {
          String id = userMap['id'];
          double lat = userMap['lat'];
          double lang = userMap['lang'];
          String titl = userMap['title'];
          String address = userMap['address'];
          dynamic markerurl = userMap['marker'];
          this.pinurl = markerurl[1];
          //pinurl = userMap['marker'];
          print(id);
          print(lat);
          print(lang);
          print(titl);
          print(address);
          print(markerurl[1]);
          createIcon(pinurl);
          this._markers.add(Marker(
              markerId: MarkerId(id),
              position: LatLng(lat, lang),
              infoWindow: InfoWindow(title: titl, snippet: address),
              //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
              icon: BitmapDescriptor.fromJson(markerurl)));
        });
      }
      print(markerCount); //2
      print(_markers.length); //0
    }

    print("======================load All Data========================");
  }

  //--------------------Genarate ID -----------------------
  genid() async {
    final prefs = await SharedPreferences.getInstance();
    dynamic id = prefs.getInt('markerid');
    if (id != null) {
      int x = id + 1;
      prefs.setInt('markerid', x);
      setState(() {
        pinID = x;
        markerCount = x - 1;
      });
    } else {
      prefs.setInt('markerid', 1);
    }
  }

  void getuserLocation() async {
    Location location = new Location();
    LocationData _pos = await location.getLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_pos.latitude!, _pos.longitude!),
        zoom: 18,
        tilt: 90,
        bearing: 40)));
  }
}

class Util {
  static String mapstyle = '''
  [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#523735"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#c9b2a6"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#dcd2be"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#ae9e90"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#93817c"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a5b076"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#447530"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#fdfcf8"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f8c967"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#e9bc62"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e98d58"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#db8555"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#806b63"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8f7d77"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#b9d3c2"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#92998d"
      }
    ]
  }
]
  
  ''';
}
