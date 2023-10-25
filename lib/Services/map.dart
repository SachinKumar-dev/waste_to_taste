import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'Location_services.dart';

class MapSample extends StatefulWidget {
  double? latitude;
  double? longitude;
  MapSample({required this.latitude,required this.longitude,super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  TextEditingController searchController = TextEditingController();

  final Completer<GoogleMapController> _controller = Completer();

  //setMarkers
  Set<Marker> _markers = Set<Marker>();

  @override
  void initState() {
    setMarker( LatLng(widget.latitude!, widget.longitude!));
    _setMarker(const LatLng(23.3441, 85.3096));
    super.initState();
  }

  _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(markerId: const MarkerId('marker'), position: point),
      );
    });
  }

  void setMarker(LatLng point) {
    const MarkerId markerId = MarkerId('fixed_location');
    final Marker marker = Marker(
      markerId: markerId,
      position: point,
      infoWindow: const InfoWindow(title: 'Fixed Location'),
    );

    setState(() {
      _markers.add(marker);
    });
  }


  // set coordinates
  CameraPosition _goToPosn(double latitude, double longitude) {
    return CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 12,
    );
  }

  //get newPlace CameraPosition
  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));
    _setMarker(LatLng(lat, lng));
  }

  @override
  Widget build(BuildContext context) {
    double? latitude = widget.latitude;
    double? longitude = widget.longitude;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Google Maps"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 60.h,
              width: double.infinity,
              child: TextFormField(
                onChanged: (value) {
                  print(value);
                },
                textCapitalization: TextCapitalization.words,
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search places...",
                  suffixIcon: IconButton(
                      onPressed: () async {
                        var place = await LocationService()
                            .getPlace(searchController.text.trim());
                        _goToPlace(place);
                      },
                      icon: const Icon(Icons.search)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xff0E6B56),
                        width: 2,
                      )),
                ),
              ),
            ),
            Expanded(
              child: GoogleMap(
                zoomControlsEnabled: false,
                markers: _markers,
                initialCameraPosition: _goToPosn(latitude!, longitude!),
                onMapCreated: (GoogleMapController controller) =>
                    _controller.complete(controller),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () async {
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(_goToPosn(latitude!, longitude!)));
          },
          child: const Icon(Icons.location_on_rounded,color: Colors.red,),
        ));
  }
}
