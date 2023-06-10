import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/PlayerModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/CoachAthletesResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/AthInClubWidget.dart';
import 'package:us_rowing/widgets/InputFieldSuffix.dart';
import 'package:http/http.dart' as http;

class AthletesFragment extends StatefulWidget {
  final bool isBack;

  AthletesFragment({this.isBack = true});

  @override
  _AthletesFragmentState createState() => _AthletesFragmentState();
}

class _AthletesFragmentState extends State<AthletesFragment> {


  bool isLoading = true;
  List<PlayerModel> showPlayer = [];
  List<PlayerModel> players = [];

  late String userId;

  @override
  void initState() {
    super.initState();
    getUser().then((value) {

      setState(() {
        userId=value.sId;
      });
      getCoachAthletes(value.sId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
              color: colorPrimary,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 60.0, left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.isBack
                      ? InkWell(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: colorWhite,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      : SizedBox(width: 24,),
                  Text(
                    'Athletes',
                    style: TextStyle(
                        color: colorWhite,
                        fontSize: 24.0,
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            InputFieldSuffix(
              text: 'Search for Clubs . . .',
              suffixImage: 'assets/images/filter-icon-for-bar.png',
              onChange: onSearch,
            ),
            SizedBox(
              height: 8.0,
            ),
            Flexible(
              child:
              isLoading?
              Center(child: CircularProgressIndicator(),):
              showPlayer.length==0?
              Center(child: Text('No Data Found'),) :
              ListView.builder(
                itemCount: showPlayer.length,
                itemBuilder: (BuildContext context, int index) {
                  PlayerModel player=showPlayer[index];
                  return AthInClubWidget(player: player,userId: userId,);
                },
              ),
            )
          ],
        ));
  }

  getCoachAthletes(String userId) async {
    setState(() {
      isLoading = true;
    });


    String apiUrl = ApiClient.urlGetCoachAthletes;
    print('coachId: '+userId);
    print('url: '+ApiClient.urlGetCoachAthletes);
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
      CoachAtheltetesResponse mResponse =
      CoachAtheltetesResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          players = mResponse.players;
          showPlayer.addAll(players);
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
      showPlayer.clear();
      for(PlayerModel athlete in players){
        if(athlete.clubName.toLowerCase().contains(text.toLowerCase())){
          showPlayer.add(athlete);
        }
      }
      setState(() {});
    }else{
      showPlayer.clear();

      setState(() {
        showPlayer.addAll(players);
      });
    }
  }

}
