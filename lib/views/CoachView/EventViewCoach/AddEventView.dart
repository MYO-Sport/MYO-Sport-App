import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart' as stat;
import 'package:us_rowing/models/TimeModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/body/EventBody.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/DateTimeTextField.dart';
import 'package:us_rowing/widgets/EventInputField.dart';
import 'package:intl/intl.dart';
import 'package:us_rowing/widgets/PrimaryButton.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/SimpleToolbar.dart';

import '../../MapView.dart';
// import 'package:google_maps_place_picker/google_maps_place_picker.dart' as placePicker;

class AddEventView extends StatefulWidget {

  final String userId;
  final String creatorId;
  final String type;

  AddEventView({required this.userId,required this.creatorId,required this.type});

  @override
  _AddEventViewState createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {

  TextEditingController eventNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController timeZoneController = TextEditingController();
  TextEditingController locationDetailsController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();

  // String _hour = '', _minute = '', _time = '';
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String dateTime = '';
  late String selectedValue;
  double? latitude;
  double? longitude;

  List<stat.Marker> markers=[];
  List<stat.Location> locations=[];

  ImageProvider? mapImage;

  DateTime? startDateTime,endDateTime;

  bool isLoading=false;
  late EventBody eventBody;

  @override
  void initState() {
    super.initState();
    selectedValue = repeat[0];
  }

  @override
  Widget build(BuildContext context) {
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Stack(
      children: [
        Scaffold(
          backgroundColor: colorBackgroundLight,
          appBar: SimpleToolbar(title: 'Add Event'),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: EventInputField(
                    type: TextInputType.name,
                    text: 'Enter Event Name',
                    controller: eventNameController,
                    maxLength: 100,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: DateTimeTextField(
                    text: 'Start Date \& time',
                    enabled: false,
                    controller: dateController,
                    onTap: () async {
                      DateTime? date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      date = (await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100)));
                      if(date!=null){
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (picked != null)
                        {
                          /*setState(() {
                            selectedTime = picked;
                            _hour = selectedTime.hour.toString();
                            _minute = selectedTime.minute.toString();
                            _time = _hour + ' : ' + _minute;
                            timeController.text = _time;
                            timeController.text = formatDate(
                                DateTime(2019, 08, 1, selectedTime.hour,
                                    selectedTime.minute),
                                [hh, ':', nn, " ", am]).toString();
                          });*/
                          startDateTime=DateTime(date.year,date.month,date.day,picked.hour,picked.minute);
                          String dateFormatter = startDateTime!.toIso8601String();
                          DateTime dt = DateTime.parse(dateFormatter);
                          var formatter = new DateFormat('dd-MMMM-yyyy hh:mm a');
                          dateController.text = formatter.format(dt);
                        }

                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: DateTimeTextField(
                    text: 'End Date & Time',
                    enabled: false,
                    controller: timeController,
                    onTap: () async {
                      DateTime? date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      date = (await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100)));
                      if(date!=null){
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (picked != null)
                        {
                          endDateTime=DateTime(date.year,date.month,date.day,picked.hour,picked.minute);
                          String dateFormatter = endDateTime!.toIso8601String();
                          DateTime dt = DateTime.parse(dateFormatter);
                          var formatter = new DateFormat('dd-MMMM-yyyy hh:mm a');
                          timeController.text = formatter.format(dt);
                        }

                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: InkWell(
                    child: EventInputField(
                      enabled: false,
                      type: TextInputType.streetAddress,
                      text: 'Enter Location',
                      controller: locationDetailsController,
                    ),
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MapView())).then((value){
                        if(value is LatLng){
                          latitude=value.latitude;
                          longitude=value.longitude;
                          stat.Location location=stat.Location(latitude!, longitude!);
                          locations.add(location);
                          stat.Marker marker=stat.Marker(locations:locations);
                          markers.add(marker);
                          var mController= stat.StaticMapController(
                              googleApiKey: googleMapKey,
                              width: 1000,
                              height: 300,
                              zoom: 15,
                              center: stat.Location(latitude!, longitude!),
                              markers: markers
                          );
                          setState(() {
                            mapImage=mController.image;
                          });
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),

                mapImage==null?
                SizedBox():
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width*0.3,
                          decoration: BoxDecoration(
                              color: colorGrey,
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          child:
                          ClipRRect(borderRadius: BorderRadius.circular(8.0),child: Image(image: mapImage!,fit: BoxFit.fill,),)
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: EventInputField(
                    type: TextInputType.multiline,
                    text: 'Enter Description',
                    controller: eventDescriptionController,
                    maxLength: 2000,
                    maxLines: 6,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Repeat',
                        style: TextStyle(
                            color: colorGrey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 32.0),
                        child: DropdownButton(
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value.toString();
                            });
                          },
                          items: repeat.map((String valueItem) {
                            return new DropdownMenuItem<String>(
                              value: valueItem,
                              child: new Text(
                                valueItem,
                                style: TextStyle(color: colorGrey),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: PrimaryButton(
                    startColor: colorPrimary,
                    endColor: colorPrimary,
                    height: 50,
                      width: MediaQuery.of(context).size.width,
                      text: 'ADD EVENT', onPressed: () {
                    if(validate()){
                      addEvent();
                    }
                  }),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
        isLoading?
            SafeArea(child: Center(child: CircularProgressIndicator(),)):
            SizedBox()
      ],
    );
  }

  bool validate(){

    String name=eventNameController.text;
    String date=dateController.text;
    String strTime=timeController.text;
    String description=eventDescriptionController.text;

    if(name.isEmpty){
      MySnackBar.showSnackBar(context, 'Event Name is Required ');
      return false;
    }

    if(date.isEmpty){
      MySnackBar.showSnackBar(context, 'Start Date & Time is Required ');
      return false;
    }

    if(strTime.isEmpty){
      MySnackBar.showSnackBar(context, 'End Date & Time is Required ');
      return false;
    }

    if(latitude==null || longitude==null){
      MySnackBar.showSnackBar(context, 'Location is Required');
      return false;
    }

    if(description.isEmpty){
      MySnackBar.showSnackBar(context, 'Event Description is Required ');
      return false;
    }

    String strStart='';
    String strEnd='';

    strStart=startDateTime!.toUtc().toIso8601String();
    strEnd=endDateTime!.toUtc().toIso8601String();

    String strLat='$latitude';
    String strLng='$longitude';
    String strRepeat='Once';


    print("Start Date "+strStart);
    print("End Date "+strEnd);

    TimeModel time=TimeModel(value: '12:00', amOrPm: 'AM');
    if(widget.type == typeClub){
      eventBody=EventBody(name: name, date: date, startTime: time, endTime: time, status: '1', eventType: widget.type, description: description, createrId: widget.userId, timeZone: '', clubId: widget.creatorId,teamId: '',startDate: strStart,endDate: strEnd,lat: strLat,lng: strLng,repeat: strRepeat);
    }else if(widget.type== typeUsFeed){
      eventBody=EventBody(name: name, date: date, startTime: time, endTime: time, status: '3', eventType: widget.type, description: description, createrId: widget.userId, timeZone: '', clubId: '', teamId: '',startDate: strStart,endDate: strEnd,lat: strLat,lng: strLng,repeat: strRepeat);
    }else{
      eventBody=EventBody(name: name, date: date, startTime: time, endTime: time, status: '2', eventType: widget.type, description: description, createrId: widget.userId, timeZone: '', clubId: '', teamId: widget.creatorId,startDate: strStart,endDate: strEnd,lat: strLat,lng: strLng,repeat: strRepeat);
    }

    return true;
  }

  addEvent() async {

    print('User Id '+widget.userId);
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlAddEvent;

    final response = await http
        .post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(eventBody))
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      GeneralStatusResponse mResponse =
      GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          isLoading=false;
        });
        showToast('Event Added Successfully');
        Navigator.of(context).pop();
      } else {
        setState(() {
          isLoading=false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading=false;
      });
      MySnackBar.showSnackBar(context, 'Error' + 'Check Your Internet Connection');
    }
  }
}
