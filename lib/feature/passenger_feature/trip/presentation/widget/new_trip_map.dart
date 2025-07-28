import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servi_drive/core/resource/color_manager.dart';

class NewTripMap extends StatefulWidget {
  final bool isReadOnly;
  final LatLng? fromLocation;
  final LatLng? toLocation;

  const NewTripMap({
    super.key,
    this.isReadOnly = false,
    this.fromLocation,
    this.toLocation,
  });

  @override
  State<NewTripMap> createState() => _NewTripMapState();
}

class _NewTripMapState extends State<NewTripMap> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _startMarker;
  LatLng? _endMarker;
  bool _selectingStart = true;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    if (widget.isReadOnly) {
      _startMarker = widget.fromLocation;
      _endMarker = widget.toLocation;
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(
      LatLng(position.latitude, position.longitude),
    ));
  }

  void _onMapTap(LatLng latLng) {
    if (widget.isReadOnly) return;
    setState(() {
      if (_startMarker == null ||
          (_startMarker != null && _endMarker != null)) {
        _startMarker = latLng;
        _endMarker = null;
        _selectingStart = false;
      } else if (_endMarker == null) {
        _endMarker = latLng;
        _selectingStart = true;
      }
    });
  }

  Set<Marker> _buildMarkers() {
    final Set<Marker> markers = {};
    if (_startMarker != null) {
      markers.add(Marker(
        markerId: const MarkerId('start'),
        position: _startMarker!,
        infoWindow: const InfoWindow(title: 'From Location'),
      ));
    }
    if (_endMarker != null) {
      markers.add(Marker(
        markerId: const MarkerId('end'),
        position: _endMarker!,
        infoWindow: const InfoWindow(title: 'To Location'),
      ));
    }
    return markers;
  }

  Set<Polyline> _buildPolylines() {
    return {};
  }

  @override
  Widget build(BuildContext context) {
    LatLng initialTarget;
    if (widget.isReadOnly && _startMarker != null) {
      initialTarget = _startMarker!;
    } else if (_currentPosition != null) {
      initialTarget =
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    } else {
      initialTarget = const LatLng(22, 22);
    }
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: initialTarget,
            zoom: 14,
          ),
          myLocationEnabled: !widget.isReadOnly,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          markers: _buildMarkers(),
          polylines: _buildPolylines(),
          onMapCreated: (controller) => _controller.complete(controller),
          onTap: _onMapTap,
        ),
        if (!widget.isReadOnly)
          Positioned(
            top: 16,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: AppColorManager.lightMainColor,
              onPressed: _getCurrentLocation,
              child: const Icon(Icons.my_location, color: Colors.white),
            ),
          ),
      ],
    );
  }
}
