import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Map<String, dynamic> setGeoPoint(GeoPoint point) {
  final geoPoint = GeoFlutterFire();
  return geoPoint
      .point(latitude: point.latitude, longitude: point.longitude)
      .data;
}

Future<List<String>> getDistanceTimeAR(LatLng srcs, LatLng dest) async {
  final Response response = await Dio().get(
      'https://maps.googleapis.com/maps/api/distancematrix/json',
      queryParameters: {
        'origins': dest.latitude.toString() + ',' + dest.longitude.toString(),
        'destinations':
            srcs.latitude.toString() + ',' + srcs.longitude.toString(),
        'mode': 'walking',
        'key': 'AIzaSyA7hFWktlCsXxOn_U_pnyzJHkqS0k-F7WE'
      });
  if (response.statusCode == 200) {
    return [
      response.data['rows'][0]['elements'][0]['distance']['text'],
      response.data['rows'][0]['elements'][0]['duration']['text'],
    ];
  } else {
    return ['N.A.', 'N.A.'];
  }
}
