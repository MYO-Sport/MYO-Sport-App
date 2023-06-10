

import 'dart:async';


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:geocoding/geocoding.dart';

class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {

  double latitude=37.42796133580664,longitude=-122.085749655962;

  Completer<GoogleMapController> _controller = Completer();

  String address='';
  TextEditingController textController = TextEditingController();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    findAddress();
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (position){
              print('Camera is moved');
              setState(() {
                latitude=position.target.latitude;
                longitude=position.target.longitude;
              });
            },
            onCameraIdle: (){
              findAddress();
            },
            onTap: (latlng){
              setState(() {
                latitude=latlng.latitude;
                longitude=latlng.longitude;
              });
              animateCamera(latlng.latitude, latlng.longitude);

            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
            child: InkWell(
              child: Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: colorWhite
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Search Place',
                      style: TextStyle(color: colorGrey),
                    ),
                    Container(
                        width: 30.0,
                        height: 30.0,
                        child: Icon(
                          Icons.search,
                          color: colorGrey,
                        )),
                  ],
                ),
              ),
              onTap: () {
                // autoCompleteSearch();
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(address),
                  Icon(Icons.add_location,color:Colors.red,size: 24,),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pop(LatLng(latitude, longitude));
        },
        child: Icon(Icons.check),
      ),
    );
  }

  Future<void> animateCamera(double lat,double lng) async {

    final CameraPosition _kLake = CameraPosition(
        target: LatLng(lat, lng),
        zoom: 14.4746);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

/*   autoCompleteSearch() async{
    Prediction? p = await PlacesAutocomplete.show(
      types: [],
      strictbounds: false,
      context: context,
      apiKey: googleMapKey,
      onError: onError,
      mode: Mode.overlay,
      language: "en",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "us")],
    );

    // displayPrediction(p!);
  }
 */
  findAddress() async{
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    var first = placemarks.first;
    setState(() {
      address="${first.thoroughfare}";
    });
  }

/* 
  Future<Null> displayPrediction(Prediction p) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: googleMapKey,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);
    // final lat = detail.result.geometry!.location.lat;
    // final lng = detail.result.geometry!.location.lng;

    animateCamera(detail.result.geometry!.location.lat, detail.result.geometry!.location.lng);
  } */

 /*  void onError(PlacesAutocompleteResponse response) {
    print(response.errorMessage);
    print(response.predictions);
    print(response.toJson());
  } */
}