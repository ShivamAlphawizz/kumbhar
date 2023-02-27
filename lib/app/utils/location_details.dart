import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class GetLocation{
  LocationData? _currentPosition;

  late String _address = "";
  Location location1 = Location();
  String firstLocation = "",lat = "",lng = "";
  ValueChanged onResult;

  GetLocation(this.onResult);
  Future<void> getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location1.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location1.requestService();
      if (!_serviceEnabled) {
        print('ek');
        return;
      }
    }

    _permissionGranted = await location1.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location1.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('no');
        return;
      }
    }

    location1.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.latitude} : ${currentLocation.longitude}");
      _currentPosition = currentLocation;print(currentLocation.latitude);

      _getAddress(_currentPosition!.latitude,
          _currentPosition!.longitude)
          .then((value) {
        _address = "${value.first.addressLine}";
        firstLocation = value.first.subLocality.toString();
        print(_address);
        lat = _currentPosition!.latitude.toString();
        lng = _currentPosition!.longitude.toString();
        onResult(value);
        if(latitude!=value.first.coordinates.latitude){
          print("ok");

          updateLatLng(lat,lng);
        }

      });
    });
  }

  Future<List<Address>> _getAddress(double? lat, double? lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }
  updateLatLng(lat,lng) async {
    Map param = {};
    param['user_id'] = curUserId;
    param['lat'] = lat.toString();
    param['lang'] = lng.toString();
    print(param);
    var res =
    await http.post(Uri.parse(baseUrl + "update_profile"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    if (response['status'].toString() == "1") {

    } else {}

  }

}