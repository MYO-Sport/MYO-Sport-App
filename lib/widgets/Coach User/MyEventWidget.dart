import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:image_stack/image_stack.dart';
import 'package:intl/intl.dart';
import 'package:us_rowing/models/EventAttendantModel.dart';
import 'package:us_rowing/models/EventModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/CoachView/EventViewCoach/AthleteEventInformation.dart';
import 'package:us_rowing/views/CoachView/EventViewCoach/EventDetail.dart';
import 'package:us_rowing/widgets/EventButton.dart';
import 'package:http/http.dart' as http;
import 'package:google_static_maps_controller/google_static_maps_controller.dart';

import '../CachedImage.dart';

class MyEventWidget extends StatefulWidget {
  final EventModel event;
  final String userId;
  final String userType;
  final int status;

  MyEventWidget(
      {required this.event,
      required this.userId,
      required this.userType,
      required this.status});

  @override
  _MyEventWidgetState createState() => _MyEventWidgetState();
}

class _MyEventWidgetState extends State<MyEventWidget> {
  late int status;
  bool isLoading = false;

  List<String> images = [];

  List<Marker> markers = [];
  List<Location> locations = [];

  String cStatus = statUpcoming;

  var mController;

  late ImageProvider mapImage;

  late double latitude;
  late double longitude;

  bool loadingDependents = true;

  String address = '';

