import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModal {
  final String id;
  final double lat;
  final double lang;
  final String title;
  final String address;
  final BitmapDescriptor marker;

  LocationModal(
      {required this.id,
      required this.lat,
      required this.lang,
      required this.title,
      required this.address,
      required this.marker});

  LocationModal.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        lat = json['lat'],
        lang = json['lang'],
        title = json['title'],
        address = json['address'],
        marker = json['marker'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'lat': lat,
        'lang': lang,
        'title': title,
        'address': address,
        'marker': marker,
      };
}
