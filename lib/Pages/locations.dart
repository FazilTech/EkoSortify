import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  static const _inititalCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );
  static const LatLng _center1 = LatLng(11.947972, 79.810687);
  static const LatLng _center2 = LatLng(11.943116949529665, 79.81429366830146);
  static const LatLng _center3 = LatLng(11.944048609977814, 79.78307893337548);
  static const LatLng _center4 = LatLng(11.894807932859102, 79.71628891876169);
  static const LatLng _center5 = LatLng(11.917491991375853, 79.65636571016417);

  BitmapDescriptor? _customMarkerIcon;

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  late GoogleMapController _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Location _locationController = Location();
  LatLng? _currentP;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
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
      appBar: AppBar(
        centerTitle: false,
        title: const Text("RECYCLE CENTERS"),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.background,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text("ORIGIN"),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.background,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text("DESTINATION"),
            ),
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _inititalCameraPosition,
        onMapCreated: (controller) {
          _mapController.complete(controller);
          _googleMapController = controller;
        },
        markers: {
          if (_origin != null) _origin!,
          if (_destination != null) _destination!,
          if (_currentP != null)
            Marker(
              markerId: const MarkerId("_currentLocation"),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              position: _currentP!,
            ),
            Marker(
                  markerId: MarkerId("Center1"),
                  icon:  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen), // Use the custom marker icon
                  position: _center1,
                ),
            Marker(
                  markerId: MarkerId("Center2"),
                  icon:  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                  position: _center2,
                ),
             Marker(
                  markerId: MarkerId("Center3"),
                  icon:  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                  position: _center3,
                ),
             Marker(
                  markerId: MarkerId("Center4"),
                  icon:  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                  position: _center4,
                ),
             Marker(
                  markerId: MarkerId("Center5"),
                  icon:  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                  position: _center5,
                ),
        },
        onLongPress: _addMarker,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => _currentP,
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker(LatLng pos) {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          position: pos,
        );
        _destination = null;
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });
    }
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
}
