import 'dart:async';
import 'dart:math';

import 'package:eko_sortify_app/helper/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(11.9416, 79.8083);
  static const LatLng _location1 = LatLng(11.9300, 79.8083);
  static const LatLng _center1 = LatLng(11.947972, 79.810687);
  static const LatLng _center2 = LatLng(11.943116949529665, 79.81429366830146);
  static const LatLng _center3 = LatLng(11.944048609977814, 79.78307893337548);
  static const LatLng _center4 = LatLng(11.894807932859102, 79.71628891876169);
  static const LatLng _center5 = LatLng(11.917491991375853, 79.65636571016417);
  LatLng? _currentP;

  BitmapDescriptor? _customMarkerIcon; // Define _customMarkerIcon here

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    _setCustomMarkerIcon(); // Initialize the custom marker icon
    getLocationUpdates().then((_) {
      getPolylinePoints().then((coordinates) {
        generatePolyLineFromPoints(coordinates);
      });
    });
  }

  Future<void> _setCustomMarkerIcon() async {
    final BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)), // Adjust the size here
      'assets/images/recycle_center_icon.png', // Path to your marker image
    );
    setState(() {
      _customMarkerIcon = markerIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? Center(
              child: CircleAvatar(
                radius: 90,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.pin_drop,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            )
          : GoogleMap(
              onMapCreated: (GoogleMapController controller) => _mapController.complete(controller),
              initialCameraPosition: CameraPosition(
                target: _pGooglePlex,
                zoom: 10,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentP!,
                ),
                Marker(
                  markerId: MarkerId("Center1"),
                  icon: _customMarkerIcon ?? BitmapDescriptor.defaultMarker, // Use the custom marker icon
                  position: _center1,
                ),
                Marker(
                  markerId: MarkerId("Center2"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _center2,
                ),
                Marker(
                  markerId: MarkerId("Center3"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _center3,
                ),
                Marker(
                  markerId: MarkerId("Center4"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _center4,
                ),
                Marker(
                  markerId: MarkerId("Center5"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _center5,
                ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 17);
    await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Check if the location service is enabled
    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return; // If the user doesn't enable the service, exit the function
      }
    }

    // Check if the app has location permission
    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return; // If the permission is not granted, exit the function
      }
    }

    // Listen to location changes
    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentP = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
          _cameraToPosition(_currentP!);
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polyLineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
      PointLatLng(_location1.latitude, _location1.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polyLineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polyLineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Theme.of(context).colorScheme.secondary,
      points: polyLineCoordinates,
      width: 8,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }
}