  @override
  void initState() {
    super.initState();
    status = widget.status;
    if (widget.event.location.coordinates.length > 1) {
      latitude = widget.event.location.coordinates[0];
      longitude = widget.event.location.coordinates[1];
    } else {
      latitude = 0;
      longitude = 0;
    }
    print('latitude: $latitude');
    print('longitude: $longitude');
    Location location = Location(latitude, longitude);
    locations.add(location);
    Marker marker = Marker(locations: locations);
    markers.add(marker);
    mController = StaticMapController(
        googleApiKey: googleMapKey,
        width: 1000,
        height: 300,
        zoom: 15,
        center: Location(latitude, longitude),
        markers: markers);
    mapImage = mController.image;
    findAddress();
    getStatus(widget.event.startDate, widget.event.endDate);
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Material(
          color: colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: colorGrey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0))),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0)),
                      child: Image(
                        image: mapImage,
                        fit: BoxFit.fill,
                      ))),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CachedImage(
                      padding: 0,
                      imageHeight: 40,
                      imageWidth: 40,
                      radius: 100,
                      image: widget.event.createrInfo.length > 0
                          ? ApiClient.baseUrl +
                              widget.event.createrInfo[0].profileImage
                          : '',
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.event.createrInfo.length == 0
                                  ? ''
                                  : widget.event.createrInfo[0].username,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: colorBlack,
                              ),
                              maxLines: 1,
                            ),
                            Text(
                              widget.event.createrInfo.length == 0
                                  ? ''
                                  : widget.event.createrInfo[0].type,
                              style: TextStyle(
                                  fontSize: 10.0, color: colorTextSecondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 24,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: cStatus == statComplete
                              ? colorGreen
                              : colorPrimary),
                      child: Center(
                        child: Text(
                          cStatus,
                          style: TextStyle(color: colorWhite, fontSize: 10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: colorBlue,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        '${getFormattedDate(widget.event.startDate)} - ${getFormattedDate(widget.event.endDate)}',
                        style:
                            TextStyle(color: colorTextSecondary, fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: colorBlue,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      address,
                      style: TextStyle(color: colorTextSecondary, fontSize: 12),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.event.name,
                  style: TextStyle(color: colorBlack, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.event.description,
                  style: TextStyle(color: colorTextSecondary, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Going',
                  style: TextStyle(color: colorBlack, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: loadingDependents
                    ? Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : images.length == 0
                        ? Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                'No Attendants Yet',
                                style:
                                    TextStyle(color: colorGrey, fontSize: 12),
                              ),
                            ),
                          )
                        : InkWell(
                            child: ImageStack(
                              imageList: images,
                              totalCount: images.length,
                              // If larger than images.length, will show extra empty circle
                              imageRadius: 25,
                              // Radius of each images
                              imageCount: 3,
                              // Maximum number of images to be shown in stack
                              imageBorderWidth:
                                  0, // Border width around the images
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AthleteEventInformation(
                                            eventId: widget.event.sId,
                                          )));
                            },
                          ),
              ),
              widget.userType == typeAthlete
                  ? Column(
                      children: [
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            EventButton(
                                icon: Icons.star,
                                text: 'Interested',
                                onPressed: () {
                                  addEvent(2);
                                },
                                checked: status == 2),
                            EventButton(
                                icon: Icons.check_circle,
                                text: 'Going',
                                onPressed: () {
                                  addEvent(1);
                                },
                                checked: status == 1),
                            EventButton(
                                icon: Icons.dangerous,
                                text: 'May Be',
                                onPressed: () {
                                  addEvent(3);
                                },
                                checked: status == 3),
                          ],
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventDetail(
                      status: status,
                      userId: widget.userId,
                      userType: widget.userType,
                      event: widget.event,
                      mapImage: mapImage,
                      address: address,
                      completeStatus: cStatus,
                      onChange: (int newStatus) {
                        setState(() {
                          status = newStatus;
                        });
                      },
                    )));
      },
    );
  }

  String getDate() {
    if (widget.event.date.isNotEmpty) {
      DateTime dateTime = DateTime.parse(widget.event.date);
      return dateTime.day.toString();
    } else {
      return '-';
    }
  }

  String getDay() {
    if (widget.event.date.isNotEmpty) {
      DateTime dateTime = DateTime.parse(widget.event.date);
      return DateFormat('EEEE').format(dateTime);
    } else {
      return '';
    }
  }

  addEvent(int newStatus) async {
    print('User Id ' + widget.userId);
    setState(() {
      isLoading = true;
    });

    String flag;
    if (status == 1 || status == 2 || status == 3) {
      flag = '1';
    } else {
      flag = '0';
    }

    String apiUrl = ApiClient.urlSubEvent;

    final response = await http.post(Uri.parse(apiUrl), body: {
      'event_id': widget.event.sId,
      'user_id': widget.userId,
      'status': '$newStatus',
      'flag': flag
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      GeneralStatusResponse mResponse =
          GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          status = newStatus;
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, mResponse.message);
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error' + 'Check Your Internet Connection');
    }
  }

  declineEvent(String flag) async {
    print('User Id ' + widget.userId);
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlSubEvent;

    final response = await http.post(Uri.parse(apiUrl), body: {
      'event_id': widget.event.sId,
      'user_id': widget.userId,
      'status': '2',
      'flag': flag
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      GeneralStatusResponse mResponse =
          GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          status = 2;
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Event is Declined');
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error' + 'Check Your Internet Connection');
    }
  }

  findAddress() async {
    List<geo.Placemark> placemarks =
        await geo.placemarkFromCoordinates(latitude, longitude);
    var first = placemarks.first;
    setState(() {
      address = '${first.locality},${first.country}';
    });
  }

  String getFormattedDate(String str) {
    if (str.isEmpty) {
      return '';
    }
    DateTime dt = DateTime.parse(str);
    var formatter = new DateFormat('dd MMM yyyy hh:mm a');
    return formatter.format(dt);
  }

  getStatus(String start, String end) {
    if (start.isEmpty || end.isEmpty) {
      setState(() {
        cStatus = statComplete;
      });
      return;
    }
    DateTime startDate = DateTime.parse(start);
    DateTime endDate = DateTime.parse(end);
    DateTime now = DateTime.now().toUtc();
    if (now.isAfter(startDate) && now.isBefore(endDate)) {
      setState(() {
        cStatus = statHappening;
      });
    } else if (now.isAfter(endDate)) {
      setState(() {
        cStatus = statComplete;
      });
    } else {
      setState(() {
        cStatus = statUpcoming;
      });
    }
  }

  getImages() {
    if (widget.event.attendants.length == 0) {
      setState(() {
        loadingDependents = false;
      });
    } else {
      for (EventAttendantModel att in widget.event.attendants) {
        images.add(ApiClient.baseUrl + att.userProfileImage);
      }
      setState(() {
        loadingDependents = false;
      });
    }
  }
}
