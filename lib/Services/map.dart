import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../Controllers/LocationPermission.dart';
import '../Controllers/LocationProvider.dart';
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

  void submitAddress(BuildContext context) {
    String? address;

    // Check if the searchController has a non-empty text
    if (searchController.text.isNotEmpty) {
      address = searchController.text;
    } else {
      // Trigger the address and postal code fetch and use the current values
      context.read<LocationAddressProvider>().fetchAddressFromLocation(
        context.read<LocationPermission>().currentLocation!.latitude,
        context.read<LocationPermission>().currentLocation!.longitude,
      );

      address = context.read<LocationAddressProvider>().address;
    }

    // Update the address and postal code in the provider
    context.read<LocationAddressProvider>().updateAddress(address!);

    // Show a snackbar
    _showSnackbar(context, 'Address submitted successfully');

    // Clear the text field
    searchController.clear();
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xff0E6B56),
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  //setMarkers
  final Set<Marker> _markers = <Marker>{};

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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
             context.go('/Items');
            },
          ),
          title: const Text("Search Locations"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 76.h,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.black,
                  onChanged: (value) {
                    print(value);
                  },
                  textCapitalization: TextCapitalization.words,
                  controller: searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    hintText: "Search places...",
                    suffixIcon: IconButton(
                        onPressed: () async {
                          var place = await LocationService()
                              .getPlace(searchController.text.trim());
                          _goToPlace(place);
                        },
                        icon: const Icon(Icons.search,color: Colors.red,)),
                    enabledBorder: const OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        )),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.7,
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  markers: _markers,
                  initialCameraPosition: _goToPosn(latitude!, longitude!),
                  onMapCreated: (GoogleMapController controller) =>
                      _controller.complete(controller),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: (){
                    submitAddress(context);
                }, child: const Text("Confirm Location",style: TextStyle(fontSize: 15),)
                ),
              ),
            ),],
        ),
        floatingActionButton: Align(
          alignment: const Alignment(0.99, 0.75),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(_goToPosn(latitude!, longitude!)));
            },
            child: const Icon(Icons.location_on_rounded,color: Colors.red,),
          ),
        ));
  }
}
