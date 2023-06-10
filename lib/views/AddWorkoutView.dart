import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:us_rowing/models/WorkoutsModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/WorkOutResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/AddWorkoutWidget.dart';

class AddWorkoutView extends StatefulWidget {
  @override
  _AddWorkoutViewState createState() => _AddWorkoutViewState();
}

class _AddWorkoutViewState extends State<AddWorkoutView> {
  late List<WorkoutsModel> workOuts = [];
  bool isLoading = true;



  @override
  void initState() {
    super.initState();
    getWorkOuts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
            color: colorPrimary,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 70.0, left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: colorWhite,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'ADD WORKOUTS',
                  style: TextStyle(
                      color: colorWhite,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0),
                ),
                Icon(
                  Icons.arrow_back_ios,
                  color: colorWhite.withOpacity(0),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                isLoading
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Center(child: CircularProgressIndicator()))
                    : workOuts.length == 0
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Center(
                                child: Text(
                              'No WorkOuts',
                              style: TextStyle(color: colorGrey),
                            )))
                        : ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: workOuts.length,
                            itemBuilder: (context, index) {
                              WorkoutsModel workOut = workOuts[index];
                              return AddWorkoutWidget(
                                workoutId: workOut.sId,
                                workoutName: workOut.workoutName,
                                image: workOut.workoutImage,
                                activities: workOut.activities,
                              );
                            },
                          ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getWorkOuts() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetAllWorkOuts;

    final response = await http
        .post(
      Uri.parse(apiUrl),
    )
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;

      WorkOutResponse mResponse =
          WorkOutResponse.fromJson(json.decode(responseString));
      print(mResponse);
      if (mResponse.status) {
        setState(() {
          workOuts = mResponse.workouts;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }
}
