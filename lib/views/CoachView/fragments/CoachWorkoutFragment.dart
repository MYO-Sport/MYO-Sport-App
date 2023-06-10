import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/AthleteModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/CoachWorkoutResponse.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/AthleteWidget.dart';
import 'package:us_rowing/widgets/InputFieldSuffix.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class CoachWorkoutFragment extends StatefulWidget {

  final bool isBack;

  const CoachWorkoutFragment({this.isBack = true});

  @override
  _CoachWorkoutFragmentState createState() => _CoachWorkoutFragmentState();
}

class _CoachWorkoutFragmentState extends State<CoachWorkoutFragment> {
  bool isLoading = true;
  List<AthleteModel> showAthletes = [];
  List<AthleteModel> athletes = [];

  late String userId;

  @override
  void initState() {
    super.initState();
    getUser().then((value) {
      setState(() {
        userId=value.sId;
      });
      getCoachWorkouts(value.sId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SimpleToolbar(title: 'Workouts',isBack: false,),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            InputFieldSuffix(
              text: 'Search here . . .',
              suffixImage: 'assets/images/filter-icon-for-bar.png',
              onChange: onSearch,
            ),
            Flexible(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : showAthletes.length == 0
                      ? Center(
                          child: Text('No Members Found'),
                        )
                      : GridView.builder(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          itemCount: showAthletes.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1),
                          itemBuilder: (BuildContext context, int index) {
                            AthleteModel athlete=showAthletes[index];
                            return AthleteWidget(name: athlete.username,image: athlete.profileImage,email: athlete.email,id: athlete.sId,userId: userId,);
                          },
                        ),
            )
          ],
        ));
  }

  getCoachWorkouts(String userId) async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetCoachWorkouts;

    final response = await http.post(Uri.parse(apiUrl),
        body: {'coach_id': userId}).catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      CoachWorkoutResponse mResponse =
          CoachWorkoutResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          athletes = mResponse.athletes;
          showAthletes.addAll(athletes);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading=false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }

  onSearch(String text){
    if(text.isNotEmpty){
      showAthletes.clear();
      for(AthleteModel athlete in athletes){
        if(athlete.username.toLowerCase().contains(text.toLowerCase())){
          showAthletes.add(athlete);
        }
      }
      setState(() {});
    }else{
      showAthletes.clear();

      setState(() {
        showAthletes.addAll(athletes);
      });
    }
  }
}
